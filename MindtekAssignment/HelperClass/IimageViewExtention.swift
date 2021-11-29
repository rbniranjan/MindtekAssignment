//
//  IimageViewExtention.swift
//  MindtekAssignment
//
//  Created by Niranjan, Rajabhaiya on 29/11/21.
//

import Foundation
import UIKit


extension UIImageView {
     
    func setImage(forUrl strUrl: String?, placeHolderImage: UIImage?) {
        guard let strUrl = strUrl, !strUrl.isEmpty else {
            self.image = placeHolderImage
            return
        }
        ImageDownloader.manager.load(urlString: strUrl) { url, image in
            if url == strUrl {
                self.image = image ?? placeHolderImage
            }
        }
    }
}
