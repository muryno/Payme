
import Foundation

            




struct  RequestBase : Codable {
    
    var error : Bool?
       var data : [RequestEntity]?
    
    
    enum CodingKeys: String, CodingKey {
          case error, data
      }
    
    init(from decoder: Decoder) throws {
      let response = try decoder.container(keyedBy: CodingKeys.self)
 
      self.error = try response.decode(Bool.self, forKey: .error)
      self.data = try response.decode([RequestEntity].self, forKey: .data)
    }

    func encode(to encoder: Encoder) throws {
      var response = encoder.container(keyedBy: CodingKeys.self)
      try response.encode(self.error, forKey: .error)
      try response.encode(self.data, forKey: .data)
     }
}

struct RequestEntity : Codable{
    var id : String?
    var staff_id: String?
     var receiver_name: String?
     var receiver_phone: String

    var account_no : String?
     var account_name: String?
     var amount: String?
     var item_id: String?
     var status: String?
    
     var date : String?
      var invoice: String?
     var signature: String?
      var bank_name: String

      var description_entity : String?
      var lname: String?
     var fname: String?
      var email: String?
     var mobile: String?
      var department: String?
    
    enum CodingKeys: String, CodingKey {
        case id ,staff_id,receiver_name,receiver_phone,account_no,account_name,amount,item_id,status,date,invoice,
        signature,bank_name,lname,fname,email,mobile,department,
        description_entity = "description"
     
    }
    
    
    
    

}






