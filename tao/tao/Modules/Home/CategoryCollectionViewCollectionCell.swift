//
//  CategoryCollectionViewCollectionCell.swift
//  tao
//
//  Created by Mayank Khursija on 22/08/22.
//

import Foundation

class CategoryCollectionViewCollectionCell: UICollectionViewCell {
    var categoryCollectionView: UICollectionView
    
    var vm: CategoryCollectionViewModel?
    
    override init(frame: CGRect) {
        let categoryCollectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        categoryCollectionViewLayout.scrollDirection = .horizontal
        self.categoryCollectionView = UICollectionView(frame: .zero,
                                                      collectionViewLayout: categoryCollectionViewLayout)
        self.categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.contentView.addSubview(self.categoryCollectionView)
        
        self.categoryCollectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.categoryCollectionView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        self.categoryCollectionView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        self.categoryCollectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
        
        self.categoryCollectionView.delegate = self
        self.categoryCollectionView.dataSource = self
        self.categoryCollectionView.showsHorizontalScrollIndicator = false
        self.categoryCollectionView.register(TaoStoreCategoryViewCell.self,
                                            forCellWithReuseIdentifier: "categoryCell")
    }
    
    func setupData(vm: CategoryCollectionViewModel) {
        self.vm = vm
        self.categoryCollectionView.reloadData()
    }
}

extension CategoryCollectionViewCollectionCell: UICollectionViewDelegate,
                                              UICollectionViewDataSource,
                                              UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.vm?.categories.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as? TaoStoreCategoryViewCell ?? TaoStoreCategoryViewCell()
        if let category = self.vm?.categories[indexPath.row],
           let urlString = category.imageUrl?.replacingOccurrences(of: "\n", with: ""),
           let url = URL(string: urlString) {
            let instructionViewModel = InstructionViewModel(text: .plain(category.description ?? ""), image: .withURL(url))
            cell.setupCell(viewModel: instructionViewModel)
            cell.backgroundColor = UIColor(hex: category.backgroundColor ?? "#000000")
            cell.layer.cornerRadius = 16
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.vm?.didSelectItem(at: indexPath.row)
    }
}
