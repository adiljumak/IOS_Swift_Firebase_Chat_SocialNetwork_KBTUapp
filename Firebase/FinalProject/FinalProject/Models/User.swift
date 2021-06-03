

import Foundation
import UIKit
import FirebaseDatabase

struct UserModel {
    
    var name: String?
    var surname: String?
    var lastname: String?
    var email: String?
    var workInfo: String?
    var aboutProfile: String?
    var facultyAndSpeciality: String?
//    var profileImage: UIImage?
    //var posts: [Post] = []
    
    var dict: [String: String]{
        return [
            "name": name!,
            "surname": surname!,
            "lastname": lastname!,
            "email": email!,
            "workInfo": workInfo!,
            "aboutProfile": aboutProfile!,
            "facultyAndSpeciality": facultyAndSpeciality!
         ]
    }
    
    init(_ email: String, _ name: String, _ surname: String, _ lastname: String, _ workInfo: String,_ aboutProfile: String, _ facultyAndSpeciality: String) {
        self.email = email
        self.name = name
        self.surname = surname
        self.lastname = lastname
        self.workInfo = workInfo
        self.aboutProfile = aboutProfile
        self.facultyAndSpeciality = facultyAndSpeciality
//        self.profileImage = profileImage
        //self.posts = posts
    }
    
    
    init(snapshot: DataSnapshot) {
        //convert from snapshot to regular field
        if let value = snapshot.value as? [String: String]{
            name = value["name"]!
            surname = value["surname"]!
            lastname = value["lastname"]!
            email = value["email"]!
            workInfo = value["workInfo"] ?? ""
            aboutProfile = value["aboutProfile"] ?? ""
            facultyAndSpeciality = value["facultyAndSpeciality"] ?? ""
        }
    }
}


