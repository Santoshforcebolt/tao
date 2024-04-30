//
//  QuizStartupPageViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 29/05/22.
//

import Foundation

class QuizStartupPageViewModel: BaseViewModel {
    
    let competitionDetails: AcademicCompetitions
    var quizQuestions: QuizQuestions?
    
    init(competitionDetails: AcademicCompetitions) {
        self.competitionDetails = competitionDetails
        super.init()
    }
    
    var bannerImageUrl: URL? {
        if let imageURLString = self.competitionDetails.imageUrl,
           let imageURL = URL(string: imageURLString) {
           return imageURL
        }
        return nil
    }
    
    var bannerBackgroundColor: UIColor {
        return UIColor(hex: self.competitionDetails.background) ?? .white
    }
    
    var titleText: String {
        return self.competitionDetails.name ?? ""
    }
    
    var endDate: Date? {
        if let endTime = self.competitionDetails.endTime {
            let date = DateConverter.convertDateFormat(endTime,
                                                       inputFormat: "yyyy-MM-dd'T'HH:mm:ss")
            return date
        }
        return nil
    }
    
    var totalQuestions: Int {
        return self.quizQuestions?.body?.count ?? 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewHandler?.showLoading()
        self.apiProvider.quizApi.getQuestions(
            competitionId: competitionDetails.id ?? "",
            userID: TaoHelper.userID ?? "") { quizQuestions, error in
                self.viewHandler?.stopLoading()
                if error != nil {
                    self.handleError(error: error)
                } else {
                    self.quizQuestions = quizQuestions
                    self.viewHandler?.reloadView()
                }
            }
    }
    
    func backButtonTapped() {
        self.viewHandler?.popViewController()
    }
    
    func playQuizButtonTapped() {
        if let questions = self.quizQuestions?.body {
            self.viewHandler?.showQuiz(questions: questions, competitionId: self.competitionDetails.id ?? "")
        }
    }
}
