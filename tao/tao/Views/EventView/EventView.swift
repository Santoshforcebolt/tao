//
//  EventView.swift
//  tao
//
//  Created by Betto Akkara on 18/02/22.
//

import UIKit

class EventView: UIView {

    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var desc_lbl: UILabel!
    @IBOutlet weak var reward_img: UIImageView!
    @IBOutlet weak var reward_lbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    var viewIndex : Int?

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
        addSubview(containerView)

    }

    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return nibView
    }

    func fillData(index:Int){
        self.viewIndex = index
    }

}
