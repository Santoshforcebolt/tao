//
//  TrendingView.swift
//  tao
//
//  Created by Betto Akkara on 20/02/22.
//

import UIKit

class TrendingView: UIView {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var desc_lbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imgView: UIView!

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

        containerView = loadViewFromNib()
        containerView.frame = bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.translatesAutoresizingMaskIntoConstraints = true
        imgView.cornerRadius = TaoHelper.constants().trendingView_width/2
        addSubview(containerView)
    }

    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return nibView
    }

    func fillData(index:Int){

    }

}
