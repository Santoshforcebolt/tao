//
//  SetAvatarViewController.swift
//  tao
//
//  Created by Betto Akkara on 15/02/22.
//

import UIKit

class SetAvatarViewController: UIViewController {

    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var skip: UIButton!
    
    @IBOutlet weak var selectedAvatar: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  

}

extension SetAvatarViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AvatarCollectionViewCell", for: indexPath) as? AvatarCollectionViewCell
        if indexPath.item != 1{
            cell?.isAvatarSelected = false
        }else{
            cell?.isAvatarSelected = true
        }
        return cell!
    }
    
    
}
