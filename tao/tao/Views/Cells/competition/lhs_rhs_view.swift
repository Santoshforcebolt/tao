//
//  lhs_rhs_view.swift
//  tao
//
//  Created by Betto Akkara on 14/04/22.
//

import Foundation
import UIKit

class lhs_rhs_view : UIView{
    
    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var lhs_lbl: UILabel!
    @IBOutlet weak var rhs_lbl: UILabel!
    @IBOutlet weak var rewardIcon: UIImageView!

    
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
        self.containerView = loadViewFromNib()
        self.containerView.frame = bounds
        self.containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.containerView.translatesAutoresizingMaskIntoConstraints = true
        addSubview(self.containerView)
    }

    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return nibView
    }

    func setData(lhs : String, rhs : String, icon : UIImage?){
        self.lhs_lbl.text = lhs
        self.rhs_lbl.text = rhs
        self.rewardIcon.image = icon
    }
    
}

