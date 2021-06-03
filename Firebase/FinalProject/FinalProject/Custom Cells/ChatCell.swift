
import UIKit

class ChatCell: UITableViewCell {

    
    // MARK: - Outlet
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileSurname: UILabel!
    @IBOutlet weak var profileMessage: UILabel!
    
    
    // MARK: - Variables
    var toEmail: String?
    var myEmail: String?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
