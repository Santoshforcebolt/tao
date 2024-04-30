//
//  CompetitionEventsViewController.swift
//  tao
//
//  Created by Mayank Khursija on 14/08/22.
//

import Foundation

class CompetitionEventsViewController: BaseViewController<CompetitionEventsViewModel> {
    var navigationBar: UINavigationBar?
    
    var storyCollectionView: UICollectionView
    
    override init(_ viewModel: CompetitionEventsViewModel) {
        let storyCollectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        storyCollectionViewLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        storyCollectionViewLayout.scrollDirection = .vertical
        
        self.storyCollectionView = UICollectionView(frame: .zero, collectionViewLayout: storyCollectionViewLayout)
        self.storyCollectionView.translatesAutoresizingMaskIntoConstraints = false
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
        
        self.storyCollectionView.delegate = self
        self.storyCollectionView.dataSource = self
        self.storyCollectionView.register(MediaViewCell.self, forCellWithReuseIdentifier: "cell")
        self.storyCollectionView.showsVerticalScrollIndicator = false
        
        let storyCollectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        storyCollectionViewLayout.scrollDirection = .vertical
        storyCollectionViewLayout.minimumInteritemSpacing = 8
        
        // left margin of collection view + right margin of collection view + (number of cells in row - 1) * interItemSpace = 56
        storyCollectionViewLayout.itemSize = CGSize(width: Int((self.view.frame.size.width - 56)/4), height: 120)
        
        self.storyCollectionView.setCollectionViewLayout(storyCollectionViewLayout, animated: true)
    }
    
    func setupView() {
        self.view.addSubview(self.storyCollectionView)
        
        self.storyCollectionView.topAnchor.constraint(equalTo: self.navigationBar?.bottomAnchor ?? self.view.topAnchor,
                                                         constant: 16).isActive = true
        self.storyCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor,
                                                         constant: 16).isActive = true
        self.storyCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor,
                                                         constant: -16).isActive = true
        self.storyCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,
                                                         constant: -16).isActive = true
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
        let title: String
        switch self.viewModel.flow {
        case .competition:
            title = "Events"
        case .user:
            title = "My Competitions"
        }
        let navigationItem = UINavigationItem(title: title)
        
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
        self.storyCollectionView.reloadData()
    }
}
extension CompetitionEventsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.entries?.body?.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row >= (self.viewModel.entries?.body?.data?.count ?? 0)/2 {
            self.viewModel.loadMediaEntries()
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                      for: indexPath) as? MediaViewCell ?? MediaViewCell(frame: .zero)

        if let mediaEntry = self.viewModel.entries?.body?.data?[indexPath.row] {
            if let imageUrlString = mediaEntry.thumbnailURL,
               let count = mediaEntry.views {
                cell.setup(urlString: imageUrlString, count: "\(count)")
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.itemSelected(index: indexPath.row)
    }
}
