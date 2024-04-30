//
//  OnBoardingPageView.swift
//  tao
//
//  Created by Betto Akkara on 05/02/22.
//

import UIKit

class OnBoardingPageView: UIView {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var ob_image: UIImageView!
    @IBOutlet weak var ob_heading: UILabel!
    @IBOutlet weak var ob_desc: UILabel!
    @IBOutlet weak var ob_imageHeight: NSLayoutConstraint!
    
    
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
        
        DispatchQueue.main.async {
            self.ob_imageHeight.constant = 0.52 * (UIScreen.main.bounds.height)
        }
        
        addSubview(view)
    }

    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return nibView
    }
   
    func fillData(Index:Int, data : ObViews?){

        self.ob_image.image = UIImage(named: data?.imageName ?? "")
        self.ob_heading.text = data?.heading ?? ""
        self.ob_desc.text = data?.description ?? ""
    
    }

    
}
