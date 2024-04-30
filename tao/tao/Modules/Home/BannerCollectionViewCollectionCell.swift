//
//  BannerCollectionViewCollectionCell.swift
//  tao
//
//  Created by Mayank Khursija on 22/08/22.
//

import Foundation

class BannerCollectionViewCollectionCell: UICollectionViewCell {
    var bannersCollectionView: UICollectionView
    
    var vm: BannerCollectionViewModel?
    
    override init(frame: CGRect) {
        let bannersCollectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        bannersCollectionViewLayout.scrollDirection = .horizontal
        self.bannersCollectionView = UICollectionView(frame: .zero,
                                                      collectionViewLayout: bannersCollectionViewLayout)
        self.bannersCollectionView.translatesAutoresizingMaskIntoConstraints = false
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.contentView.addSubview(self.bannersCollectionView)
        
        self.bannersCollectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.bannersCollectionView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        self.bannersCollectionView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        self.bannersCollectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
        
        self.bannersCollectionView.delegate = self
        self.bannersCollectionView.dataSource = self
        self.bannersCollectionView.showsHorizontalScrollIndicator = false
        self.bannersCollectionView.register(BannerViewCell.self,
                                            forCellWithReuseIdentifier: "bannerCell")
    }
    
    func setupData(vm: BannerCollectionViewModel) {
        self.vm = vm
        self.bannersCollectionView.reloadData()
    }
}

extension BannerCollectionViewCollectionCell: UICollectionViewDelegate,
                                              UICollectionViewDataSource,
                                              UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.vm?.widgets.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell",
                                                      for: indexPath) as? BannerViewCell ?? BannerViewCell(frame: .zero)
        let widget = self.vm?.widgets[indexPath.row]
        if let url = URL(string: widget?.imageUrl ?? "") {
            cell.setupImage(image: .withURL(url))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 348, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.vm?.itemClicked(index: indexPath.row)
    }
}
