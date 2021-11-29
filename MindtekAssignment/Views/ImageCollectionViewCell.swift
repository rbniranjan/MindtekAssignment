//
//  ImageCollectionViewCell.swift
//  MindtekAssignment
//
//  Created by Niranjan, Rajabhaiya on 29/11/21.
//

import Foundation
import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet var photoImageView: UIImageView!
    static let cellId = "ImageCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func showImage(for imageUrl: String?) {
        photoImageView.setImage(forUrl: imageUrl, placeHolderImage: UIImage.init(named: "placeholder"))
    }
}
