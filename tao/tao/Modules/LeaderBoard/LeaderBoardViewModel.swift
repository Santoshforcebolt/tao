//
//  LeaderBoardViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 01/07/22.
//

import Foundation

enum RewardType: String {
    case cash = "CASH"
    case coin = "COIN"
}

class LeaderBoardViewModel: BaseViewModel {
    
    var subCategories: [String]?
    var leaderBoards: [LeaderBoard]?
    var pastLeaderBoards: [LeaderBoard]?
    var userBoard: LeaderBoard?
    var time: Time = .month
    var rewardType: RewardType = .cash
    
    var selectedCategory: String?
    var selectedAllTimeCategory: String?
    var selectedMonth: String = "Select Month"
    
    var selectedCategoryIndex: Int = 0
    var selectedAllTimeCategoryIndex: Int = 0
    
    enum Time {
        case month
        case all
    }

    var dates: [String]
    
    init() {
        var datesString = DateManager.shared.getDateBetween(from: "01/01/2020",
                                                            to: DateManager.shared.getTodayDateString())
        datesString.insert("Select Month", at: 0)
        self.dates = datesString
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewHandler?.showLoading()
        self.apiProvider.leaderBoardApi.getSubCategories(for: "month") { categories, error in
            self.viewHandler?.stopLoading()
            if error != nil {
                self.handleError(error: error)
            } else {
                self.subCategories = categories
                self.viewHandler?.showLoading()
                self.apiProvider.leaderBoardApi.getLeaderBoardData(type: "month",
                                                                   month: DateManager.shared.getCurrentMonth(),
                                                                   year: DateManager.shared.getCurrentYear(),
                                                                   subcategory: categories?[0] ?? "") { leaderBoardData, error in
                    self.viewHandler?.stopLoading()
                    if error != nil {
                        self.handleError(error: error)
                    } else {
                        self.leaderBoards = leaderBoardData?.leaderboard
                        self.userBoard = leaderBoardData?.userLeaderboardResponse
                        self.rewardType = RewardType(rawValue: leaderBoardData?.rewardType ?? "") ?? .coin
                        self.selectedCategory = categories?[0] ?? ""
                        self.selectedAllTimeCategory = categories?[0] ?? ""
                        self.viewHandler?.reloadView()
                    }
                }
            }
        }
    }
    
    func loadMonthlyData(for category: String) {
        self.viewHandler?.showLoading()
        self.apiProvider.leaderBoardApi.getLeaderBoardData(type: "month",
                                                           month: DateManager.shared.getCurrentMonth() - 1,
                                                           year: DateManager.shared.getCurrentYear(),
                                                           subcategory: category) { leaderBoardData, error in
            self.viewHandler?.stopLoading()
            if error != nil {
                self.handleError(error: error)
            } else {
                self.leaderBoards = leaderBoardData?.leaderboard
                self.rewardType = RewardType(rawValue: leaderBoardData?.rewardType ?? "") ?? .cash
                self.viewHandler?.reloadView()
            }
        }
    }
    
    func loadYearlyData(for category: String) {
        let (month, year) = DateManager.shared.getMonthAndYearInt(from: self.selectedMonth)
        self.viewHandler?.showLoading()
        self.apiProvider.leaderBoardApi.getLeaderBoardData(type: "month",
                                                           month: month,
                                                           year: year,
                                                           subcategory: category) { leaderBoardData, error in
            self.viewHandler?.stopLoading()
            if error != nil {
                self.handleError(error: error)
            } else {
                self.pastLeaderBoards = leaderBoardData?.leaderboard
                self.rewardType = RewardType(rawValue: leaderBoardData?.rewardType ?? "") ?? .cash
                self.viewHandler?.reloadView()
            }
        }
    }
    
    func itemTapped(at index: Int) {
        switch self.time {
        case .month:
            if let leaderBoard = self.leaderBoards?[index] {
                self.viewHandler?.showLeaderBoardDetail(leaderBoard: leaderBoard, type: self.rewardType)
            }
        case .all:
            if let leaderBoard = self.pastLeaderBoards?[index] {
                self.viewHandler?.showLeaderBoardDetail(leaderBoard: leaderBoard, type: self.rewardType)
            }
        }
    }
    
}
