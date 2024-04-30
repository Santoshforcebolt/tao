//
//  BannerView.swift
//  creditcardapp
//
//  Created by Betto Akkara on 30/08/21.
//

import UIKit
import SDWebImage


protocol BannerViewDelegate : AnyObject {
    func viewcardDetails(_ viewIndex : Int)
    func managecard(_ viewindex : Int)
}

@IBDesignable
class BannerView: UIView {
    
    var index :Int?
    // var presenter = UIViewController()

    weak var cardViewDelegate : CategoryViewDelegate?
    
    ///base View
    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var imageView: UIImageView!

    var viewIndex : Int?

    @IBAction func btn_details(_sender:AnyObject){
        self.cardViewDelegate?.viewcardDetails(self.viewIndex ?? 0)
    }

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

    func fillData(index:Int){

        self.viewIndex = index
        
        print(TaoHelper.homeDetails?.widgets![index].imageUrl)
        
        self.imageView.sd_setImage(with: URL(string: TaoHelper.homeDetails?.widgets?[index].imageUrl ?? ""))
        self.imageView.contentMode = .scaleToFill
        self.layoutSubviews()
        
    }

}
