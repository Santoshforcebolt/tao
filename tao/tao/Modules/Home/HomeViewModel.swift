//
//  HomeViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 20/08/22.
//

import Foundation

class HomeViewModel: BaseViewModel {
    var homeDetails : HomeDetails?
    var userProfile: UserProfile?
    var competitionCategories: [CategoryDetails]?
    var banners: Banners?
    var games: Games?
    var switchTab: (Int)-> Void
    
    init(switchTab: @escaping (Int)-> Void) {
        self.switchTab = switchTab
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewHandler?.showLoading()
        self.apiProvider.homeApi.getUserProfile { userProfile, error in
            self.viewHandler?.stopLoading()
            
            if error != nil {
                self.handleError(error: error)
            } else {
                TaoHelper.userProfile = userProfile
                self.userProfile = userProfile
                
                self.viewHandler?.showLoading()
                self.apiProvider.homeApi.getHomeDetails { homeDetails, error in
                    self.viewHandler?.stopLoading()
                    if error != nil {
                        self.handleError(error: error)
                    } else {
                        self.homeDetails = homeDetails
                        self.viewHandler?.reloadView()
                        self.viewHandler?.showLoading()
                        self.apiProvider.homeApi.getCompetitionCategories { competitionCategories, error in
                            self.viewHandler?.stopLoading()
                            if error != nil {
                                self.handleError(error: error)
                            } else {
                                var categories = competitionCategories?.cULTURAL
                                categories?.append(contentsOf: competitionCategories?.aCADEMIC ?? [])
                                self.competitionCategories = categories
                                self.viewHandler?.reloadView()
                                self.viewHandler?.showLoading()
                                self.apiProvider.homeApi.getAppConfig { appConfig, error in
                                    self.viewHandler?.stopLoading()
                                    if error != nil {
                                        self.handleError(error: error)
                                    } else {
                                        TaoHelper.configDetails = appConfig
                                        self.apiProvider.homeApi.getWidgets { banners, error in
                                            if error != nil {
                                                self.handleError(error: error)
                                            } else {
                                                self.banners = banners
                                                self.viewHandler?.reloadView()
                                                self.apiProvider.homeApi.getGames { games, error in
                                                    if error != nil {
                                                        self.handleError(error: error)
                                                    } else {
                                                        self.games = games
                                                        self.viewHandler?.reloadView()
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    func getCategory(index: Int) -> CategoryDetails? {
        return self.competitionCategories?[index]
    }
    
    func getWidget(index: Int) -> Widgets? {
        return self.homeDetails?.widgets?[index]
    }
    
    func walletTapped() {
        self.viewHandler?.showWallet(switchTab: { index in
            self.viewHandler?.popViewController()
            self.switchTab(index)
        })
    }
    
    func notificationTapped() {
        self.viewHandler?.showNotifications()
    }
    
    func academicsViewAllTapped() {
        if let activities = self.homeDetails?.academicCompetitions {
            self.viewHandler?.showAllAcademics(activities: activities)
        }
    }
    
    func culturalViewAllTapped() {
        if let activities = self.homeDetails?.culturalCompetitions {
            self.viewHandler?.showAllActivities(activities: activities)
        }
    }
    
    func dailyActivityViewAllTapped() {
        if let activities = self.homeDetails?.activityList {
            self.viewHandler?.showAllActivities(activities: activities)
        }
    }
    
    func trendingViewAllTapped() {
        self.switchTab(Tabs.taoTV.rawValue)
    }
}
