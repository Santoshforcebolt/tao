//
//  AvatarCollectionViewCell.swift
//  tao
//
//  Created by Betto Akkara on 15/02/22.
//

import UIKit

class AvatarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var avatar_img: UIImageView!
    @IBOutlet weak var selected_img: UIImageView!
    
    var isAvatarSelected : Bool = false{
        didSet{
            selected_img.isHidden = !isAvatarSelected
        }
    }
    
}
