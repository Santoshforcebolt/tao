//
//  LeaderBoardDetailViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 02/07/22.
//

import Foundation

class LeaderBoardDetailViewModel: BaseViewModel {
    
    let leaderBoard: LeaderBoard
    let type: RewardType
    
    init(leaderBoard: LeaderBoard, type: RewardType) {
        self.leaderBoard = leaderBoard
        self.type = type
        super.init()
    }
    
    func visitProfileTapped() {
        self.viewHandler?.showVisitProfile(userId: leaderBoard.userId ?? "")
    }
}
