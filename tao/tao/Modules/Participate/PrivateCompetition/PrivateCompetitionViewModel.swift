//
//  PrivateCompetitionViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 08/08/22.
//

import Foundation

class PrivateCompetitionViewModel: BaseViewModel {
    var competitionsData: [CompetitionData]
    init(competitionsData: [CompetitionData]) {
        self.competitionsData = competitionsData
        super.init()
    }
    
    func backActionTapped() {
        self.viewHandler?.popViewController()
    }
}
