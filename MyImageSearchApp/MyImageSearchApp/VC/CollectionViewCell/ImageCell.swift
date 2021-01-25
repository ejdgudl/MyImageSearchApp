//
//  ImageCell.swift
//  MyImageSearchApp
//
//  Created by 김동현 on 2021/01/26.
//

import UIKit
import Kingfisher

class ImageCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var document: Document? {
        didSet {
            guard let document = document, let url = URL(string: document.imageURL) else { return }
            imageView.kf.setImage(with: url)
        }
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
