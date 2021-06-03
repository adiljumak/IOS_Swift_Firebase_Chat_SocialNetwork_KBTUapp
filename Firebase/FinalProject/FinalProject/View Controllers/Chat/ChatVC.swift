

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ChatVC: UIViewController {

    
    
    // MARK: - Variables
    var currentUser: User?
    var ref: DatabaseReference = Database.database().reference()
    var usersModels: [UserModel] = []
    
    // MARK: - Outlets
    @IBOutlet weak var myTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser = Auth.auth().currentUser
        usersModelsSetup()
        searchBarSetup()
    }
    

    
    // MARK: - Functions
    
    func searchBarSetup(){
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    func usersModelsSetup(){
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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.hidesBottomBarWhenPushed = true
        let destination = segue.destination as! ChatDetailVC
        destination.name = usersModels[myTableView.indexPathForSelectedRow!.row].name!
        destination.surname = usersModels[myTableView.indexPathForSelectedRow!.row].surname!
        destination.toEmail = usersModels[myTableView.indexPathForSelectedRow!.row].email!
        destination.myEmail = currentUser?.email
    }
    

}


// MARK: - Table view delegate
extension ChatVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersModels.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell") as! ChatCell
        cell.profileName.text = usersModels[indexPath.row].name
        cell.profileSurname.text = usersModels[indexPath.row].surname
        cell.toEmail = usersModels[indexPath.row].email
        cell.myEmail = currentUser?.email
        return cell
    }
}


// MARK: - Search bar delegate

extension ChatVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
