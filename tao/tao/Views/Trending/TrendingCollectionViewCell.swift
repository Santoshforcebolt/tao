//
//  TrendingCollectionViewCell.swift
//  tao
//
//  Created by Betto Akkara on 21/02/22.
//

import UIKit

class TrendingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var width: NSLayoutConstraint!
    @IBOutlet weak var leading: NSLayoutConstraint!


    override func awakeFromNib() {
        super.awakeFromNib()
        self.height.constant = TaoHelper.constants().trendingView_height
        self.width.constant = TaoHelper.constants().trendingView_width
        let trentingview = TrendingView(frame: CGRect(x: 0, y: 0, width: TaoHelper.constants().trendingView_width, height: TaoHelper.constants().trendingView_height))
        self.containerView.addSubview(trentingview)

    }

}
