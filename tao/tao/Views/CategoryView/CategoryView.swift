//
//  CardView.swift
//  creditcardapp
//
//  Created by Betto Akkara on 30/08/21.
//

import UIKit

protocol CategoryViewDelegate : AnyObject {
    func viewcardDetails(_ viewIndex : Int)
    func managecard(_ viewindex : Int)
}

@IBDesignable
class CategoryView: UIView {
    
    var index :Int?

    weak var cardViewDelegate : CategoryViewDelegate?
    
    @IBOutlet weak var image_view: UIImageView!
    
    @IBOutlet weak var title_lbl: UILabel!
    
    
    ///base View
    @IBOutlet weak var view: UIView!
    
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

    func fillData(index:Int, image_url: String? , title : String?, bg: String?){
        
        self.viewIndex = index
        print(index)
        self.image_view.sd_setImage(with: URL(string: image_url ?? ""))
        self.title_lbl.text = title
        self.view.backgroundColor = UIColor(hex: bg ?? "#FFFFFF")
        self.view.layer.cornerRadius = 5
    }

}
