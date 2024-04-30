//
//  BannerViewTableViewCell.swift
//  tao
//
//  Created by FedCard on 16/02/22.
//

import UIKit

protocol BannerViewTCellDelegate : class{
    func didCardSelected(at index : Int)
}

class BannerViewTableViewCell: UITableViewCell,iCarouselDataSource,iCarouselDelegate , BannerViewDelegate {
    
    public static let identifier : String = "BannerViewTableViewCell"
    
    @IBOutlet weak var displayView: iCarousel!
    var presenter : UIViewController!
//    var cardDetails = [""]
    
    var viewArray : [UIView] = [UIView]()
    
    weak var delegate : BannerViewTCellDelegate?
    
    func loadView(){
        TaoHelper.delay(0.1, block: { () -> (Void) in
            DispatchQueue.global(qos: .userInitiated).async {
                self.icarosak()
            }
        })
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        displayView.dataSource = self
        displayView.delegate = self
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let viewc = UIView(frame: CGRect(x: 0, y: 0, width: viewArray[index].bounds.width, height: viewArray[index].bounds.height))
        viewc.addSubview(viewArray[index])
        viewc.contentMode = .scaleAspectFit
        return viewc
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return viewArray.count
    }
    
    func bannerView(Index:Int) -> UIView {
        
        let CView = UIView(frame: CGRect(x: 0, y: 0, width:UIScreen.main.bounds.width - 40, height: displayView.bounds.height))
        let view = BannerView(frame: CGRect(x: 10, y: 1, width:CView.bounds.width - 20, height: CView.bounds.height - 2))
        view.cardViewDelegate = self
        view.fillData(index: Index)
        CView.addSubview(view)
        return CView
        
    }
    
    func icarosak(){
        DispatchQueue.main.async {
            self.viewArray.removeAll()
            
            self.displayView.clearsContextBeforeDrawing = true
            self.displayView.reloadData()
            
            for i in 0..<(TaoHelper.homeDetails?.widgets?.count ?? 0){
                let v : UIView = self.bannerView(Index: i)
                self.viewArray.insert(v, at: i)
            }
            
            self.displayView.type = iCarouselType.linear
            self.displayView.contentMode = .scaleAspectFit
            self.displayView.isPagingEnabled = true
            self.displayView.clearsContextBeforeDrawing = true
            self.displayView.currentItemView?.alpha = 1
            self.displayView.reloadData()
            
        }
        
    }
}
extension BannerViewTableViewCell : CategoryViewDelegate {

    func viewcardDetails(_ viewIndex: Int) {
        self.delegate?.didCardSelected(at: viewIndex)
    }

    func managecard(_ viewindex: Int) {
        
    }
    
}

