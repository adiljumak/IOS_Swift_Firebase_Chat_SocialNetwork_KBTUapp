
import Foundation
import FirebaseDatabase

struct Message {
    var content: String?
    var toEmail: String?
    var myEmail: String?
    
    init(_ content: String, _ toEmail: String, _ myEmail: String) {
        self.content = content
        self.toEmail = toEmail
        self.myEmail = myEmail
    }
    
    var dict: [String: String]{
        return [
            "content": content!,
            "toEmail": toEmail!,
            "myEmail": myEmail!
         ]
    }
    
    init(snapshot: DataSnapshot) {
        if let value = snapshot.value as? [String: String]{
            content = value["content"]!
            toEmail = value["toEmail"]!
            myEmail = value["myEmail"]!
        }
    }
}
