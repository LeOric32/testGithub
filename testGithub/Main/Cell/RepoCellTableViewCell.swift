import UIKit

class RepoCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var url = ""
    
    var itemViewModel: ItemViewModel? {
        didSet {
            guard let model = itemViewModel else { return }
            nameLabel.text = model.name
            url = model.url
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
