//
//  OnboardingParent.swift
//  tao
//
//  Created by Betto Akkara on 05/02/22.
//

import Foundation
import UIKit
import CHIPageControl

struct ObViews {
    var imageName : String?
    var heading : String?
    var description: String?
}

class OnboardingParent: UIViewController {
    
    @IBOutlet weak var pageViewer: iCarousel!
    
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var nextBtn_width: NSLayoutConstraint!
    @IBOutlet weak var pageControl: CHIPageControlJalapeno!


    //declaring variables
    var carouselTimer : Timer!
    var counter = 0
    //

    var pages : [ObViews] = []
    var viewArray : [UIView] = [UIView]()
    var isGetStartEnabled : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        pageViewer.delegate = self
        pageViewer.dataSource = self
        pageControl.delegate = self
        self.loadPageView()
        self.setPageConrol()
        carouselTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(selectIteminCarousel), userInfo: nil, repeats: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.setupPage()
        }
    }
    
    private func setupPage() {
        self.pages.append(ObViews(imageName: "ob_competition", heading: "Pick a competition", description: "Rrgister with us and pick a competition accross academic and extra carricular domains"))
        self.pages.append(ObViews(imageName: "ob_participate", heading: "Participate", description: "Participate in quizzes by giving multiple choice quizzes or upload your entries for extracurriculars"))
        self.pages.append(ObViews(imageName: "ob_compete", heading: "Compete", description: "Compete with participants and get critiqued by experts around the world"))
        self.pages.append(ObViews(imageName: "ob_win_rewards", heading: "Win Rewards", description: "Become a part of our leaderboard and win eciting prizes, including cash rewards, gift vouvhers and much more"))
        
    }

    @IBAction func getStart(_ sender: Any) {
        if isGetStartEnabled {
            TaoHelper.delay(0.4) {
                guard let ob_vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
                    return
                }
                self.navigationController?.pushViewController(ob_vc, animated: true)
            }
        }
    }

}

extension OnboardingParent : iCarouselDataSource,iCarouselDelegate{
    // MARK:- FSPagerViewDataSource
    func loadPageView(){
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.icarosak()
        }
        
    }
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let viewc = UIView(frame: CGRect(x: 0, y: 0, width: viewArray[index].bounds.width, height: viewArray[index].bounds.height))
        //        viewc.layer.backgroundColor = UIColor.brownColor().CGColor
        viewc.addSubview(viewArray[index])
        viewc.contentMode = .scaleAspectFit
        return viewc
    }

    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        DispatchQueue.main.async {
            
            self.previousBtn.isHidden = carousel.currentItemIndex == 0 ? true : false
            if (carousel.currentItemIndex == (self.pages.count-1)) {
                self.nextBtn.layer.cornerRadius = self.nextBtn.layer.bounds.height/2
                self.nextBtn_width.constant = 125
                self.nextBtn.setImage(UIImage(), for: .normal)

                UIView.animate(withDuration: 0.3,
                               animations: {
                    self.nextBtn.contentHorizontalAlignment = .right
                    self.nextBtn.setTitleColor(.TAO_White, for: .normal)
                    self.nextBtn.backgroundColor = .TAO_Link
                    self.nextBtn.layoutIfNeeded()
                    self.nextBtn.setTitle("  Get Started  ", for: .normal)
                    self.isGetStartEnabled = true
                },
                               completion: nil
                )
                
            }else{
                self.nextBtn.layer.cornerRadius = 0
                self.nextBtn_width.constant = 40
                self.nextBtn.backgroundColor = .clear
                self.nextBtn.setImage(UIImage(systemName: "chevron.right") ?? UIImage(), for: .normal)
                UIView.animate(withDuration: 0.1,
                               animations: {
                    
                    self.nextBtn.layoutIfNeeded()
                    self.nextBtn.setTitle("", for: .normal)
                    self.isGetStartEnabled = false
                    
                },
                               completion: nil
                )
                
            }
            self.pageControl.set(progress: carousel.currentItemIndex, animated: true)
            
        }
    }

    func numberOfItems(in carousel: iCarousel) -> Int {
        return viewArray.count
    }
    
    func cardview(Index:Int) -> UIView {
        
        let CView = UIView(frame: CGRect(x: 0, y: 0, width:UIScreen.main.bounds.width - 20  , height: UIScreen.main.bounds.height))
        
        let view = OnBoardingPageView(frame: CGRect(x: 1, y: 1, width:CView.bounds.width - 2, height: CView.bounds.height - 2))

        view.fillData(Index: Index, data: pages[Index])
        CView.addSubview(view)
        
        return CView
        
    }
    
    func icarosak(){
        DispatchQueue.main.async {
            self.viewArray.removeAll()
            
            self.pageViewer.clearsContextBeforeDrawing = true
            self.pageViewer.reloadData()
            
            for i in 0..<(self.pages.count) {
                let v : UIView = self.cardview(Index: i)
                self.viewArray.insert(v, at: i)
            }

            self.pageViewer.type = iCarouselType.linear
            self.pageViewer.bounces = false
            self.pageViewer.contentMode = .scaleAspectFit
            self.pageViewer.isPagingEnabled = true
            self.pageViewer.clearsContextBeforeDrawing = true
            self.pageViewer.currentItemView?.alpha = 1
            self.pageViewer.reloadData()
            self.selectIteminCarousel()
        }
        
    }
    @objc func selectIteminCarousel()
    {
        pageViewer.scrollToItem(at: counter, animated: true)
        counter += 1
        if counter > (self.pages.count) - 1
        {
            carouselTimer.invalidate()
        }
    }
}

extension OnboardingParent : CHIBasePageControlDelegate{
    
    func setPageConrol(){

        pageControl.numberOfPages = 4
        pageControl.radius = 4
        pageControl.tintColor = .TAO_Link
        pageControl.currentPageTintColor = .TAO_TBlue
        pageControl.padding = 6
        pageControl.progress = 0.5

    }
    func didTouch(pager: CHIBasePageControl, index: Int) {
        print(index)
    }
}
