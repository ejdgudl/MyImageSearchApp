//
//  LauchVC.swift
//  MyImageSearchApp
//
//  Created by 김동현 on 2021/01/31.
//

import UIKit

class LauchVC: UIViewController {
    
    // MARK: - Properties
    
    private let imageView = UIImageView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        setImage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            let mainVC = MainVC(kakaoService: KakaoService())
            let nav = UINavigationController(rootViewController: mainVC)
            nav.modalPresentationStyle = .fullScreen
            self?.present(nav, animated: true, completion: {
                self?.imageView.removeFromSuperview()
            })
        }
        
    }
    
    // MARK: - Helpers
    
    private func setImage() {
        guard let url = URL(string: "https://app.jjalbang.today/jjv1Im.gif") else { return }
        imageView.kf.setImage(with: url)
    }
    
    // MARK: - ConfigureViews
    
    private func configureViews() {
        
        view.backgroundColor = .white
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
}
