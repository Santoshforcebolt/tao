//
//  ViewAllViewController.swift
//  tao
//
//  Created by Betto Akkara on 22/02/22.
//

import UIKit

class ViewAllViewController: UIViewController {
    
    @IBOutlet weak var title_lbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var title_lbl_txt : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "EventCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EventCollectionViewCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
}

extension ViewAllViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCollectionViewCell", for: indexPath) as? EventCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.leading.constant = 0
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Logger.w(indexPath.item)
    }
    
}



extension ViewAllViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = TaoHelper.constants.itemWidth(for: UIScreen.main.bounds.width - 40, spacing: 5)
        let height = width+(width * 0.2)
        
        return (CGSize(width: width, height: height))
        
    }
    
}
