//
//  HeaderCell.swift
//  MyImageSearchApp
//
//  Created by 김동현 on 2021/01/31.
//

import UIKit

class CollectionHeaderCell: UICollectionReusableView {
    
    // MARK: properties
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = "검색어를 입력해 주세요"
        return label
    }()
    
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: configure
    func configure() {
        
        backgroundColor = .white
        
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(150)
            make.centerX.equalToSuperview()
        }
        
    }
}

