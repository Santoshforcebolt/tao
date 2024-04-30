//
//  CategoryProductViewController.swift
//  tao
//
//  Created by Mayank Khursija on 12/08/22.
//

import Foundation

class CategoryProductViewController: BaseViewController<CategoryProductViewModel> {
    var navigationBar: UINavigationBar?
    var trendingCollectionView: UICollectionView

    override init(_ viewModel: CategoryProductViewModel) {
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
        
        self.trendingCollectionView.delegate = self
        self.trendingCollectionView.dataSource = self
        self.trendingCollectionView.showsHorizontalScrollIndicator = false
        self.trendingCollectionView.register(TrendingViewCell.self, forCellWithReuseIdentifier: TaoStoreSections.trending.rawValue)
        self.trendingCollectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell")

        self.trendingCollectionView.showsVerticalScrollIndicator = false
        
    }
    
    func setupView() {
        self.view.addSubview(self.trendingCollectionView)
        
        
        self.trendingCollectionView.topAnchor.constraint(equalTo: self.navigationBar?.bottomAnchor ?? self.view.topAnchor,
                                                           constant: 16).isActive = true
        self.trendingCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor,
                                                            constant: 8).isActive = true
        self.trendingCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor,
                                                             constant: -8).isActive = true
        self.trendingCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,
                                                            constant: -8).isActive = true
    }
    
    func setupNavigationBar() {
        let navigationBar = UINavigationBar(frame: .zero)
        self.navigationBar = navigationBar
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
        
        let navigationItem = UINavigationItem(title: "Products")
        
        let backbutton = UIButton(type: .custom)
        backbutton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backbutton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        backbutton.backgroundColor = .lightBlueBackground
        backbutton.layer.cornerRadius = 8
        backbutton.tintColor = .black
        backbutton.widthAnchor.constraint(equalToConstant: 36).isActive = true
        backbutton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
        
        navigationBar.setItems([navigationItem], animated: false)
    }
    
    override func backAction() {
        super.backAction()
        self.viewModel.backButtonTapped()
    }
    
    override func reloadView() {
        super.reloadView()
        self.trendingCollectionView.reloadData()
    }
}

extension CategoryProductViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.products?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaoStoreSections.trending.rawValue,
                                                      for: indexPath) as? TrendingViewCell ?? TrendingViewCell(frame: .zero)
        if let product = self.viewModel.products?[indexPath.row] {
            cell.setup(product: product)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.trendingCollectionView.frame.width / 2 ) - 16, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.trendingCollectionView {
            self.viewModel.didSelectItem(at: indexPath.row)
        }
    }
}
