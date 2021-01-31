//
//  ImageCellViewModel.swift
//  MyImageSearchApp
//
//  Created by 김동현 on 2021/01/26.
//

import Foundation

struct ImageCellViewModel {
    
    let document: Document
    
    init(document: Document) {
        self.document = document
    }
    
    var imageURL: URL? {
        return URL(string: document.imageURL)
    }
    
}
