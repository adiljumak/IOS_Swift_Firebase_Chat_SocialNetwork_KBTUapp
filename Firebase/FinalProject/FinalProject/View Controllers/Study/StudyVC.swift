

import UIKit
import FirebaseAuth
import FirebaseDatabase

class StudyVC: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var segmented_outlet: UISegmentedControl!
    @IBOutlet weak var myTableView: UITableView!
    
    
    
    // MARK: - Variables
    var allSubjects: [Subject] = []
    var allTeachers: [Teacher] = []
    var ref = Database.database().reference()
    var currentUser = Auth.auth().currentUser
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarSetup()
        subjectsSetup()
        teachersSetup()
        if currentUser?.email != "r_magametov@kbtu.kz"{
            navigationItem.leftBarButtonItem = .none
        }
    }
    
    // MARK: - Functions
    
    func subjectsSetup(){
        let parent = ref.child("subjects")
        parent.observe(.value) { [weak self] (snapshot) in
            self?.allSubjects.removeAll()
            for child in snapshot.children{
                if let snap = child as? DataSnapshot{
                    let subject = Subject(snapshot: snap)
                    self?.allSubjects.append(subject)
                }
            }
            self?.allSubjects.reverse()
            self?.myTableView.reloadData()
        }
    }
    
    func teachersSetup(){
        let parent = ref.child("teachers")
        parent.observe(.value) { [weak self] (snapshot) in
            self?.allTeachers.removeAll()
            for child in snapshot.children{
                if let snap = child as? DataSnapshot{
                    let teacher = Teacher(snapshot: snap)
                    self?.allTeachers.append(teacher)
                }
            }
            self?.allTeachers.reverse()
            self?.myTableView.reloadData()
        }
    }
    
    func searchBarSetup(){
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    // MARK: - Actions
    @IBAction func segmented_action(segment: UISegmentedControl) {
        myTableView.reloadData()
    }
    
    @IBAction func add_action(_ sender: UIBarButtonItem) {
        if segmented_outlet.selectedSegmentIndex == 0{
            let alert = UIAlertController(title: "New subject", message: "Enter name of subject", preferredStyle: .alert)
            alert.addTextField { (textField) in
                textField.placeholder = "Write here..."
            }
            alert.addTextField { (textField) in
                textField.placeholder = "Write detail info here..."
            }
            
            
            alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [self, weak alert] (_) in
                let textField = alert?.textFields![0]
                let textField2 = alert?.textFields![1]
                let post = Subject(textField!.text!, textField2!.text!)
                ref.child("subjects").childByAutoId().setValue(post.dict)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }else{
            let alert = UIAlertController(title: "New teacher", message: "Enter name of teacher", preferredStyle: .alert)
            alert.addTextField { (textField) in
                textField.placeholder = "Name"
            }
            alert.addTextField { (textField) in
                textField.placeholder = "Surname"
            }
            alert.addTextField { (textField) in
                textField.placeholder = "Write teachership"
            }
            
            
            alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [self, weak alert] (_) in
                let textField = alert?.textFields![0]
                let textField2 = alert?.textFields![1]
                let textField3 = alert?.textFields![2]
                let post = Teacher(textField!.text!, textField2!.text!, textField3!.text!)
                ref.child("teachers").childByAutoId().setValue(post.dict)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSubject"{
            let destination = segue.destination as! SubjectDetailVC
            destination.navigationController?.title = allSubjects[myTableView.indexPathForSelectedRow!.row].name
            destination.detailInfo = allSubjects[myTableView.indexPathForSelectedRow!.row].detailInfo
        }
    }
    

}


// MARK: - Table view delegate
extension StudyVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmented_outlet.selectedSegmentIndex == 0{
            return 0
        }else{
            return allTeachers.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let subjectsCell = tableView.dequeueReusableCell(withIdentifier: "subjectsCell") as! SubjectsCell
        subjectsCell.subject.text = allSubjects[indexPath.row].name
        subjectsCell.detailInfo = allSubjects[indexPath.row].detailInfo
        
        let teachersCell = tableView.dequeueReusableCell(withIdentifier: "teachersCell") as! TeacherCell
        teachersCell.profileName.text = allTeachers[indexPath.row].name
        teachersCell.profileSurname.text = allTeachers[indexPath.row].surname
        teachersCell.profileTeachership.text = allTeachers[indexPath.row].teachership
        if segmented_outlet.selectedSegmentIndex == 0{
            return subjectsCell
        }else{
            return teachersCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if segmented_outlet.selectedSegmentIndex == 0{
            return 44
        }else{
            return 110
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Search Bar delegate
extension StudyVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
