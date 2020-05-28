//
//  Network.swift
//  Intacter
//
//  Created by Muraino Yakubu on 5/23/20.
//  Copyright © 2020 Muraino Yakubu. All rights reserved.
//

import Foundation
import Alamofire


class Utils{
    
   static func BaseUrl( url: String)->String{
        let er = "https://api.connectrail.net/"+url
        return er
    }
    
    static func Header ()-> HTTPHeaders{
        
          let      token = MemoryManager().getUser().authorization ?? " "
            
              //print("wOSS WOBI \(token)")

        let headers: HTTPHeaders = [
              "X-Auth-Token": token,
              "Accept": "application/json",
               "Accept": "application/x-www-form-urlencoded",
          ]
        
        return headers
    }
  
    
     
}
