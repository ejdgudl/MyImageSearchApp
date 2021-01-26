//
//  DetailVCViewModel.swift
//  MyImageSearchApp
//
//  Created by 김동현 on 2021/01/26.
//

import UIKit

struct DetailVCViewModel {
    
    let document: Document
    
    init(document: Document) {
        self.document = document
    }
    
    var imageURL: URL? {
        return URL(string: document.imageURL)
    }
    
    var siteName: String {
        return document.displaySiteName
    }
    
    var dateTime: String {
        return document.datetime
    }
}
