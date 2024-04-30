//
//  ActionBannerTableViewCell.swift
//  tao
//
//  Created by Betto Akkara on 14/04/22.
//

import UIKit

class ActionBannerTableViewCell: UITableViewCell {

    static var identifier = "ActionBannerTableViewCell"
    
    var videoUrl : String?
    @IBOutlet weak var image_view: UIImageView!
    @IBOutlet weak var info_lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData (data : Guide, info : String){
        
        self.videoUrl = data.resource ?? ""
        self.image_view.sd_setImage(with: NSURL(string: data.image ?? "") as! URL, placeholderImage: UIImage(named: "learnBanner"))
        self.info_lbl.text = info
        self.contentView.layer.cornerRadius = 5
        
    }
}
