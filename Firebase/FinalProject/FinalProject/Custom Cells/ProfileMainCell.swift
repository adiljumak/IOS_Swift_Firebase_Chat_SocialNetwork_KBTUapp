
import UIKit

class ProfileMainCell: UITableViewCell {

    
    // MARK: - Outlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileSurname: UILabel!
    @IBOutlet weak var profileFaculty: UILabel!
    @IBOutlet weak var profileInfo: UIButton!
    @IBOutlet weak var newPost_outlet: UIButton!
    @IBOutlet weak var editInfo_outlet: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
