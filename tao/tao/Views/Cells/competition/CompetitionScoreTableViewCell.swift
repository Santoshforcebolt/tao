//
//  CompetitionScoreTableViewCell.swift
//  tao
//
//  Created by Betto Akkara on 14/04/22.
//

import UIKit

class CompetitionScoreTableViewCell: UITableViewCell {

    
    static var identifier = "CompetitionScoreTableViewCell"
    
    
    @IBOutlet weak var title_lb: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    
    
    @IBOutlet weak var str1: UILabel!
    @IBOutlet weak var percent1: UILabel!
    
    @IBOutlet weak var str2: UILabel!
    @IBOutlet weak var percent2: UILabel!
    
    @IBOutlet weak var str3: UILabel!
    @IBOutlet weak var percent3: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(title : String, img1 : String, img2 : String, img3 : String, str1 : String, str2: String, str3 : String, percent1 : String, percent2 : String, percent3 : String){
        
        self.title_lb.text = title
        
        self.img.sd_setImage(with: URL(string: img1))
        self.img2.sd_setImage(with: URL(string: img2))
        self.img3.sd_setImage(with: URL(string: img3))
        
        self.str1.text = str1
        self.str2.text = str2
        self.str3.text = str3
        self.percent1.text = percent1
        self.percent2.text = percent2
        self.percent3.text = percent3
        self.layoutIfNeeded()
    }
    
}
