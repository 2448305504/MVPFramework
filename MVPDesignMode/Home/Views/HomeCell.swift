//
//  HomeCell.swift
//  MVPDesignMode
//
//  Created by 林文俊 on 2022/9/8.
//

import UIKit

class HomeCell: UITableViewCell {

    var homeProfile: HomeProfile? {
        didSet {
            guard let homeProfile = homeProfile else { return }
            name.text = homeProfile.brandName
        }
    }
    
    @IBOutlet weak var name: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
