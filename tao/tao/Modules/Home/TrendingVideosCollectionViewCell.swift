//
//  TrendingVideosCollectionViewCell.swift
//  tao
//
//  Created by Mayank Khursija on 29/08/22.
//

import Foundation

class TrendingVideosCollectionViewCell: UICollectionViewCell {
    var competitionsCollectionView: UICollectionView
    
    var vm: TrendingVideosCollectionViewModel?
    
    override init(frame: CGRect) {
        let categoryCollectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        categoryCollectionViewLayout.scrollDirection = .horizontal
        self.competitionsCollectionView = UICollectionView(frame: .zero,
                                                      collectionViewLayout: categoryCollectionViewLayout)
        self.competitionsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.contentView.addSubview(self.competitionsCollectionView)
        
        self.competitionsCollectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.competitionsCollectionView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        self.competitionsCollectionView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        self.competitionsCollectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
        
        self.competitionsCollectionView.delegate = self
        self.competitionsCollectionView.dataSource = self
        self.competitionsCollectionView.showsHorizontalScrollIndicator = false
        self.competitionsCollectionView.register(MediaViewCell.self,
                                            forCellWithReuseIdentifier: "cell")
        let storyCollectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        storyCollectionViewLayout.scrollDirection = .horizontal
        storyCollectionViewLayout.minimumInteritemSpacing = 8
        
        // left margin of collection view + right margin of collection view + (number of cells in row - 1) * interItemSpace = 56
        storyCollectionViewLayout.itemSize = CGSize(width: Int((self.contentView.frame.size.width - 56)/4), height: 120)
        
        self.competitionsCollectionView.setCollectionViewLayout(storyCollectionViewLayout, animated: true)
    }
    
    func setupData(vm: TrendingVideosCollectionViewModel) {
        self.vm = vm
        self.competitionsCollectionView.reloadData()
    }
}

extension TrendingVideosCollectionViewCell: UICollectionViewDelegate,
                                              UICollectionViewDataSource,
                                              UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.vm?.competitions?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                      for: indexPath) as? MediaViewCell ?? MediaViewCell()

        if let mediaEntry = self.vm?.competitions?[indexPath.row] {
            if let imageUrlString = mediaEntry.thumbnailURL,
               let count = mediaEntry.views {
                cell.setup(urlString: imageUrlString, count: "\(count)")
            }
        }
        cell.cornerRadius = 8
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.vm?.trendingItemSelected(index: indexPath.row)
    }
    
}

