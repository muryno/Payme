//
//  SavecoreRequest.swift
//  Payme
//
//  Created by Muraino Yakubu on 5/28/20.
//  Copyright © 2020 Muraino Yakubu. All rights reserved.
//

import Foundation
import CoreData

struct saveCoreRequest: ManageObjectContextDependentType{
    
    var managedObjectContext: NSManagedObjectContext!
    
    func saveRequestData(req : [RequestEntity]){
        
        let fetchRequest = NSFetchRequest<Request>(entityName: Request.entityName)
        
        do {
            
          let requst = try managedObjectContext.fetch(fetchRequest)
            
            for reqObj in requst {
                
            managedObjectContext.delete(reqObj)
                
            }
            do {
                try self.managedObjectContext.save()
                } catch {
                 self.managedObjectContext.rollback()
                    print("Something went wrong: \(error)")
                    }
            
            if req.count > 0 {
                
                let request = NSEntityDescription.insertNewObject(forEntityName: Request.entityName,
                                                                                       into: self.managedObjectContext) as! Request
                for  rqvalue in  req  {
                    
                    request.account_name = rqvalue.account_name
                       request.account_no = rqvalue.account_no
                                   
                      request.amount =  rqvalue.amount ??  " "
                      request.bank_name = rqvalue.bank_name
                      request.date = rqvalue.date
                      request.department   = rqvalue.department ??  " "
                      request.email = rqvalue.email  ??  " "
                      request.request_description = rqvalue.description_entity ?? ""
                      request.receiver_phone = rqvalue.receiver_phone
                      request.status  = rqvalue.status ?? ""
                      request.mobile = rqvalue.mobile ?? " "
                      request.invoice = rqvalue.invoice ?? " "
                      request.fname  =  rqvalue.fname
                    request.lname = rqvalue.lname
                    request.staff_id = rqvalue.staff_id
                    request.id = rqvalue.id ?? ""
                    request.item_id = rqvalue.item_id ?? ""
                    request.receiver_name = rqvalue.receiver_name ?? ""
                
                    do {
                        try self.managedObjectContext.save()
                        
                      //  self.FetchData()
                        
                        } catch {
                            self.managedObjectContext.rollback()
                      }
                    
                }
                
                // print("Na mebe \(error)")
                    
         
            }
        
            
        }catch{
            print("Na mebe \(error)")
        }
    }
    
    //testing ... NSFetchRequestController also manage state changes
    func FetchData(){
        let data =  NSFetchRequest<Request>(entityName: Request.entityName)
        do{
            let dataResult = try managedObjectContext.fetch(data)
             print("Oga na me be this \(dataResult)")
        }catch{
            print("Errors \(error)")
        }
    }
}
