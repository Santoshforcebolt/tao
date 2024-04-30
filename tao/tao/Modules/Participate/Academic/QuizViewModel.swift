//
//  QuizViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 29/05/22.
//

import Foundation

class QuizViewModel: BaseViewModel {
    
    var questions: [QuizQuestion]
    var questionNumber = 0
    var competitionId: String
    var allQuestionsParams: [[String: Any]] = []
    init(questions: [QuizQuestion], competitionId: String) {
        self.questions = questions
        self.competitionId = competitionId
        super.init()
    }
    
    func answerSelected(index: Int) {
        self.viewHandler?.showLoading()

        let dateString = DateConverter.convertDateFormat(Date(),
                                                         outputFormat: "yyyy-MM-dd'T'HH:mm:ss")

        let params: [String: Any] = ["competitionId": self.competitionId,
                                     "userId": TaoHelper.userID ?? "",
                                     "questionResponse": [["answerSubmissionTime": dateString ?? "",
                                                           "questionId": self.currentQuestion.id ?? "",
                                                           "timeTaken": Float(10.0),
                                                           "userAnswerId": self.currentQuestion.mcqOptions?[index].identifier ?? ""]],
        ]
        self.allQuestionsParams.append(["answerSubmissionTime": dateString ?? "",
                                        "questionId": self.currentQuestion.id ?? "",
                                        "timeTaken": Float(10.0),
                                        "userAnswerId": self.currentQuestion.mcqOptions?[index].identifier ?? ""])
        self.apiProvider.quizApi.submitAnswer(params: params) { response, error in
            self.viewHandler?.stopLoading()
            if error != nil {
                self.handleError(error: error)
            } else {
                if self.questionNumber == self.questions.count - 1 {
                    self.viewHandler?.showSubmitQuiz(competitionId: self.competitionId,
                                                     allQuestionsParams: self.allQuestionsParams)
                } else {
                    self.questionNumber += 1
                    self.viewHandler?.reloadView()
                }
            }
        }
        
    }
    
    var currentQuestion: QuizQuestion {
        return questions[self.questionNumber]
    }
    
    func timeLimitExceeded() {
        if self.questionNumber == self.questions.count - 1 {
            self.viewHandler?.showSubmitQuiz(competitionId: self.competitionId,
                                             allQuestionsParams: self.allQuestionsParams)
        } else {
            self.questionNumber += 1
            self.viewHandler?.reloadView()
        }
    }
}
