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
    
    var viewModel: ImageCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            imageView.kf.setImage(with: viewModel.imageURL)
        }
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.borderWidth = 0.3
        layer.borderColor = UIColor.lightGray.cgColor
        
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
