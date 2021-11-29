//
//  ContentViewModel.swift
//  MindtekAssignment
//
//  Created by Niranjan, Rajabhaiya on 29/11/21.
//

import Foundation
import UIKit

class ContentViewModel: NSObject {
    
    private var contentResults = [ContentResult]()
    private var originalContentResults = [ContentResult]()
    private var imagesUrls = [String]()
    override init() {
        
    }
    
    func loadInitialData(_ completion: @escaping (Bool) -> Void) {
        let group = DispatchGroup()
        group.enter()
        self.loadContentResult { value  in
            group.leave()
        }
        
        group.enter()
        self.loadImageUrls { value  in
            group.leave()
        }
        
        group.notify(queue: .main) {
            completion(true)
        }
    }
    
    func loadContentResult(_ completion: (Bool) -> Void) {
        var content1 = ContentResult.init()
        content1.imageUrl = "https://picsum.photos/200/300"
        content1.contentTitle = "Content 1"
        
        var content2 = ContentResult.init()
        content2.imageUrl = "https://picsum.photos/200/300"
        content2.contentTitle = "Content 2"
        
        var content3 = ContentResult.init()
        content3.imageUrl = "https://picsum.photos/200/300"
        content3.contentTitle = "Content 3"
        
        var content4 = ContentResult.init()
        content4.imageUrl = "https://picsum.photos/200/300"
        content4.contentTitle = "Content 4"
        
        contentResults.append(content1)
        contentResults.append(content2)
        contentResults.append(content3)
        contentResults.append(content4)
        originalContentResults = contentResults
        completion(true)
    }
    
    func loadImageUrls(_ completion: (Bool) -> Void) {
        imagesUrls.append("https://picsum.photos/200/300")
        imagesUrls.append("https://picsum.photos/200/300")
        imagesUrls.append("https://picsum.photos/200/300")
        imagesUrls.append("https://picsum.photos/200/300")
        imagesUrls.append("https://picsum.photos/200/300")
        imagesUrls.append("https://picsum.photos/200/300")
        imagesUrls.append("https://picsum.photos/200/300")
        imagesUrls.append("https://picsum.photos/200/300")
        imagesUrls.append("https://picsum.photos/200/300")
        imagesUrls.append("https://picsum.photos/200/300")
        imagesUrls.append("https://picsum.photos/200/300")
        imagesUrls.append("https://picsum.photos/200/300")
        imagesUrls.append("https://picsum.photos/200/300")
        completion(true)
    }
    

}

extension ContentViewModel {
    func numberOfContent() -> Int {
        return contentResults.count
    }
    
    func contentForIndex(index: Int) -> ContentResult? {
        return (index < contentResults.count) ? contentResults[index] : nil
    }
    
    func numberOfImageUrl() -> Int {
        return imagesUrls.count
    }
    
    func urlForIndex(index: Int) -> String? {
        return (index < imagesUrls.count) ? imagesUrls[index] : nil
    }
    
    func updateTable(for text: String) {
        if text.count < 1 {
            contentResults = originalContentResults
            return
        }
        contentResults = originalContentResults.filter({ (content: ContentResult) -> Bool in
            return content.contentTitle?.contains(text) ?? true
        })
    }
}
