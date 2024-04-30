//
//  CompetitionCollectionViewCellNew.swift
//  tao
//
//  Created by Saurabh Pathak on 26/10/22.
//

import UIKit

class CompetitionCollectionViewCellNew: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var secondaryLabel: UILabel!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var timeRemainingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupData(compImage: Image,name:String, nudgeType: NudgeView.ViewType, daysRemaining: TextType) {
        //self.nudgeView.updateType(type: nudgeType)
        self.mainLabel.text = name
        switch compImage {
        case .withURL(let uRL):
            self.iconImageView.sd_setImage(with: uRL)
        case .withImage(let uIImage):
            self.iconImageView.image = uIImage
        }
//        if let sponsorImage = sponsorImage {
//            self.sponsorImageView.sd_setImage(with: URL(string: sponsorImage))
//        }
        switch daysRemaining {
        case .plain(let string):
            break
//            self.timeRemainingLabel.setupData(image: .withImage(UIImage(systemName: "clock")!), text: "\(string) days remaining")
        case .clock(let date):
            break
//            self.endDate = date
//            self.runCountdown()
        }
    }
}
