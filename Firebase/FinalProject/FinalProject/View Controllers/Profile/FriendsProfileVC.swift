
import UIKit
import FirebaseAuth
import FirebaseDatabase

class FriendsProfileVC: UIViewController {

    
    // MARK: - Outlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileSurname: UILabel!
    @IBOutlet weak var profileFaculty: UILabel!
    @IBOutlet weak var profileAbout: UILabel!
    @IBOutlet weak var writeMwssage_outlet: UIButton!
    
    
    // MARK: - Variables
    var toEmail: String?
    var name: String?
    var surname: String?
    var posts: [Post] = []
    var ref = Database.database().reference()
    var currentUser = Auth.auth().currentUser
    
    // MARK: - View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        profileName.text = name
        profileSurname.text = surname
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
                    if post.author == self?.toEmail{
                        self?.posts.append(post)
                    }
                }
            }
            self?.posts.reverse()
            self?.myTableView.reloadData()
        }
        
    }
    
    // MARK: - Actions
    @IBAction func writeMessage_action(_ sender: UIButton) {

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ChatDetailVC
        destination.name = name
        destination.surname = surname
        destination.toEmail = toEmail
        destination.myEmail = currentUser?.email
    }

    
}

// MARK: - Table view data source
extension FriendsProfileVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendsProfileCell") as! FriendsPostCell
        cell.postContent.text = posts[indexPath.row].content
        cell.profileName.text = name
        cell.profileSurname.text = surname
        cell.time.text = posts[indexPath.row].date
        cell.postHashtag.text = posts[indexPath.row].hashtag
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
