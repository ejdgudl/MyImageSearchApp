//
//  CheckRequestAble.swift
//  MyImageSearchApp
//
//  Created by 김동현 on 2021/01/29.
//

import Foundation

// MARK: - Check Request Able Error

enum CheckRequestAbleError: Error {
    
    case noText
    case dontNeedRequest
    
    var errorDescription: String {
        switch self {
        case .noText:
            return "--Textfield.text is--"
        case .dontNeedRequest:
            return "--Don't need Request--"
        }
    }

}

// MARK: - Check Request Able

extension MainVC {

    func CheckRequestAble() throws {
        
        guard searchController.searchBar.searchTextField.text != "" else {
            throw CheckRequestAbleError.noText
        }
        
        guard searchController.searchBar.searchTextField.text != searchHistory else {
            throw CheckRequestAbleError.dontNeedRequest
        }
        
    }
    
}
