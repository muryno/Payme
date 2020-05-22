//
//  Request.swift
//  SchoolSystem
//
//  Created by Muraino Yakubu on 1/29/20.
//  Copyright © 2020 Muraino Yakubu. All rights reserved.
//

import Foundation
import UIKit


class Request {
    let get = "GET"
    let post = "POST"
    func getResponse<T>(url:String,parameters:[String:Any],httpMethod:HTTPMethod,completionHandler:  @escaping (Results<T>) -> Void) where T : Codable  {
        
        
        if let url = URL(string: BaseUrl(url: url)) {
            var request = URLRequest(url: url)
            
            //SET REQUEST FOR GET
            switch httpMethod {
            case .post:
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                request.httpMethod = httpMethod.rawValue
                request.httpBody = parameters.percentEncoded()
                break
                
            case .get:
                let parameterString = parameters.stringFromHttpParameters()
                let url = URL(string: "\(url)?\(parameterString)")!
                request = URLRequest(url: url)
                request.httpMethod = httpMethod.rawValue
                request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
                break
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
             guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
              
                print("error", error ?? "Unknown error")
                  completionHandler(.failure(error!) )
                return
               }
                               
          guard (200 ... 299) ~= response.statusCode else {
                // check for http errors
               print("statusCode should be 2xx, but is \(response.statusCode)")
            print("response = \(response)")
                  return
       }
                   do{
                    let data = try JSONDecoder().decode(T.self, from: data)
                
                    print(data) //whole project
                  
                    completionHandler(.success(data) )
                     
                   }catch let serializationError{
                   
                    completionHandler(.failure(serializationError) )
                }
                                              
                               
            }
            task.resume()
        }
    }
    init() {
        print("init \(#function)")
    }
    deinit {
        print("deinit \(#function)")
    }
    
    
    func POST<T>(url:String,parameters:[String:Any],completionHandler: @escaping (Results<T>) -> Void) where T : Codable {
        if let url = URL(string: BaseUrl(url: url)) {
            var request = URLRequest(url: url)
            request.httpMethod = post
            let header = Request.getMultipartCommonHeader()
            for (key,value) in header {
                request.setValue(value, forHTTPHeaderField: key)
            }
            request.httpBody = getParamData(params: parameters)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                    print("error", error ?? "Unknown error")
                    completionHandler(.failure(error!) )
                    return
                }
                
                guard (200 ... 299) ~= response.statusCode else {
                    // check for http errors
                    print("statusCode should be 2xx, but is \(response.statusCode)")
                    print("response = \(response)")
                   // completionHandler(.status())
                    return
                }
                do{
                    let data = try JSONDecoder().decode(T.self, from: data)
                                   
                    print(data) //whole project
                                
                  completionHandler(.success(data) )
                                   
                   }catch let serializationError{
                                   
                    completionHandler(.failure(serializationError) )
                }
                               
                
            
                
            }
            task.resume()
        }
    }
    
    class func getMultipartCommonHeader() -> [String:String] {
        let boundary = "--------------------------f98e103630d0f2c3"
        var headers: [String:String] = [:]
        headers["Authorization"] = "Basic dGVzdDp0ZXN0"
        headers["Content-Type"] = String(format: "multipart/form-data; boundary=%@", boundary)
        headers["Accept"] = "*/*"
        headers["Cache-Control"] = "no-cache"
        return headers
    }
    
    
    func getParamData(params:[String:Any]) -> Data {
        var body = Data()
        var str = ""
        let boundary = "--------------------------f98e103630d0f2c3"
        for (key,value) in params {
            str = String(format: "--%@\r\n", boundary)
            body.append(str.data(using: String.Encoding.utf8)!)
            if value is Data, let imageData = value as? Data {
                str = String(format: "Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",
                             key, "picture_data")
                body.append(str.data(using: String.Encoding.utf8)!)
                str = "Content-Type: application/octet-stream\r\n\r\n"
                body.append(str.data(using: String.Encoding.utf8)!)
                body.append(imageData)
                str = "\r\n"
                body.append(str.data(using: String.Encoding.utf8)!)
            }
            else if let paramValue = value as? String {
                str = String(format: "Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key)
                body.append(str.data(using: String.Encoding.utf8)!)
                str = String(format: "%@\r\n", paramValue)
                body.append(str.data(using: String.Encoding.utf8)!)
            }
        }
        str = String(format: "--%@--\r\n", boundary)
        body.append(str.data(using: String.Encoding.utf8)!)
        return body
    }
}


func BaseUrl( url: String)->String{
    let er = "https://api.connectrail.net/"+url
    return er
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

