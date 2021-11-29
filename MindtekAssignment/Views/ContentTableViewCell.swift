//
//  ContentTableViewCell.swift
//  MindtekAssignment
//
//  Created by Niranjan, Rajabhaiya on 29/11/21.
//

import Foundation
import UIKit


class ContentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var contentTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func populateInfo(info: ContentResult) {
        contentImage.setImage(forUrl: info.imageUrl, placeHolderImage: UIImage.init(named: "placeholder"))
        contentTitleLabel.text = info.contentTitle
    }
}
