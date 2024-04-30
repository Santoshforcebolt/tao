//
//  ActivityViewsTableViewCell.swift
//  tao
//
//  Created by Betto Akkara on 15/04/22.
//

import UIKit

class ActivityViewsTableViewCell: UITableViewCell {

    static var identifier = "ActivityViewsTableViewCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

}



extension ActivityViewsTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return 10
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as? CategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.loadViews(cellIndex: indexPath.item, cellType: .trending)
            cell.leading.constant = 10
            return cell

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Logger.w(indexPath.item)
    }

}

extension ActivityViewsTableViewCell: UICollectionViewDelegateFlowLayout {
    private struct LayoutConstant {
        static let spacing: CGFloat = 0
        static func itemWidth() -> CGFloat{
            return (TaoHelper.constants().trendingView_width) + 30
        }
        static func itemHeight() -> CGFloat{
            return (TaoHelper.constants().trendingView_height)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        let width = itemWidth(for: contentView.frame.width, spacing: 3)
        return  indexPath.item == 0 ? (CGSize(width: LayoutConstant.itemWidth(), height: LayoutConstant.itemHeight())) : (CGSize(width: LayoutConstant.itemWidth() - 20, height: LayoutConstant.itemHeight()))
    }
}
