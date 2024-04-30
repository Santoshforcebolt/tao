//
//  DashboardParentViewController.swift
//  tao
//
//  Created by FedCard on 16/02/22.
//

import UIKit

enum DashBoardViews : String{
    case banner
    case category
    case extraCurriculars
    case academicCompetition
    case myCompetitions
    case dailyActivity
    case event
    case trending
    case competition
}

class HomePageViewController: UIViewController, BannerViewTCellDelegate {
    
    @IBOutlet weak var tableview: UITableView!

    var dashBoardViews : [DashBoardViews] = []
    var userProfile = UserProfile()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let userId = (TaoUserDefaults.standard.object(forKey: TaoUserDefaultKeys.userId.rawValue) as? String), userId != ""{
            TaoHelper.userID = userId
        }
        
        DispatchQueue.global(qos: .background).async {
            self.getHomeAPIDtails()
        }

        self.setTableView()

    }

    @IBAction func notify_onclick(_ sender: Any) {
        let viewModel = NotificationViewModel()
        let viewController = NotificationViewController(viewModel)
        let viewHandler = BaseViewHandler(presentingViewController: self)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        viewHandler.pushViewController(viewController: viewController)
    }
    
    @IBAction func search_onclick(_ sender: Any) {
        Logger.i("search")
    }

    fileprivate func setTableView() {
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.bounces = false

        tableview.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        tableview.separatorStyle = .none
        tableview.register(UINib(nibName: "BannerViewTableViewCell", bundle: nil), forCellReuseIdentifier: "BannerViewTableViewCell")
        tableview.register(UINib(nibName: "SpecialComtetitionTableViewCell", bundle: nil), forCellReuseIdentifier: "SpecialComtetitionTableViewCell")

    }
    
    func getHomeAPIDtails(){
        
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                BALoader.show(currentViewController: self)
            }
        }
        
        // getHomePageDetails
        APIDataProvider.init().getHomePageDetails { success_resp in
            
            //MARK: if success_resp is nil that means jwt token authentication failed, in that case logout user
            if success_resp == nil {
                self.logout()
            } else {
                TaoHelper.homeDetails = success_resp
            }
            DispatchQueue.global(qos: .userInitiated).async {
//                DispatchQueue.main.async {
                    
                    APIDataProvider.init().getUserDetails { success in
                        if let userProfile = success {
                            self.userProfile = userProfile
                            TaoHelper.userProfile = userProfile
                        } else {
                            self.logout()
                        }
                        DispatchQueue.global(qos: .userInitiated).async {
                            DispatchQueue.main.async {
                                self.tableview.reloadData()
                                BALoader.dismiss(currentViewController: self)
                            }
                        }
                    } onError: { error in
                        Logger.i(error ?? "getUserDetails: Unknown Error")
                        
                        DispatchQueue.global(qos: .userInitiated).async {
                            DispatchQueue.main.async {
                                self.tableview.reloadData()
                                BALoader.dismiss(currentViewController: self)
                            }
                        }
                    }

                    
                    
                    // getCompetitionCategories
                    APIDataProvider.init().getCompetitionCategories { success_resp in
                        //MARK: if success_resp is nil that means jwt token authentication failed, in that case logout user
                        if success_resp == nil {
                            self.logout()
                        }
                        
                        DispatchQueue.global(qos: .userInitiated).async {
                            DispatchQueue.main.async {
                                var category = success_resp?.cULTURAL
                                category?.append(contentsOf: success_resp?.aCADEMIC ?? [])
                                TaoHelper.competitionCategories = category ?? []
                                
                                self.dashBoardViews.append(.banner)
                                self.dashBoardViews.append(.category)
                                if TaoHelper.homeDetails?.culturalCompetitions?.count != 0 {
                                    self.dashBoardViews.append(.extraCurriculars)
                                }
                                if TaoHelper.homeDetails?.academicCompetitions?.count != 0 {
                                    self.dashBoardViews.append(.academicCompetition)
                                }
                                self.dashBoardViews.append(.myCompetitions)
                                if TaoHelper.homeDetails?.activityList?.count != 0 {
                                    self.dashBoardViews.append(.dailyActivity)
                                }
                                if TaoHelper.homeDetails?.mediaEntryResponseList?.count != 0 {
                                    self.dashBoardViews.append(.trending)
                                }
                            
                                self.dashBoardViews.append(.competition)
                            
                                self.dashBoardViews.forEach { views in
                                    self.tableview.register(CustomHomeTableViewCell.self, forCellReuseIdentifier: views.rawValue)
                                }
                                
                                DispatchQueue.global(qos: .userInitiated).async {
                                    DispatchQueue.main.async {
                                        self.tableview.reloadData()
                                        BALoader.dismiss(currentViewController: self)
                                    }
                                }
                                
                                
                            }
                        }
                    } onError: { error in
                        Logger.i(error ?? "getCompetitionCategories: Unknown Error")
                        
                        DispatchQueue.global(qos: .userInitiated).async {
                            DispatchQueue.main.async {
                                self.tableview.reloadData()
                                BALoader.dismiss(currentViewController: self)
                            }
                        }
                        
                    }
                    
//                }
            }
        } onError: { error in
            Logger.i(error ?? "getHomePageDetails: Unknown Error")
        }
        
        APIDataProvider.init().getAppConfig { success_resp in
            
            //MARK: if success_resp is nil that means jwt token authentication failed, in that case logout user
            if success_resp == nil {
                self.logout()
            }
            
            TaoHelper.configDetails = success_resp
            DispatchQueue.global(qos: .userInitiated).async {
                
            }
            DispatchQueue.global(qos: .userInitiated).async {
                DispatchQueue.main.async {

                }
            }
        } onError: { error in
            Logger.e(error ?? "getAppConfig: Unknown Error")
            DispatchQueue.global(qos: .userInitiated).async {
                DispatchQueue.main.async {

                }
            }

        }

    }
    
    func logout() {
        AppController.shared.clearUserState()
        guard let ob_vc = self.storyboard?.instantiateViewController(withIdentifier: "SplashViewController") as? SplashViewController else {
            return
        }
        self.navigationController?.pushViewController(ob_vc, animated: true)
    }

}

