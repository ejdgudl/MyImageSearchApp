//
//  CellForItem.swift
//  MyImageSearchApp
//
//  Created by 김동현 on 2021/01/28.
//

import UIKit

// MARK: - CellForItem Error

enum CellForItemError: Error {
    
    case canNotMakeReusableCell
    case noDocuments
    
    var errorDescription: String {
        switch self {
        case .canNotMakeReusableCell:
            return "--No identifier--"
        case .noDocuments:
            return "--No documents--"
        }
    }
    
}

// MARK: - cellForItem

extension MainVC {
    
    func cellForItem(collectionView: UICollectionView, documents: [Document]?, indexPath: IndexPath, cellID: String) throws -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? ImageCell else {
            throw CellForItemError.canNotMakeReusableCell }
        
        guard let document = documents?[indexPath.row] else {
            throw CellForItemError.noDocuments }
        
        cell.viewModel = ImageCellViewModel(document: document)
        
        return cell
    }
    
}
