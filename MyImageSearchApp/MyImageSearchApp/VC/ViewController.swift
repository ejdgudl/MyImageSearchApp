//
//  ViewController.swift
//  MyImageSearchApp
//
//  Created by 김동현 on 2021/01/25.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    
    private var documents: [Document]? {
        didSet {
            guard let documents = documents else { return }
            print(documents)
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureNavi()
        configureViews()
        searchImages(keyward: "콜라")
    }
    
    // MARK: - Actions
    
    
    // MARK: - Helpers
    
    func searchImages(keyward: String) {
        KakaoService.shared.getImages(keyward: keyward) { [weak self] (res) in
            switch res {
            case .success(let res):
                self?.documents = res.documents
            case .failure(let err):
                err.descriptionPrint()
            }
        }
    }
    
    // MARK: - Configure
    
    private func configure() {
        
    }
    
    // MARK: - ConfigureNavi
    
    private func configureNavi() {
        
    }
    
    // MARK: - ConfigureViews
    
    private func configureViews() {
        view.backgroundColor = .red
    }


}

