//
//  Request.swift
//  Payme
//
//  Created by Muraino Yakubu on 5/23/20.
//  Copyright © 2020 Muraino Yakubu. All rights reserved.
//

import Foundation
import CoreData

class Request : NSManagedObject{
    
    @NSManaged var id : Int
    @NSManaged var staff_id: String?
    @NSManaged var receiver_name: String?
    @NSManaged var receiver_phone: String

    @NSManaged var account_no : String?
    @NSManaged var account_name: String?
    @NSManaged var amount: Double
    @NSManaged var item_id: Int16
    @NSManaged var status: String
    
     @NSManaged var date : String?
     @NSManaged var invoice: String?
     @NSManaged var signature: String?
     @NSManaged var bank_name: String

     @NSManaged var description_entity : String?
     @NSManaged var lname: String?
     @NSManaged var fname: String?
     @NSManaged var email: String
     @NSManaged var mobile: String
     @NSManaged var department: String
 

}
