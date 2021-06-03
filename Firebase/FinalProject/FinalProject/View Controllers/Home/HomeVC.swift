

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HomeVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var new_outlet: UIBarButtonItem!
    

    
    // MARK: - Variables
    var allNews: [News] = []
    var ref = Database.database().reference()
    var currentUser = Auth.auth().currentUser
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarSetup()
        allNewsSetup()
        if currentUser?.email != "r_magametov@kbtu.kz"{
            navigationItem.leftBarButtonItem = .none
        }
    }
    
    
    // MARK: - Actions
    @IBAction func writeNew(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Write new", message: "Enter a text", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "What's up?"
        }
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let dateFinal = formatter.string(from: date)
        
        alert.addAction(UIAlertAction(title: "Post new", style: .default, handler: { [self, weak alert] (_) in
            let textField = alert?.textFields![0]
            let post = News(textField!.text!, dateFinal)
            ref.child("news").childByAutoId().setValue(post.dict)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    // MARK: - Functions
    
    func allNewsSetup(){
        let parent = ref.child("news")
        parent.observe(.value) { [weak self] (snapshot) in
            self?.allNews.removeAll()
            for child in snapshot.children{
                if let snap = child as? DataSnapshot{
                    let new = News(snapshot: snap)
                    self?.allNews.append(new)
                }
            }
            self?.allNews.reverse()
            self?.myTableView.reloadData()
        }
    }
    
    func searchBarSetup(){
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = true
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.searchBar.delegate = self
    }
    
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}

// MARK: - Table view delegate

extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allNews.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsCell = tableView.dequeueReusableCell(withIdentifier: "newsCell") as! NewsCell
        newsCell.newsTextLabel.text = allNews[indexPath.row].content
        newsCell.timeLabel.text = allNews[indexPath.row].date
        return newsCell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


// MARK: - Search Bar delegate
extension HomeVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        searchingTweets.removeAll()
//        for tweet in tweets {
//            print(searchText.lowercased())
//            if tweet.hashtag?.lowercased().range(of: searchText.lowercased()) != nil{
//                searchingTweets.append(tweet)
//            }
//        }
//        isSearching = true
//        if searchText == "" {
//            isSearching = false;
//        }
//        myTableView.reloadData()
//    }
    }
}
