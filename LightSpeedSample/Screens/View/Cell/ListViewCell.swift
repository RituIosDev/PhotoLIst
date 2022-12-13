//
//  ListViewCell.swift
//  LightSpeedSample
//
//  Created by Ritu on 2022-12-08.
//

import UIKit

class ListViewCell: UITableViewCell {

    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var imgDisplay: UIImageView!

    //MARK: - Variables
    class var identifier: String { return String(describing: self) }
    
    //MARK: - Set Data in Cells
    var cellViewModel: ListViewCellModel? {
        didSet {
            if let value = cellViewModel?.lblAuthor as? String{
                lblAuthor.text = value
            }
            if let image = UIImage(data: cellViewModel?.imgDisplay ?? Data()){
                imgDisplay.image = image
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
