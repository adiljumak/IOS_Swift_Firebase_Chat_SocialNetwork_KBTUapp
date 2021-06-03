

import Foundation
import FirebaseDatabase

struct Teacher {
    var name: String?
    var surname: String?
    var teachership: String?
    
    init(_ name: String, _ surname: String, _ teachership: String) {
        self.name = name
        self.surname = surname
        self.teachership = teachership
    }
    
    var dict: [String: String]{
        return [
            "name": name!,
            "surname": surname!,
            "teachership": teachership!
         ]
    }
    
    init(snapshot: DataSnapshot) {
        if let value = snapshot.value as? [String: String]{
            name = value["name"]!
            surname = value["surname"]!
            teachership = value["teachership"]!
        }
    }
}
