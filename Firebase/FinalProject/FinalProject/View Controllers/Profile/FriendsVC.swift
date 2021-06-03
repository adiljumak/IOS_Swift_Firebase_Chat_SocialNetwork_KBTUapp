

import UIKit
import FirebaseAuth
import FirebaseDatabase

class FriendsVC: UITableViewController {

    
    // MARK: - Outlets
    @IBOutlet var myTableView: UITableView!
    
    
    // MARK: - Variables
    var ref = Database.database().reference()
    var currentUser = Auth.auth().currentUser
    var usersModels: [UserModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usersSetup()
    }
    
    // MARK: - Functions
    
    func usersSetup(){
        let parent = ref.child("users")
        parent.observe(.value) { [weak self] (snapshot) in
            for child in snapshot.children{
                if let snap = child as? DataSnapshot{
                    let userModel = UserModel(snapshot: snap)
                    self?.usersModels.append(userModel)
                }
            }
            self?.myTableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usersModels.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendsCell") as! FriendsCell
        cell.profileName.text = usersModels[indexPath.row].name
        cell.profileSurname.text = usersModels[indexPath.row].surname
        cell.profileFaculty.text = usersModels[indexPath.row].facultyAndSpeciality

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! FriendsProfileVC
        destination.name = usersModels[myTableView.indexPathForSelectedRow!.row].name!
        destination.surname = usersModels[myTableView.indexPathForSelectedRow!.row].surname!
        destination.toEmail = usersModels[myTableView.indexPathForSelectedRow!.row].email!
    }
    

}
