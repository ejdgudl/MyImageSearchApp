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
    
    var bottomSubLableText: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = NSTimeZone(name: "ko") as TimeZone?
        
        if document.displaySiteName == "" && document.datetime == "" {
            return ""
        }
        
        var result = document.displaySiteName
        
        if let date = dateFormatter.date(from: document.datetime) {
            let timeStamp = dateFormatter.string(from: date)
            
            let dd = result == "" ? timeStamp : " - \(timeStamp)"
            
            result.append(dd)
        }
        
        return result
    }
}
