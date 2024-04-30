//
//  ExtraCurriculars.swift
//  tao
//
//  Created by Betto Akkara on 03/04/22.
//

import UIKit

class ExtraCurriculars: UIView {

    @IBOutlet weak var isPaid: UILabel!
    
     @IBOutlet weak var days: UILabel!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var rewardIcon: UIImageView!
    
    @IBOutlet weak var reward: UILabel!
    
    @IBOutlet weak var isPaid_view: UIView!
    
    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var contentview: UIView!
    
    @IBOutlet weak var description_lbl: UILabel!
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

    
    func loadView(ispaid: String, days: String, img: String, reward : String, rewardType: String, bg: String,description : String){
        
        self.description_lbl.attributedText = description.convertHtml()
        self.description_lbl.textAlignment = .center
        self.description_lbl.textColor = (bg.lowercased() == "#ffffff" ? UIColor(hex: "#000000") : UIColor(hex: "#FFFFFF"))
        
        //MARK: Description Label not required for Now as Image has Description itself
        self.description_lbl.isHidden = true
        self.description_lbl.removeFromSuperview()
        
        self.image.sd_setImage(with: URL(string: img))
        self.isPaid.text = ispaid
        self.days.text = days
        self.reward.text = reward
        self.contentview.backgroundColor = UIColor(hex: bg)
        self.rewardIcon.image = rewardType.lowercased() == "coin" ? #imageLiteral(resourceName: "coin.pdf") : UIImage()
        
    }
    
}
