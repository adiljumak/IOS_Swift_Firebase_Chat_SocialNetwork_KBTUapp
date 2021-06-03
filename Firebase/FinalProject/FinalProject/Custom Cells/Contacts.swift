
import Foundation
import FirebaseDatabase

struct Contacts {
    var name: String?
    var surname: String?
    var number: String?
    
    init(_ name: String, _ surname: String, _ number: String) {
        self.name = name
        self.surname = surname
        self.number = number
    }
    
    var dict: [String: String]{
        return [
            "name": name!,
            "surname": surname!,
            "number": number!
         ]
    }
    
    init(snapshot: DataSnapshot) {
        if let value = snapshot.value as? [String: String]{
            name = value["name"]!
            surname = value["surname"]!
            number = value["number"]!
        }
    }
}
