//
//  RulesTableViewCell.swift
//  tao
//
//  Created by Betto Akkara on 14/04/22.
//

import UIKit

class RulesTableViewCell: UITableViewCell {

    static var identifier = "RulesTableViewCell"
    
    @IBOutlet weak var title_lbl: UILabel!
    @IBOutlet weak var content_lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(title : String, content : String){
        
        self.title_lbl.text = title
        self.content_lbl.attributedText = content.convertHtml()
        
    }
    
}
