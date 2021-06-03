
import UIKit

class FriendsPostCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileSurname: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var postContent: UILabel!
    @IBOutlet weak var postHashtag: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
