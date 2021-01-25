//
//  SearchResult.swift
//  MyImageSearchApp
//
//  Created by 김동현 on 2021/01/25.
//

import Foundation

struct SearchResult: Codable {
    let documents: [Document]
    let meta: Meta
}

struct Document: Codable {
    let collection: String
    let datetime: String
    let displaySiteName: String
    let docURL: String
    let height: Int
    let imageURL: String
    let thumbnailURL: String
    let width: Int
    
    enum CodingKeys : String, CodingKey{
        case collection, datetime, height, width
        case displaySiteName = "display_sitename"
        case docURL = "doc_url"
        case imageURL = "image_url"
        case thumbnailURL = "thumbnail_url"
    }

}

struct Meta: Codable {
    let isEnd: Bool
    let pageAbleCount: Int
    let totalCount: Int
    
    enum CodingKeys : String, CodingKey{
        case isEnd = "is_end"
        case pageAbleCount = "pageable_count"
        case totalCount = "total_count"
    }
}
