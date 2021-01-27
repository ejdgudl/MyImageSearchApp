//
//  MainVC.swift
//  MyImageSearchApp
//
//  Created by 김동현 on 2021/01/25.
//

import UIKit
import SnapKit

fileprivate let imageCellID = "imageCell"

class MainVC: UIViewController {

    // MARK: - Properties
    
    var kakaoService: KakaoServiceable
    
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
    
    private var searchTimer: Timer?
    
    private var searchHistory = ""
    
    private var page = 0
    private var isEnd = false
    
    // MARK: - Life Cycle
    
    init(kakaoService: KakaoServiceable) {
        self.kakaoService = kakaoService
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
    
    
    // MARK: - Helpers
    
    private func searchImages(keyward: String, page: Int = 1, completion: @escaping ([Document]) -> ()) {
        kakaoService.getImages(keyward: keyward, sort: .accuracy, page: page) { [weak self] (res) in
            switch res {
            case .success(let res):
                self?.isEnd = res.meta.isEnd
                if res.documents.count == 0 {
                    AlertManager.shared.noResult(vc: self!)
                }
                completion(res.documents)
            case .failure(let err):
                print(err.errorDescription)
            }
        }
    }
    
    // MARK: - Configure
    
    private func configure() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: imageCellID)
        searchController.searchResultsUpdater = self
    }
    
    // MARK: - ConfigureNavi
    
    private func configureNavi() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navigationTtileButton)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
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
        guard let document = documents?[indexPath.row] else { return UICollectionViewCell() }
        cell.viewModel = ImageCellViewModel(document: document)
        
        /// Paging
        let count = documents?.count ?? 0
        if indexPath.item == count - 1 && !isEnd {
            page += 1
            searchImages(keyward: searchHistory, page: page) { [weak self] documents in
                documents.forEach {
                    self?.documents?.append($0)
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let document = documents?[indexPath.row] else { return }
        let detailVC = DetailVC(viewModel: DetailVCViewModel(document: document))
        let nav = UINavigationController(rootViewController: detailVC)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }

}

// MARK: - UICollectionView DelegateFlowLayout

extension MainVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width) / 3 - 2, height: (view.frame.width) / 3 - 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
    
}

// MARK: - UISearch Results Updating

extension MainVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard searchController.searchBar.searchTextField.text != "" else {
            return
        }
        
        searchTimer?.invalidate()
        print("Timer Start")
        
        searchTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (timer) in
            
            self?.searchTimer?.invalidate()
            self?.searchHistory = self?.searchController.searchBar.searchTextField.text ?? ""
            print("Timer End")
            
            guard let text = self?.searchController.searchBar.searchTextField.text else { return }
            
            // request
            self?.searchImages(keyward: text, completion: { documents in
                self?.documents = documents
                self?.page = 1
                self?.searchController.isActive = false
            })
            
        })
        
    }
    
}
