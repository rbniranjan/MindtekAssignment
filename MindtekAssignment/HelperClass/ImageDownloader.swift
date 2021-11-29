//
//  ImageDownloader.swift
//  MindtekAssignment
//
//  Created by Niranjan, Rajabhaiya on 29/11/21.
//

import Foundation
import UIKit
final class ImageDownloader: NSObject {
    public static let manager = ImageDownloader()
    private override init() {

    }
    private var cachedImages = [String: UIImage]()
    let serialQueueForImages = DispatchQueue(label: "images.queue", attributes: .concurrent)

    private func image(urlString: String) -> UIImage? {
        serialQueueForImages.sync {
            return cachedImages[urlString]
        }
    }
    
    public func loadCachedImage(urlString: String) -> UIImage? {
        return image(urlString: urlString)
    }
    
    public final func load(urlString: String, completion: @escaping (String, UIImage?) -> Void) {
        
        // Check for a cached image.
        if let cachedImage = image(urlString: urlString) {
            completion(urlString, cachedImage)
            return
        }
        // Go fetch the image.
        guard let requestURL = URL(string: urlString) else {
            completion(urlString, nil)
            return
        }
        URLSession.shared.dataTask(with: requestURL, completionHandler: { (data: Data?, response: URLResponse?, error) -> Void in
            
            guard let responseData = data, let image = UIImage(data: responseData),
                  error == nil else {
                      DispatchQueue.main.async{
                          completion(urlString, nil)
                      }
                      return
                  }
            
            self.serialQueueForImages.sync {
                self.cachedImages[urlString] = image
            }
            // Cache the image.
            DispatchQueue.main.async {
                completion(urlString, nil)
            }
            
        }).resume()
    }
    
}
