//
//  ContentResult.swift
//  MindtekAssignment
//
//  Created by Niranjan, Rajabhaiya on 29/11/21.
//

import Foundation

struct ContentResult: Codable {
    
    var id: Int?
    var imageUrl: String?
    var contentTitle: String?
    
    enum CodingKeys: String, CodingKey {
       
        case id = "id"
        case imageUrl = "image_url"
        case contentTitle = "title"
    }
    init() {
        
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        contentTitle = try values.decodeIfPresent(String.self, forKey: .contentTitle)
    }
}
