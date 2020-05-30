//
//  HomePresenter.swift
//  Payme
//
//  Created by Muraino Yakubu on 5/27/20.
//  Copyright © 2020 Muraino Yakubu. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

class HomePresenter{
    var callBack : GeneralLoading
    
    init( callBack : GeneralLoading) {
        self.callBack = callBack
        
         //  NotificationCenter.default.addObserver(self, selector: #selector(getRequest), name: NSNotification.Name("MakeRequest"), object: nil)

    }
    
   func getRequest(mainContext : NSManagedObjectContext!) {
       
   
        
        let dataDataService = saveCoreRequest(managedObjectContext: mainContext)
            

        AF.request(URL.init(string: Utils.BaseUrl(url: "requests/pending/all"))!, method: .get, encoding: JSONEncoding.default, headers: Utils.Header()).responseDecodable(of: RequestBase.self) { (response) in
          //  print(" mee oga \( response.result)")
                  switch response.result {

                  case .success(_) :
                         guard let request = response.value else { return }
                         
                         if !request.error! &&  request.data != nil {
                     //     print(" See mee oga \( mainContext)")
                        
                        
                       
                            dataDataService.saveRequestData(req: request.data!)
                            
                              self.callBack.LoadingSuccessfull(msg : "Successful")
                                  
                   }else{
                           self.callBack.LoadingFail(msg : "fail")
                            
                            
                      }
                              
                      
                  case .failure(let error):
                      print( "\(error)")
                       break
                  }
                                  
              
          


          }
    }
    
}
