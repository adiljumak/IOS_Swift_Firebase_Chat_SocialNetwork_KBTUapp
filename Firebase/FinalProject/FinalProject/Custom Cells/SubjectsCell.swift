

import UIKit

class SubjectsCell: UITableViewCell {

    
    // MARK: - Outlets
    @IBOutlet weak var subject: UILabel!
    var detailInfo: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
