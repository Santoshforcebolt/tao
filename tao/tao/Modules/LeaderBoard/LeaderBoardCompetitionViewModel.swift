//
//  LeaderBoardCompetitionViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 08/08/22.
//

import Foundation

class LeaderBoardCompetitionViewModel: BaseViewModel {
    var leaderBoards: [LeaderBoard]?
    var rewardType: RewardType = .coin
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewHandler?.showLoading()
        APIDataProvider.init().getCompetitionLeaderboard() { success in
            self.viewHandler?.stopLoading()
            self.leaderBoards = success?.leaderboardData
            self.rewardType = RewardType(rawValue: success?.rewardType ?? "coin") ?? .coin
            self.viewHandler?.reloadView()
        } onError: { error in
            self.viewHandler?.showToast(with: error?.debugDescription)
        }
    }
    
    func backButtonTapped() {
        self.viewHandler?.popViewController()
    }
    
    func itemSelected(index: Int) {
        if let userId = self.leaderBoards?[index].userId {
            self.viewHandler?.showVisitProfile(userId: userId)
        }
    }
}
