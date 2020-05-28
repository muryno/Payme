//
//  LoginPresenter.swift
//  Intacter
//
//  Created by Muraino Yakubu on 5/23/20.
//  Copyright © 2020 Muraino Yakubu. All rights reserved.
//

import Foundation
import Alamofire
import Firebase



class LoginPresenter {
    var callBack : LoginView
    init(_ cllBack : LoginView) {
        self.callBack = cllBack
    }
    
    func inValidateLogin(email : String, passwrd : String){
        
        callBack.Loading()
        
        if email == ""{
            callBack.invalidateEmail(email: "Kindly provide your email! ")
            return
        }
        
        if passwrd == ""{
            callBack.invalidatePassword(password: "Kindly provide your password! ")
           return
      }
              
        
        
    
        
        let parameters : Parameters = ["email":email, "password":passwrd]
        


        AF.request(URL.init(string: Utils.BaseUrl(url: "user/login"))!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: Utils.Header()).responseDecodable(of: UserBase.self) { (response) in
            
            switch response.result {

                
            case .success(_) :
                   guard let user = response.value else { return }
                   
                if !user.error &&  user.data != nil {
                     MemoryManager().saveUser(usr: user.data!)
        //          print(films.data)
  
                                   if (user.data?.is_hod! == "1"){
                                       Messaging.messaging().subscribe(toTopic:((user.data?.department)?.uppercased())!) { error in
                                            print("SEE ERROR \(error as Any)")
                                       }
                                   }
                                   if (user.data?.is_mgt! == "1"){
                                       Messaging.messaging().subscribe(toTopic:"MANAGEMENT"){ error in
                                            print("SEE ERROR \(error as Any)")
                                          }
                                   }
                                   
                                   if user.data?.is_md! == "1" {
                                          Messaging.messaging().subscribe(toTopic:"MD") { error in  print("SEE ERROR \(error as Any)")
                                           }
                                        }
                                   
                                   if user.data?.role! == "7" {
                                             Messaging.messaging().subscribe(toTopic:"ACCOUNT") { error in
                                                print("SEE ERROR \(error as Any)")
                                                 }
                                       }
                    
                    
                      
                       self.callBack.LoadingSuccessfull(msg : user.message)
                 //   print(" See mee oga \( MemoryManager().getUser())")
                            
             }else{
                     self.callBack.LoadingFail(msg : user.message)
                }
                        
                
            case .failure(let error):
                self.callBack.LoadingFail(msg : "\(error)")
                 break
            }
                            
        
    


    }
    }
}
