//
//  DetailVCPresent.swift
//  MyImageSearchApp
//
//  Created by 김동현 on 2021/01/28.
//

import UIKit

// MARK: - DetailVC Present Error

enum DetailVCPresentError: Error {
    
    case noDocuments
    case outOfRange
    
    var errorDescription: String {
        switch self {
        case .noDocuments:
            return "--Documents is nil--"
        case .outOfRange:
            return "--Out of range--"
        }
    }
    
}

// MARK: - present DetailVC

extension MainVC {

    func presentDetailVC(documents: [Document]?, row: Int) throws {
        
        guard let documents = documents else { throw  DetailVCPresentError.noDocuments }
        guard documents.count - 1 >= row else { throw DetailVCPresentError.outOfRange }
        
        let detailVC = DetailVC(viewModel: DetailVCViewModel(document: documents[row]))
        let nav = UINavigationController(rootViewController: detailVC)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
        
    }
    
}
