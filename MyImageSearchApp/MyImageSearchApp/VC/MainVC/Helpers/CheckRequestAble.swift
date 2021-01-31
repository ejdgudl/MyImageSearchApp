//
//  CheckRequestAble.swift
//  MyImageSearchApp
//
//  Created by 김동현 on 2021/01/29.
//

import Foundation
import RxSwift

// MARK: - Check Request Able Error

enum CheckRequestAbleError: Error {
    
    case noText
    case dontNeedToRequest
    
    var errorDescription: String {
        switch self {
        case .noText:
            return "--Textfield.text is empty--"
        case .dontNeedToRequest:
            return "--Don't need to Request--"
        }
    }
    
    func descriptionPrint() {
        print(errorDescription)
    }
    
}

// MARK: - Check Request Able

extension MainVC {
    
    func checkRequestAble() throws {
        
        guard searchController.searchBar.searchTextField.text != "" else {
            self.searchHistory = ""
            self.documents?.removeAll()
            throw CheckRequestAbleError.noText
        }
        
        guard searchController.searchBar.searchTextField.text != searchHistory else {
            throw CheckRequestAbleError.dontNeedToRequest
        }
        
    }
    
}
