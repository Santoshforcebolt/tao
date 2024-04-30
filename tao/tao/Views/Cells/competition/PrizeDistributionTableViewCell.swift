//
//  PriceDistributionTableViewCell.swift
//  tao
//
//  Created by Betto Akkara on 14/04/22.
//

import UIKit

class PrizeDistributionTableViewCell: UITableViewCell {

    static var identifier = "PrizeDistributionTableViewCell"
    
    @IBOutlet weak var img_icon: UIImageView!
    @IBOutlet weak var sectionTitle: UILabel!
    
    @IBOutlet weak var tbl_lhs_lbl: UILabel!
    @IBOutlet weak var tbl_rhs_lbl: UILabel!
    
    @IBOutlet weak var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(icon : UIImage,
                 title : String,
                 competionRewards: [CompetitionReward],
                 rewardType: RewardType) {
        
        self.img_icon.image = icon
        self.tbl_lhs_lbl.text = "Rank"
        self.tbl_rhs_lbl.text = "Rewards"
        self.sectionTitle.text = title
        
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.spacing   = 16.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        for competionReward in competionRewards {
            let view = lhs_rhs_view(frame: CGRect(x: 0, y: 0, width: self.stackView.bounds.width, height: 28))
            let lhsText = competionReward.startRank ?? 0 == competionReward.endRank ?? 0 ?
            "\(competionReward.startRank ?? 0)" :
            "\(competionReward.startRank ?? 0)-\(competionReward.endRank ?? 0)"
            
            view.setData(lhs: lhsText,
                         rhs: rewardType == .coin ?
                         "\(competionReward.winnings ?? 0)":
                            "₹\(competionReward.winnings ?? 0)",
                         icon: rewardType == .coin ? #imageLiteral(resourceName: "coin.pdf") : nil)
            
            stackView.addArrangedSubview(view)
        }

    }
    
}
