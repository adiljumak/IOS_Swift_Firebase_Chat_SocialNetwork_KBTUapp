
import Foundation
import FirebaseDatabase

struct Subject {
    var name: String?
    var detailInfo: String?
    
    init(_ name: String, _ detailInfo: String) {
        self.name = name
        self.detailInfo = detailInfo
    }
    
    var dict: [String: String]{
        return [
            "name": name!,
            "detailInfo": detailInfo!
         ]
    }
    
    init(snapshot: DataSnapshot) {
        if let value = snapshot.value as? [String: String]{
            name = value["name"]!
            detailInfo = value["detailInfo"]!
        }
    }
}
