//
//  TaoTvViewController.swift
//  tao
//
//  Created by Mayank Khursija on 08/06/22.
//

import Foundation
import AVKit

class TaoTvViewController: BaseViewController<TaoTvViewModel> {
    
    var storyCollectionView: UICollectionView
    var pillsCollectionView: UICollectionView
    
    var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search for anything"
        searchBar.searchTextField.font = UIFont(name: "Poppins", size: 16)
        searchBar.searchTextField.backgroundColor = .white
        searchBar.backgroundColor = .white
        return searchBar
    }()
    
    var navigationBar: UINavigationBar?
    
    override init(_ viewModel: TaoTvViewModel) {
        let categoriesCollectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        categoriesCollectionViewLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        categoriesCollectionViewLayout.scrollDirection = .horizontal
        categoriesCollectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        self.pillsCollectionView = UICollectionView(frame: .zero,
                                                         collectionViewLayout: categoriesCollectionViewLayout)
        self.pillsCollectionView.translatesAutoresizingMaskIntoConstraints = false
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
        self.storyCollectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell")
        
        self.pillsCollectionView.delegate = self
        self.pillsCollectionView.dataSource = self
        self.pillsCollectionView.showsHorizontalScrollIndicator = false
        self.pillsCollectionView.register(PillViewCell.self,
                                          forCellWithReuseIdentifier: "pillCell")
        
        
        let storyCollectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        storyCollectionViewLayout.scrollDirection = .vertical
        storyCollectionViewLayout.minimumInteritemSpacing = 8
        
        // left margin of collection view + right margin of collection view + (number of cells in row - 1) * interItemSpace = 56
        storyCollectionViewLayout.itemSize = CGSize(width: Int((self.view.frame.size.width - 56)/4), height: 120)
        
        self.storyCollectionView.setCollectionViewLayout(storyCollectionViewLayout, animated: true)
        self.searchBar.delegate = self
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
        
        let navigationItem = UINavigationItem(title: "Tao TV")
        
        navigationBar.setItems([navigationItem], animated: false)
    }

    override func reloadView() {
        super.reloadView()
        self.storyCollectionView.reloadData()
    }
}

extension TaoTvViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.storyCollectionView {
            return self.viewModel.numberOfEntries
        } else if collectionView == self.pillsCollectionView {
            return self.viewModel.pills.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.storyCollectionView {
            if indexPath.row >= self.viewModel.numberOfEntries/2 {
                self.viewModel.loadMediaEntries()
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                          for: indexPath) as? MediaViewCell ?? MediaViewCell(frame: .zero)
            let mediaEntry = self.viewModel.getMediaItem(index: indexPath.row)
            if let imageUrlString = mediaEntry?.thumbnailURL,
               let count = mediaEntry?.views {
                cell.setup(urlString: imageUrlString, count: "\(count)")
            }
            return cell
        } else if collectionView == self.pillsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pillCell",
                                                          for: indexPath) as? PillViewCell ?? PillViewCell(frame: .zero)
            cell.setup(text: self.viewModel.pills[indexPath.row])
            cell.backgroundColor = .grayBackground
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.storyCollectionView {
            self.viewModel.itemSelected(index: indexPath.row)
        } else if collectionView == self.pillsCollectionView {
            self.viewModel.pillSelected(index: indexPath.row)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView == self.storyCollectionView, kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: "headerCell",
                                                                             for: indexPath)
            
            headerView.subviews.forEach({ $0.removeFromSuperview() })
            headerView.addSubview(self.searchBar)
            headerView.addSubview(self.pillsCollectionView)
            
            self.searchBar.topAnchor.constraint(equalTo: headerView.topAnchor,
                                                constant: 8).isActive = true
            self.searchBar.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 32).isActive = true
            self.searchBar.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -32).isActive = true
            self.searchBar.heightAnchor.constraint(equalToConstant: 54).isActive = true
            
            self.pillsCollectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor,
                                                               constant: 8).isActive = true
            self.pillsCollectionView.leftAnchor.constraint(equalTo: headerView.leftAnchor,
                                                                constant: 8).isActive = true
            self.pillsCollectionView.rightAnchor.constraint(equalTo: headerView.rightAnchor,
                                                                 constant: -8).isActive = true
            self.pillsCollectionView.heightAnchor.constraint(equalToConstant: 40).isActive = true
            
            return headerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if collectionView == self.storyCollectionView {
            return CGSize(width: self.storyCollectionView.frame.width, height: 120)
        }
        return .zero
    }
    
}

extension TaoTvViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.viewModel.searchButtonTapped()
        searchBar.setShowsCancelButton(false, animated: true)
        return false
    }
}
