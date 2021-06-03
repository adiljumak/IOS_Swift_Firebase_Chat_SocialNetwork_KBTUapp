

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ChatDetailVC: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameButton_outlet: UIButton!
    @IBOutlet weak var profileSettings_outlet: UIButton!
    @IBOutlet weak var clipButton_outlet: UIButton!
    @IBOutlet weak var cameraButton_outlet: UIButton!
    @IBOutlet weak var sendButton_outlet: UIButton!
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var myTableView: UITableView!
    
    
    // MARK: - Variables
    var name: String?
    var surname: String?
    var toEmail: String?
    var myEmail: String?
    var ref: DatabaseReference = Database.database().reference()
    var allMessages: [Message] = []
    var currentUser = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileSettings_outlet.layer.cornerRadius = profileSettings_outlet.frame.height / 2
        nameButton_outlet.contentHorizontalAlignment = .left
        nameButton_outlet.setTitle(name! + " " + surname!, for: .normal)
        print(toEmail!)
        print(myEmail!)
        usersModelsSetup()
        
    }
    
    // MARK: - Functions
    
    func usersModelsSetup(){
        let parent = ref.child("messages")
        parent.observe(.value) { [weak self] (snapshot) in
            self?.allMessages.removeAll()
            for child in snapshot.children{
                if let snap = child as? DataSnapshot{
                    let message = Message(snapshot: snap)
                    if message.myEmail! == self?.myEmail! && message.toEmail! == self?.toEmail! {
                        self?.allMessages.append(message)
                    }
                    else if message.myEmail! == self?.toEmail && message.toEmail! == self?.myEmail{
                        self?.allMessages.append(message)
                    }
                    
                }
            }
            self?.myTableView.reloadData()
        }
    }
    
    
    // MARK: - Actions
    
    
    @IBAction func send_action(_ sender: UIButton) {
        
        let message = Message(messageField.text!, toEmail!, myEmail!)
        ref.child("messages").childByAutoId().setValue(message.dict)
        allMessages.append(message)
        myTableView.reloadData()
        messageField.text = ""
    }
    
    @IBAction func camera_action(_ sender: UIButton) {
        myTableView.reloadData()
    }
    @IBAction func backButton_action(_ sender: UIButton) {
        let dest = (storyboard?.instantiateViewController(identifier: "TabBarVC"))! as UITabBarController
        dest.selectedIndex = 3
        dest.modalTransitionStyle = .flipHorizontal
        present(dest, animated: true, completion: nil)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
}

}


// MARK: - Table view delegate
extension ChatDetailVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myMessage") as! MessageCell
        
        cell.leftLabel.layer.cornerRadius = 5
        cell.leftLabel.layer.masksToBounds = true
        cell.rightLabel.layer.cornerRadius = 5
        cell.rightLabel.layer.masksToBounds = true
        if allMessages[indexPath.row].toEmail == currentUser?.email{
            cell.leftLabel.text = allMessages[indexPath.row].content
            cell.rightLabel.text = ""
        }else{
            cell.rightLabel.text = allMessages[indexPath.row].content
            cell.leftLabel.text = ""
        }
        return cell
    }
    
    
    
}
