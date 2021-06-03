

import Foundation
import FirebaseDatabase

struct News {
    var date: String?
    var content: String?
    
    init(_ content: String, _ date: String) {
        self.content = content
        self.date = date
    }
    
    var dict: [String: String]{
        return [
            "content": content!,
            "date": date!
         ]
    }
    
    init(snapshot: DataSnapshot) {
        if let value = snapshot.value as? [String: String]{
            content = value["content"]!
            date = value["date"]!
        }
    }
}
