import Foundation
import FirebaseDatabase

struct Post {
    var content: String?
    var author: String?
    var hashtag: String?
    var date: String?
    
    
    init(_ content: String, _ author: String, _ hashtag: String, _ date: String) {
        self.content = content
        self.author = author
        self.hashtag = hashtag
        self.date = date
    }
    
    var dict: [String: String]{
        return [
            "content": content!,
            "author": author!,
            "hashtag": hashtag!,
            "date": date!
         ]
    }
    
    init(snapshot: DataSnapshot) {
        if let value = snapshot.value as? [String: String]{
            content = value["content"]!
            author = value["author"]!
            hashtag = value["hashtag"]!
            date = value["date"]!
        }
    }
}
