//
//  AcademicCompetition.swift
//  tao
//
//  Created by Betto Akkara on 04/04/22.
//

import UIKit

class DailyActivity: UIView {
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var reward: UILabel!
    @IBOutlet weak var rewardType: UIImageView!
    @IBOutlet weak var remainingTime: UILabel!
    @IBOutlet weak var isPaid: UILabel!
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var contentview: UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }

    private func nibSetup() {
        backgroundColor = .clear

        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        addSubview(view)
    }

    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return nibView
    }

    
    func loadView(
        subject : String,
        reward : String,
        rewardType : String,
        isPaid : String,
        bgImg : String,
        bgColor : String
    ){
        
        self.subject.attributedText = subject.convertHtml()
        self.reward.text = reward
        self.rewardType.image = rewardType.lowercased() == "coin " ? #imageLiteral(resourceName: "coin.pdf") : UIImage()
        self.isPaid.text = isPaid
        self.bgImg.sd_setImage(with: URL(string: bgImg))
        self.contentview.backgroundColor = UIColor(hex: bgColor)
    }
    
    
}
