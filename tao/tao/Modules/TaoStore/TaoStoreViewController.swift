//
//  TaoStoreViewController.swift
//  tao
//
//  Created by Mayank Khursija on 03/06/22.
//

import Foundation

enum TaoStoreSections: String {
    case categories
    case banners
    case trending
}

class TaoStoreViewController: BaseViewController<TaoStoreViewModel> {
    
    var categoriesCollectionView: UICollectionView
    var bannersCollectionView: UICollectionView
    var trendingCollectionView: UICollectionView
    
    var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search for anything"
        searchBar.searchTextField.font = UIFont(name: "Poppins", size: 16)
        searchBar.searchTextField.backgroundColor = .white
        searchBar.backgroundColor = .white
        return searchBar
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 18)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    } ()
    
    override init(_ viewModel: TaoStoreViewModel) {
        let categoriesCollectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        categoriesCollectionViewLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        categoriesCollectionViewLayout.scrollDirection = .horizontal
        self.categoriesCollectionView = UICollectionView(frame: .zero,
                                                         collectionViewLayout: categoriesCollectionViewLayout)
        self.categoriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let bannersCollectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        bannersCollectionViewLayout.scrollDirection = .horizontal
        self.bannersCollectionView = UICollectionView(frame: .zero,
                                                      collectionViewLayout: bannersCollectionViewLayout)
        self.bannersCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let trendingCollectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        trendingCollectionViewLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        trendingCollectionViewLayout.scrollDirection = .vertical

        self.trendingCollectionView = UICollectionView(frame: .zero,
                                                         collectionViewLayout: trendingCollectionViewLayout)
        self.trendingCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.enableScrollView = false
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupNavigationBar()
        self.setupView()
        
        self.categoriesCollectionView.delegate = self
        self.categoriesCollectionView.dataSource = self
        self.categoriesCollectionView.showsHorizontalScrollIndicator = false
        self.categoriesCollectionView.register(TaoStoreCategoryViewCell.self, forCellWithReuseIdentifier: TaoStoreSections.categories.rawValue)
        
        self.bannersCollectionView.delegate = self
        self.bannersCollectionView.dataSource = self
        self.bannersCollectionView.showsHorizontalScrollIndicator = false
        self.bannersCollectionView.register(BannerViewCell.self, forCellWithReuseIdentifier: TaoStoreSections.banners.rawValue)
        
        self.trendingCollectionView.delegate = self
        self.trendingCollectionView.dataSource = self
        self.trendingCollectionView.showsHorizontalScrollIndicator = false
        self.trendingCollectionView.register(TrendingViewCell.self, forCellWithReuseIdentifier: TaoStoreSections.trending.rawValue)
        self.trendingCollectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell")

        self.trendingCollectionView.showsVerticalScrollIndicator = false
        
        self.titleLabel.text = "Trending Now"
        
        self.searchBar.delegate = self
        
    }
    
    func setupView() {
        self.view.addSubview(self.trendingCollectionView)
        
        
        self.trendingCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                                                           constant: 60).isActive = true
        self.trendingCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor,
                                                            constant: 8).isActive = true
        self.trendingCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor,
                                                             constant: -8).isActive = true
        self.trendingCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,
                                                            constant: -8).isActive = true
    }
    
    func setupNavigationBar() {
        let navigationBar = UINavigationBar(frame: .zero)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.backgroundColor = .white
        navigationBar.barTintColor = .white
        navigationBar.shadowImage = UIImage()
        
        
        navigationBar.layer.masksToBounds = false
        navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        navigationBar.layer.shadowOpacity = 0.8
        navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        navigationBar.layer.shadowRadius = 2
        
        
        navigationBar.titleTextAttributes = [.font : UIFont(name: "Poppins-Medium", size: 18)!]
        
        self.view.addSubview(navigationBar)
        
        navigationBar.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        navigationBar.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        navigationBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        navigationBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        let navigationItem = UINavigationItem(title: "Reward Store")
        
        let walletButton = UIButton(type: .custom)
        walletButton.setImage(UIImage(named: "wallet"), for: .normal)
        walletButton.addTarget(self, action: #selector(walletTapped), for: .touchUpInside)
        walletButton.backgroundColor = .lightBlueBackground
        walletButton.layer.cornerRadius = 8
        walletButton.tintColor = .black
        walletButton.widthAnchor.constraint(equalToConstant: 36).isActive = true
        walletButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        let notificationButton = UIButton(type: .custom)
        notificationButton.setImage(UIImage(named: "notify"), for: .normal)
        notificationButton.addTarget(self, action: #selector(notificationTapped), for: .touchUpInside)
        notificationButton.backgroundColor = .lightBlueBackground
        notificationButton.layer.cornerRadius = 8
        notificationButton.tintColor = .black
        notificationButton.widthAnchor.constraint(equalToConstant: 36).isActive = true
        notificationButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: notificationButton),
                                              UIBarButtonItem(customView: walletButton)]
        
        navigationBar.setItems([navigationItem], animated: false)
    }
    
    override func reloadView() {
        super.reloadView()
        self.categoriesCollectionView.reloadData()
        self.bannersCollectionView.reloadData()
        self.trendingCollectionView.reloadData()
    }
    
    @objc func walletTapped() {
        self.viewModel.walletTapped()
    }
    
    @objc func notificationTapped() {
        self.viewModel.notificationTapped()
    }
}

