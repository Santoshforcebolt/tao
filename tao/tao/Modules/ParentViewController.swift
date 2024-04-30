//
//  ParentViewController.swift
//  tao
//
//  Created by Mayank Khursija on 22/08/22.
//

import Foundation

enum Tabs: Int {
    case home = 0
    case leaderboard
    case taoTV
    case store
    case profile
}

class ParentViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
        self.delegate = self
        
        self.view.backgroundColor = .white
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
        
        let homeViewModel = HomeViewModel(switchTab: { index in
            DispatchQueue.main.async {
                self.selectedIndex = index
            }
        })
        let homeVC = HomeViewController(homeViewModel)
        homeViewModel.viewHandler = BaseViewHandler(presentingViewController: homeVC)
        self.viewControllers?.append(homeVC)
        homeVC.tabBarItem = UITabBarItem(title: "Home",
                                         image: UIImage(systemName: "house"),
                                         selectedImage: UIImage(systemName: "house.fill"))
        
        let taoLeaderBoardViewModel = LeaderBoardViewModel()
        let taoLeaderBoardvc = LeaderBoardViewController(taoLeaderBoardViewModel)
        taoLeaderBoardViewModel.viewHandler = BaseViewHandler(presentingViewController: taoLeaderBoardvc)
        self.viewControllers?.append(taoLeaderBoardvc)
        taoLeaderBoardvc.tabBarItem = UITabBarItem(title: "Leaderboard",
                                                   image: UIImage(systemName: "star"),
                                                   selectedImage: UIImage(systemName: "star.fill"))
        
        let taoTVviewModel = TaoTvViewModel()
        let taoTVvc = TaoTvViewController(taoTVviewModel)
        taoTVviewModel.viewHandler = BaseViewHandler(presentingViewController: taoTVvc)
        self.viewControllers?.append(taoTVvc)
        taoTVvc.tabBarItem = UITabBarItem(title: "Tao TV",
                                          image: UIImage(systemName: "play.square"),
                                          selectedImage: UIImage(systemName: "play.square.fill"))
        
        let taoStoreViewModel = TaoStoreViewModel()
        let taoStoreViewController = TaoStoreViewController(taoStoreViewModel)
        taoStoreViewModel.viewHandler = BaseViewHandler(presentingViewController: taoStoreViewController)
        self.viewControllers?.append(taoStoreViewController)
        taoStoreViewController.tabBarItem = UITabBarItem(title: "Tao Store",
                                                         image: UIImage(systemName: "cart"),
                                                         selectedImage: UIImage(systemName: "cart.fill"))

        let profileViewModel = ProfileViewModel(switchTab: { index in
            self.selectedIndex = index
        })
        let profileViewController = ProfileViewController(profileViewModel)
        profileViewModel.viewHandler = BaseViewHandler(presentingViewController: profileViewController)
        self.viewControllers?.append(profileViewController)
        profileViewController.tabBarItem = UITabBarItem(title: "Profile",
                                                        image: UIImage(systemName: "person"),
                                                        selectedImage: UIImage(systemName: "person.fill"))
        
        self.viewControllers = [homeVC, taoLeaderBoardvc, taoTVvc, taoStoreViewController, profileViewController]
    }

    func initialSetup() {
        if let userId = (TaoUserDefaults.standard.object(forKey: TaoUserDefaultKeys.userId.rawValue) as? String), userId != ""{
            TaoHelper.userID = userId
        }
    }
}
