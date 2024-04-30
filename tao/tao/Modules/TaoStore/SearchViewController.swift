//
//  SearchViewController.swift
//  tao
//
//  Created by Mayank Khursija on 06/06/22.
//

import Foundation

class SearchViewController: BaseViewController<SearchViewModel> {
    
    var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchTextField.font = UIFont(name: "Poppins", size: 16)
        searchBar.searchTextField.backgroundColor = .white
        searchBar.backgroundColor = .white
        return searchBar
    }()
    
    var closeButton: UIButton = {
        let backbutton = UIButton(frame: .zero)
        backbutton.translatesAutoresizingMaskIntoConstraints = false
        backbutton.setImage(UIImage(systemName: "clear"), for: .normal)
        backbutton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        backbutton.backgroundColor = .lightBlueBackground
        backbutton.layer.cornerRadius = 8
        backbutton.tintColor = .black
        return backbutton
    }()
    
    var productCollectionView: UICollectionView
    
    override init(_ viewModel: SearchViewModel) {
        let trendingCollectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        trendingCollectionViewLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        trendingCollectionViewLayout.scrollDirection = .vertical

        self.productCollectionView = UICollectionView(frame: .zero,
                                                         collectionViewLayout: trendingCollectionViewLayout)
        self.productCollectionView.translatesAutoresizingMaskIntoConstraints = false
        super.init(viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.enableScrollView = false
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.setupView()
        
        self.searchBar.becomeFirstResponder()
        self.searchBar.delegate = self
        
        self.productCollectionView.delegate = self
        self.productCollectionView.dataSource = self
        self.productCollectionView.showsHorizontalScrollIndicator = false
        
        switch self.viewModel.searchFlow {
        case .user:
            self.productCollectionView.register(UserSearchViewCell.self, forCellWithReuseIdentifier: "searchCell")
        case .product:
            self.productCollectionView.register(TrendingViewCell.self, forCellWithReuseIdentifier: TaoStoreSections.trending.rawValue)
        }
        
        self.productCollectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell")

        self.productCollectionView.showsVerticalScrollIndicator = false
        
        
    }
    
    func setupView() {
        self.view.addSubview(self.searchBar)
        self.view.addSubview(self.closeButton)
        self.view.addSubview(self.productCollectionView)
        
        self.searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.searchBar.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        self.searchBar.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -54).isActive = true
        self.searchBar.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        self.closeButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 6).isActive = true
        self.closeButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -8).isActive = true
        self.closeButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        self.closeButton.widthAnchor.constraint(equalToConstant: 36).isActive = true
        
        
        self.productCollectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor,
                                                           constant: 32).isActive = true
        self.productCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor,
                                                            constant: 8).isActive = true
        self.productCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor,
                                                             constant: -8).isActive = true
        self.productCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,
                                                            constant: -8).isActive = true
    }
    
    override func reloadView() {
        super.reloadView()
        self.productCollectionView.reloadData()
    }
    
    @objc func closeButtonTapped() {
        super.backAction()
        self.viewModel.closeButtonTapped()
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.viewModel.searchFlow {
        case .user:
            return self.viewModel.numberOfUsers
        case .product:
            return self.viewModel.numberOfItems
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch self.viewModel.searchFlow {
        case .user:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell",
                                                          for: indexPath) as? UserSearchViewCell ?? UserSearchViewCell(frame: .zero)
            if let user = self.viewModel.getUser(index: indexPath.row) {
                if let imageUrlString = user.imageUrl,
                   let imageUrl = URL(string: imageUrlString) {
                    cell.setupData(name: user.title ?? "",
                                   image: .withURL(imageUrl),
                                   info: user.subTitle ?? "")
                } else {
                    //FIXME: Change default image
                    cell.setupData(name: user.title ?? "",
                                   image: .withImage(UIImage(systemName: "defaultLeaderboardPicture")!),
                                   info: user.subTitle ?? "")
                }
            }
            cell.backgroundColor = .grayBackground
            return cell
        case .product:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaoStoreSections.trending.rawValue,
                                                          for: indexPath) as? TrendingViewCell ?? TrendingViewCell(frame: .zero)
            if let product = self.viewModel.getItem(index: indexPath.row) {
                cell.setup(product: product)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch self.viewModel.searchFlow {
        case .user:
            return CGSize(width: self.productCollectionView.frame.width, height: 84)
        case .product:
            return CGSize(width: (self.productCollectionView.frame.width / 2 ) - 16, height: 300)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.itemSelected(at: indexPath.row)
    }
}

//MARK: Search bar Protocols
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.performSearch(query: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
