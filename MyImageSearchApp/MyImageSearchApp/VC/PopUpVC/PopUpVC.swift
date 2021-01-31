//
//  PopUpVC.swift
//  MyImageSearchApp
//
//  Created by 김동현 on 2021/01/31.
//

import UIKit

protocol PopUpVCDelegate: class {
    func didTapSortButton(sortType: Sort)
}

class PopUpVC: UIViewController {
    
    // MARK: - Properties
    
    private let accuracyButton: SortButton = {
        let button = SortButton(sortTitle: "정확도순")
        button.addTarget(self, action: #selector(didTapSortButton), for: .touchUpInside)
        return button
    }()
    private let recencyButton: SortButton = {
        let button = SortButton(sortTitle: "최신순")
        button.addTarget(self, action: #selector(didTapSortButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [accuracyButton, recencyButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()
    
    weak var delegate: PopUpVCDelegate?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        dismissAni()
    }
    
    // MARK: - Actions
    
    @objc private func didTapSortButton(sender: UIButton) {
        
        if sender == accuracyButton {
            delegate?.didTapSortButton(sortType: .accuracy)
        } else {
            delegate?.didTapSortButton(sortType: .recency)
        }
        dismissAni()
    }
    
    // MARK: - Helpers
    
    private func dismissAni() {
        UIView.animate(withDuration: 0.5) { [ weak self] in
            self?.view.backgroundColor = .clear
        } completion: { [weak self] (_) in
            self?.dismiss(animated: true)
        }
    }
    
    // MARK: - ConfigureViews
    
    private func configureViews() {
        
        view.backgroundColor = .black
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        view.addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints { (make) in
            make.centerY.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width * 0.8)
            make.height.equalTo(100)
        }
        
    }
    
}
