//
//  HomeParentViewController.swift
//  tao
//
//  Created by Betto Akkara on 22/02/22.
//

import UIKit

class HomeParentViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeViewModel = HomeViewModel(switchTab: {_ in
            //
        })
        let homeVC = HomeViewController(homeViewModel)
        homeViewModel.viewHandler = BaseViewHandler(presentingViewController: homeVC)
        self.viewControllers?.append(homeVC)
        self.tabBar.items?[0].image = UIImage(systemName: "house.fill")
        
        let taoLeaderBoardViewModel = LeaderBoardViewModel()
        let taoLeaderBoardvc = LeaderBoardViewController(taoLeaderBoardViewModel)
        taoLeaderBoardViewModel.viewHandler = BaseViewHandler(presentingViewController: taoLeaderBoardvc)
        self.viewControllers?.append(taoLeaderBoardvc)
        self.tabBar.items?[1].image = UIImage(systemName: "star.fill")
        
        let taoTVviewModel = TaoTvViewModel()
        let taoTVvc = TaoTvViewController(taoTVviewModel)
        taoTVviewModel.viewHandler = BaseViewHandler(presentingViewController: taoTVvc)
        self.viewControllers?.append(taoTVvc)
        self.tabBar.items?[2].image = UIImage(systemName: "play.square.fill")
        
        let taoStoreViewModel = TaoStoreViewModel()
        let taoStoreViewController = TaoStoreViewController(taoStoreViewModel)
        taoStoreViewModel.viewHandler = BaseViewHandler(presentingViewController: taoStoreViewController)
        self.viewControllers?.append(taoStoreViewController)
        self.tabBar.items?[3].image = UIImage(systemName: "cart.fill")

        let profileViewModel = ProfileViewModel(switchTab: {_ in
            //
        })
        let profileViewController = ProfileViewController(profileViewModel)
        profileViewModel.viewHandler = BaseViewHandler(presentingViewController: profileViewController)
        self.viewControllers?.append(profileViewController)
        self.tabBar.items?[4].image = UIImage(systemName: "person.fill")
    }

}