extension HomePageViewController : UITableViewDataSource, UITableViewDelegate{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dashBoardViews.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        let title_lbl = UILabel(frame: CGRect(x: 27, y: 0, width: UIScreen.main.bounds.width, height: 40))
        sectionView.addSubview(title_lbl)
        sectionView.backgroundColor = UIColor.TAO_White
        title_lbl.font = UIFont(name: "Poppins-Medium", size: 18)
        title_lbl.textColor = UIColor.TAO_Black
        title_lbl.text = "Welcome \(self.userProfile.userDetails?.firstName ?? "")!"
        
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        let view = dashBoardViews[indexPath.row]
        switch view {
        case .banner:
            return TaoHelper.constants().bannerView_height
        case .category:
            return TaoHelper.constants().categoryView_height + 60
        case .extraCurriculars:
            return TaoHelper.constants().extraCarricularsView_height
        case .academicCompetition:
            return TaoHelper.constants().extraCarricularsView_height
        case .dailyActivity:
            return TaoHelper.constants().extraCarricularsView_height
        case .event:
            return TaoHelper.constants().eventView_height + 60
        case .trending:
            return TaoHelper.constants().trendingView_height + 60
        case .competition:
            return TaoHelper.constants().specialCompetitionView_height
        case .myCompetitions:
            return UITableView.automaticDimension
        }

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let view = dashBoardViews[indexPath.row]
        switch view {
        case .banner:
            guard let bannerViewTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BannerViewTableViewCell", for: indexPath) as? BannerViewTableViewCell else {
                return UITableViewCell()
            }
            bannerViewTableViewCell.delegate = self
            bannerViewTableViewCell.loadView()
            return bannerViewTableViewCell
        case .category:
            guard let collectionViewTableViewCell = tableView.dequeueReusableCell(withIdentifier: view.rawValue, for: indexPath) as? CustomHomeTableViewCell else {
                return UITableViewCell()
            }
            collectionViewTableViewCell.collection_Type = .category
            collectionViewTableViewCell.title_lbl.text = "Participate by Interest"
            return collectionViewTableViewCell
        case .extraCurriculars:
            guard let collectionViewTableViewCell = tableView.dequeueReusableCell(withIdentifier: view.rawValue, for: indexPath) as? CustomHomeTableViewCell else {
                return UITableViewCell()
            }
            collectionViewTableViewCell.collection_Type = .extraCurriculars
            collectionViewTableViewCell.title_lbl.text = "Browse by Extra-curriculars"
            return collectionViewTableViewCell
        case .academicCompetition:
            guard let collectionViewTableViewCell = tableView.dequeueReusableCell(withIdentifier: view.rawValue, for: indexPath) as? CustomHomeTableViewCell else {
                return UITableViewCell()
            }
            collectionViewTableViewCell.collection_Type = .academicCompetition
            collectionViewTableViewCell.title_lbl.text = "Upskill with Academics"
            return collectionViewTableViewCell
        case .dailyActivity:
            guard let collectionViewTableViewCell = tableView.dequeueReusableCell(withIdentifier: view.rawValue, for: indexPath) as? CustomHomeTableViewCell else {
                return UITableViewCell()
            }
            collectionViewTableViewCell.collection_Type = .dailyActivity
            collectionViewTableViewCell.title_lbl.text = "Daily Activities"
            return collectionViewTableViewCell

           
        case .trending:

            guard let collectionViewTableViewCell = tableView.dequeueReusableCell(withIdentifier: view.rawValue, for: indexPath) as? CustomHomeTableViewCell else {
                return UITableViewCell()
            }
            collectionViewTableViewCell.collection_Type = .trending
            collectionViewTableViewCell.title_lbl.text = "Trending on Tao TV"
            return collectionViewTableViewCell

        case .competition:
            return UITableViewCell()
//            guard let specialComtetitionTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SpecialComtetitionTableViewCell", for: indexPath) as? SpecialComtetitionTableViewCell else {
//                return UITableViewCell()
//            }
//            specialComtetitionTableViewCell.presentingVC = self
//            return specialComtetitionTableViewCell
        case .myCompetitions:
            guard let collectionViewTableViewCell = tableView.dequeueReusableCell(withIdentifier: view.rawValue, for: indexPath) as? CustomHomeTableViewCell else {
                return UITableViewCell()
            }
            collectionViewTableViewCell.collection_Type = .myCompetitions
            collectionViewTableViewCell.title_lbl.text = "My Competitions"
            return collectionViewTableViewCell
        case .event:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let view = self.dashBoardViews[indexPath.row]
        switch view {
        case .banner:
            break
        case .category:
            break
        case .extraCurriculars:
            break
        case .academicCompetition:
            break
        case .myCompetitions:
            let viewModel = MyCompetitionsViewModel()
            let viewController = MyCompetitionsViewController(viewModel)
            let viewHandler = BaseViewHandler(presentingViewController: self)
            viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
            viewHandler.pushViewController(viewController: viewController)
        case .dailyActivity:
            break
        case .event:
            break
        case .trending:
            break
        case .competition:
            break
        }
    }
    
    func didCardSelected(at index: Int) {
        Logger.i(index)
        DispatchQueue.main.async {
            TaoHelper.openExternal(urlString: TaoHelper.homeDetails?.widgets?[index].link ?? "")
        }
    }
    
}

