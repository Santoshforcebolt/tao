//
//  TitleTextFieldTableViewCell.swift
//  tao
//
//  Created by Betto Akkara on 10/02/22.
//

import UIKit

class TitleTextFieldTableViewCell: UITableViewCell {

    static var identifier = "TitleTextFieldTableViewCell"

    @IBOutlet weak var title_lbl: UILabel!
    @IBOutlet weak var textField: UITextField!


    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
