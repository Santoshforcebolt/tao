//
//  SubmitQuizViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 29/05/22.
//

import Foundation

enum Competition {
    case extraCurricular
    case academic
}
class SubmitActivityViewModel: BaseViewModel {

    var competition: Competition
    var allQuestionsParams: [[String: Any]]?
    var competitionId: String?
    
    init(competition: Competition) {
        self.competition = competition
        super.init()
    }
    
    func submitButtonTapped() {
        switch self.competition {
        case .extraCurricular:
            self.viewHandler?.popToViewController(ofClass: ParentViewController.self)
        case .academic:
            if let competitionId = self.competitionId,
               let allQuestionsParams = self.allQuestionsParams {
                let params: [String: Any] = ["competitionId": competitionId,
                                             "userId": TaoHelper.userID ?? "",
                                             "questionResponse": allQuestionsParams,
                ]
                self.apiProvider.quizApi.submitEntry(params: params) { response, error in
                    if error != nil {
                        self.handleError(error: error)
                    } else {
                        self.viewHandler?.showQuizResult(competitionID: competitionId)
                    }
                }

            }
        }
        
    }
    
}
