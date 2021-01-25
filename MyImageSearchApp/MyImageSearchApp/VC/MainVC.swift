//
//  MainVC.swift
//  MyImageSearchApp
//
//  Created by 김동현 on 2021/01/25.
//

import UIKit
import SnapKit

private let imageCellID = "imageCell"

class MainVC: UIViewController {

    // MARK: - Properties
    
    private var documents: [Document]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private let navigationTtileButton: UIButton = {
        let button = UIButton()
        button.setTitle("KAKAO", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -30, bottom: 0, right: 0)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.frame.size = CGSize(width: 100, height: 30)
        button.isEnabled = false
        return button
    }()
    
    private lazy var searchBarButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .light, scale: .default)
        let image = UIImage(systemName: "magnifyingglass", withConfiguration: config)
        button.tintColor = .black
        button.setImage(image, for: .normal)
        button.frame.size = CGSize(width: 30, height: 30)
        return button
    }()
    
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search images"
        return searchController
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        return view
    }()
    
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
    
    private func searchImages(keyward: String) {
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
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: imageCellID)
    }
    
    // MARK: - ConfigureNavi
    
    private func configureNavi() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navigationTtileButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBarButton)
        navigationItem.searchController = searchController
    }
    
    // MARK: - ConfigureViews
    
    private func configureViews() {
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

// MARK: - UIColectionView Delegate, DataSource

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return documents?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCellID, for: indexPath) as? ImageCell else { return UICollectionViewCell() }
        cell.document = documents?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // FIXME: - present some VC
    }

}

// MARK: - UICollectionView DelegateFlowLayout

extension MainVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width) / 3 - 1, height: (view.frame.width) / 3 - 1)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 1
        }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}
