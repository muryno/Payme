
import Foundation

            




struct  UserBase : Codable {
    
    var message : String
    var error : Bool
       var data : User?
    
    
    enum CodingKeys: String, CodingKey {
          case error, data ,
            message
      }
}

struct User : Codable{
    var id  : String?
    var staff_id : String?
    var fname : String?
     var mobile : String?

    var lname : String?


    var oname : String?
    var image : String?
    
    var schedule_id : String?
     var gender: String?
     var designation : String?
    var address : String?
    var email : String?
    var authorization : String?
     var role : String?
    var status : String?
     var employment_status : String?
    var kin_name : String?
    var is_hod : String?
    var is_mgt : String?
    var is_md : String?
    var department : String?
    
    enum CodingKeys: String, CodingKey {
        case id   , staff_id,mobile,oname,schedule_id,gender,designation,address,email,authorization,role,status,
        employment_status,kin_name,is_hod,is_mgt,is_md,department,
        image = "profile_image",
          fname  = "first_name",
        lname = "last_name"
    }

}






