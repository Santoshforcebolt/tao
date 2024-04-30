//
//  QuizResultViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 29/05/22.
//

import Foundation

class QuizResultViewModel: BaseViewModel {
    
    var competitionId: String
    var evaluation: Evaluation?
    
    init(competitionId: String) {
        self.competitionId = competitionId
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewHandler?.showLoading()
        self.apiProvider.quizApi.evaluteQuiz(competitionId: self.competitionId) { evaluation, error in
            self.viewHandler?.stopLoading()
            if error != nil {
                self.handleError(error: error)
            } else {
                self.evaluation = evaluation
                self.viewHandler?.reloadView()
            }
        }
    }
    
    func goToLeaderBoardTapped() {
        self.viewHandler?.showCompetitionLeaderBoard()
    }
    
    func goToHomeTapped() {
        self.viewHandler?.popToViewController(ofClass: ParentViewController.self)
    }
}