//MARK: Cateogry Collection View Cell Protocols
extension TaoStoreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.categoriesCollectionView {
            return self.viewModel.numberOfCategories
        } else if collectionView == self.bannersCollectionView {
            return self.viewModel.numberOfWidgets
        } else if collectionView == self.trendingCollectionView {
            return self.viewModel.numberOfTrendingProducts
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.categoriesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaoStoreSections.categories.rawValue,
                                                          for: indexPath) as? TaoStoreCategoryViewCell ?? TaoStoreCategoryViewCell(frame: .zero)
            cell.backgroundColor = .newDarkBlueBackground
            let category = self.viewModel.getCategory(index: indexPath.row)
            if let url = URL(string: category?.imageUrl ?? "") {
                let vm = InstructionViewModel(text: .plain(category?.name ?? ""),
                                              image: .withURL(url))
                cell.setupCell(viewModel: vm)
            }
            cell.backgroundColor = UIColor(hex: category?.bgColor ?? "#000000")
            cell.layer.cornerRadius = 16
            return cell

        } else if collectionView == self.bannersCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaoStoreSections.banners.rawValue,
                                                          for: indexPath) as? BannerViewCell ?? BannerViewCell(frame: .zero)
            let widget = self.viewModel.getWidget(index: indexPath.row)
            if let url = URL(string: widget?.imageUrl ?? "") {
                cell.setupImage(image: .withURL(url))
            }
            return cell
        } else if collectionView == self.trendingCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaoStoreSections.trending.rawValue,
                                                          for: indexPath) as? TrendingViewCell ?? TrendingViewCell(frame: .zero)
            if let product = self.viewModel.getTrendingProduct(index: indexPath.row) {
                cell.setup(product: product)
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.categoriesCollectionView {
            return CGSize(width: 90, height: 90)
        } else if collectionView == self.bannersCollectionView {
            return CGSize(width: 348, height: 116)
        } else if collectionView == self.trendingCollectionView {
            return CGSize(width: (self.trendingCollectionView.frame.width / 2 ) - 16, height: 300)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView == self.trendingCollectionView, kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: "headerCell",
                                                                             for: indexPath)
            
            headerView.subviews.forEach({ $0.removeFromSuperview() })
            if self.viewModel.numberOfWidgets != 0 && self.viewModel.numberOfCategories != 0 {
                headerView.addSubview(self.searchBar)
                headerView.addSubview(self.categoriesCollectionView)
                headerView.addSubview(self.bannersCollectionView)
                headerView.addSubview(self.titleLabel)
                
                self.searchBar.topAnchor.constraint(equalTo: headerView.topAnchor,
                                                    constant: 8).isActive = true
                self.searchBar.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 32).isActive = true
                self.searchBar.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -32).isActive = true
                self.searchBar.heightAnchor.constraint(equalToConstant: 54).isActive = true
                
                self.categoriesCollectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor,
                                                                   constant: 16).isActive = true
                self.categoriesCollectionView.leftAnchor.constraint(equalTo: headerView.leftAnchor,
                                                                    constant: 8).isActive = true
                self.categoriesCollectionView.rightAnchor.constraint(equalTo: headerView.rightAnchor,
                                                                     constant: -8).isActive = true
                self.categoriesCollectionView.heightAnchor.constraint(equalToConstant: 90).isActive = true
                
                self.bannersCollectionView.topAnchor.constraint(equalTo: self.categoriesCollectionView.bottomAnchor,
                                                                   constant: 16).isActive = true
                self.bannersCollectionView.leftAnchor.constraint(equalTo: headerView.leftAnchor,
                                                                    constant: 8).isActive = true
                self.bannersCollectionView.rightAnchor.constraint(equalTo: headerView.rightAnchor,
                                                                     constant: -8).isActive = true
                self.bannersCollectionView.heightAnchor.constraint(equalToConstant: 116).isActive = true
                
                self.titleLabel.topAnchor.constraint(equalTo: self.bannersCollectionView.bottomAnchor,
                                                                   constant: 16).isActive = true
                self.titleLabel.leftAnchor.constraint(equalTo: headerView.leftAnchor,
                                                                    constant: 8).isActive = true
                self.titleLabel.rightAnchor.constraint(equalTo: headerView.rightAnchor,
                                                                     constant: -8).isActive = true
            } else if self.viewModel.numberOfWidgets == 0 && self.viewModel.numberOfCategories == 0 {
                
                headerView.addSubview(self.searchBar)
                headerView.addSubview(self.titleLabel)
                
                self.searchBar.topAnchor.constraint(equalTo: headerView.topAnchor,
                                                    constant: 8).isActive = true
                self.searchBar.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 32).isActive = true
                self.searchBar.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -32).isActive = true
                self.searchBar.heightAnchor.constraint(equalToConstant: 54).isActive = true
                
                
                self.titleLabel.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor,
                                                                   constant: 16).isActive = true
                self.titleLabel.leftAnchor.constraint(equalTo: headerView.leftAnchor,
                                                                    constant: 8).isActive = true
                self.titleLabel.rightAnchor.constraint(equalTo: headerView.rightAnchor,
                                                                     constant: -8).isActive = true
                
            } else if self.viewModel.numberOfWidgets == 0 {
                headerView.addSubview(self.searchBar)
                headerView.addSubview(self.categoriesCollectionView)
                headerView.addSubview(self.titleLabel)
                
                self.searchBar.topAnchor.constraint(equalTo: headerView.topAnchor,
                                                    constant: 8).isActive = true
                self.searchBar.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 32).isActive = true
                self.searchBar.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -32).isActive = true
                self.searchBar.heightAnchor.constraint(equalToConstant: 54).isActive = true
                
                self.categoriesCollectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor,
                                                                   constant: 16).isActive = true
                self.categoriesCollectionView.leftAnchor.constraint(equalTo: headerView.leftAnchor,
                                                                    constant: 8).isActive = true
                self.categoriesCollectionView.rightAnchor.constraint(equalTo: headerView.rightAnchor,
                                                                     constant: -8).isActive = true
                self.categoriesCollectionView.heightAnchor.constraint(equalToConstant: 90).isActive = true
                
                self.titleLabel.topAnchor.constraint(equalTo: self.categoriesCollectionView.bottomAnchor,
                                                                   constant: 16).isActive = true
                self.titleLabel.leftAnchor.constraint(equalTo: headerView.leftAnchor,
                                                                    constant: 8).isActive = true
                self.titleLabel.rightAnchor.constraint(equalTo: headerView.rightAnchor,
                                                                     constant: -8).isActive = true
                
            } else if self.viewModel.numberOfCategories == 0 {
                headerView.addSubview(self.searchBar)
                headerView.addSubview(self.bannersCollectionView)
                headerView.addSubview(self.titleLabel)
                
                self.searchBar.topAnchor.constraint(equalTo: headerView.topAnchor,
                                                    constant: 8).isActive = true
                self.searchBar.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 32).isActive = true
                self.searchBar.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -32).isActive = true
                self.searchBar.heightAnchor.constraint(equalToConstant: 54).isActive = true
                
                self.bannersCollectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor,
                                                                   constant: 16).isActive = true
                self.bannersCollectionView.leftAnchor.constraint(equalTo: headerView.leftAnchor,
                                                                    constant: 8).isActive = true
                self.bannersCollectionView.rightAnchor.constraint(equalTo: headerView.rightAnchor,
                                                                     constant: -8).isActive = true
                self.bannersCollectionView.heightAnchor.constraint(equalToConstant: 116).isActive = true
                
                self.titleLabel.topAnchor.constraint(equalTo: self.bannersCollectionView.bottomAnchor,
                                                                   constant: 16).isActive = true
                self.titleLabel.leftAnchor.constraint(equalTo: headerView.leftAnchor,
                                                                    constant: 8).isActive = true
                self.titleLabel.rightAnchor.constraint(equalTo: headerView.rightAnchor,
                                                                     constant: -8).isActive = true
            }
            
            return headerView
        }
        return UICollectionReusableView()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.trendingCollectionView {
            self.viewModel.didSelectTrendingItem(at: indexPath.row)
        } else if collectionView == self.categoriesCollectionView {
            self.viewModel.didSelectCategoryItem(at: indexPath.row)
        } else if collectionView == self.bannersCollectionView {
            self.viewModel.didSelectBannerItem(at: indexPath.row)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        var height: CGFloat = 350
        if collectionView == self.trendingCollectionView, section == 0 {
            
            if self.viewModel.numberOfWidgets == 0 {
                height -= 130
            }
            
            if self.viewModel.numberOfCategories == 0 {
                height -= 100
            }
            
            return CGSize(width: collectionView.frame.size.width, height: height)
        }
        return .zero
    }
}

//MARK: Search bar Protocols
extension TaoStoreViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.viewModel.searchButtonTapped()
        searchBar.setShowsCancelButton(false, animated: true)
        return false
    }
}
