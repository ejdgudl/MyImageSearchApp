//
//  SortButton.swift
//  MyImageSearchApp
//
//  Created by 김동현 on 2021/01/31.
//

import UIKit

class SortButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(sortTitle: String) {
        super.init(frame: .zero)
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        setTitleColor(.black, for: .normal)
        setTitle(sortTitle, for: .normal)
        backgroundColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
