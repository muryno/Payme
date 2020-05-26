
import Foundation

            




struct  RequestBase : Codable {
    
    var message : String
    var error : Bool
       var data : RequestEntity?
    
    
    enum CodingKeys: String, CodingKey {
          case error, data ,
            message
      }
}

struct RequestEntity : Codable{
    var id : Int
    var staff_id: String?
     var receiver_name: String?
     var receiver_phone: String

    var account_no : String?
     var account_name: String?
     var amount: Double
     var item_id: Int16
     var status: String
    
     var date : String?
      var invoice: String?
     var signature: String?
      var bank_name: String

      var description_entity : String?
      var lname: String?
     var fname: String?
      var email: String
     var mobile: String
      var department: String
    
    enum CodingKeys: String, CodingKey {
        case id ,staff_id,receiver_name,receiver_phone,account_no,account_name,amount,item_id,status,date,invoice,
        signature,bank_name,lname,fname,email,mobile,department,
        description_entity = "description"
     
    }

}






