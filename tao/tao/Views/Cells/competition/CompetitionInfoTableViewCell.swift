//
//  CompetitionInfoTableViewCell.swift
//  tao
//
//  Created by Betto Akkara on 14/04/22.
//

import UIKit

class CompetitionInfoTableViewCell: UITableViewCell {

    static var identifier = "CompetitionInfoTableViewCell"
    
    @IBOutlet weak var title_lbl: UILabel!
    @IBOutlet weak var info_lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(title : String, info : String){
        self.title_lbl.text = title
        self.info_lbl.attributedText = info.convertHtml()
    }
    
}
