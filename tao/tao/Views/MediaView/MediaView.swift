//
//  MediaView.swift
//  tao
//
//  Created by Betto Akkara on 05/04/22.
//

import UIKit

class MediaView: UIView {

  
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var image: UIImageView!
    
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

    
    func loadView(img: String, count : String){
        
        if let url = URL(string: img) {
            self.image.sd_setImage(with: url)
        }
        self.count.text = count
        
    }
    
}
