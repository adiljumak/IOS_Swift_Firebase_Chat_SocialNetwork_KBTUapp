

import UIKit

class SubjectDetailVC: UIViewController {

    @IBOutlet weak var subjectDetailInfo: UILabel!
    var detailInfo: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        subjectDetailInfo.text = detailInfo

        // Do any additional setup after loading the view.
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
