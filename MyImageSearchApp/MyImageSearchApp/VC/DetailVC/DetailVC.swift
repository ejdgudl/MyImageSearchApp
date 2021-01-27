//
//  DetailVC.swift
//  MyImageSearchApp
//
//  Created by 김동현 on 2021/01/26.
//

import UIKit

class DetailVC: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel: DetailVCViewModel
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.kf.setImage(with: viewModel.imageURL)
        return imageView
    }()
    
    private lazy var bottomSubLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.bottomSubLableText
        return label
    }()
    
    // MARK: - Life Cycle
    
    init(viewModel: DetailVCViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureNavi()
        configureViews()
    }
    
    // MARK: - Actions
    
    @objc private func didTapDismissButton() {
        dismiss(animated: true)
    }
    
    // MARK: - Helpers
    
    
    // MARK: - Configure
    
    private func configure() {
        
    }
    
    // MARK: - ConfigureNavi
    
    private func configureNavi() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapDismissButton))
    }
    
    // MARK: - ConfigureViews
    
    private func configureViews() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        [imageView, bottomSubLabel].forEach {
            scrollView.addSubview($0)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.top.centerX.centerY.width.equalToSuperview()
            make.bottom.equalTo(bottomSubLabel.snp.top)
        }
        
        bottomSubLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
}
