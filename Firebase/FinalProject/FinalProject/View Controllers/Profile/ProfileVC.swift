import UIKit
import FirebaseAuth
import FirebaseDatabase

class ProfileVC: UIViewController {

    

    // MARK: - Outlets
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileSurname: UILabel!
    @IBOutlet weak var profileFaculty: UILabel!
    @IBOutlet weak var profileAbout: UILabel!
    @IBOutlet weak var newPost_outlet: UIButton!
    @IBOutlet weak var editInfo_outlet: UIButton!
    
    
    // MARK: - Variables
    var currentUser: User?
    var ref: DatabaseReference = Database.database().reference()
    var profile: UserModel?
    var posts: [Post] = []
    
    
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser = Auth.auth().currentUser
        profileSetup()
        postModelSetup()
    }
    
    // MARK: - Functions
    
    func postModelSetup(){
        let parent = ref.child("posts")
        parent.observe(.value) { [weak self] (snapshot) in
            self?.posts.removeAll()
            for child in snapshot.children{
                if let snap = child as? DataSnapshot{
                    let post = Post(snapshot: snap)
                    if post.author == self?.currentUser?.email{
                        self?.posts.append(post)
                    }
                }
            }
            self?.posts.reverse()
            self?.myTableView.reloadData()
        }
        
    }
    
    func profileSetup() {
        let parent = ref.child("users")
        parent.observe(.value) { [weak self] (snapshot) in
            for child in snapshot.children{
                if let snap = child as? DataSnapshot{
                    let userModel = UserModel(snapshot: snap)
                    if userModel.email == self?.currentUser?.email{
                        self?.profile = userModel
                        self?.profileName.text = userModel.name
                        self?.profileSurname.text = userModel.surname
                        self?.profileFaculty.text = userModel.facultyAndSpeciality
                        self?.profileAbout.text = userModel.aboutProfile
                    }
                }
            }
            self?.myTableView.reloadData()
        }
    }
    
//    func profileSetup2(){
//        profileName.text = profile!.name
//        profileSurname.text = profile?.surname
//        profileFaculty.text = profile?.facultyAndSpeciality
//        profileAbout.text = profile?.aboutProfile
//    }
    
    // MARK: - Actions
    @IBAction func newPost_action(_ sender: UIButton) {
        let alert = UIAlertController(title: "New post", message: "Enter a text", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "What's up?"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Add hashtag"
        }
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let dateFinal = formatter.string(from: date)
        
        alert.addAction(UIAlertAction(title: "Post", style: .default, handler: { [self, weak alert] (_) in
            let textField = alert?.textFields![0]
            let tag = alert?.textFields![1]
            let post = Post(textField!.text!, (self.currentUser?.email)!, tag!.text!, dateFinal)
            ref.child("posts").childByAutoId().setValue(post.dict)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func editProfile_action(_ sender: UIButton) {
        print(posts.count)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - Table View Delegate

extension ProfileVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let profileCell = tableView.dequeueReusableCell(withIdentifier: "profileCell") as! ProfileTV_Cell
        profileCell.postTextLabel.text = posts[indexPath.row].content
        profileCell.timeLabel.text = posts[indexPath.row].date
        profileCell.hashtags.text = posts[indexPath.row].hashtag
        profileCell.nameLabel.text = profile?.name
        profileCell.surnameLabel.text = profile?.surname
        return profileCell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
