//
//  EventCollectionViewCell.swift
//  tao
//
//  Created by Betto Akkara on 20/02/22.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var width: NSLayoutConstraint!
    @IBOutlet weak var leading: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let width = TaoHelper.constants.itemWidth(for: UIScreen.main.bounds.width - 40, spacing: 5)
        let height = width+(width * 0.2)
        
        self.height.constant = height
        self.width.constant = width
        let eventView = EventView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        self.containerView.addSubview(eventView)
    }

}
