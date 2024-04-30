//
//  CategoryCompetitionViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 06/09/22.
//

import Foundation

class CategoryCompetitionViewModel: BaseViewModel {
    var competitions: [ActivityList]?
    var category: String
    var subCategory: String
    
    init(category: String, subCategory: String) {
        self.category = category
        self.subCategory = subCategory
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewHandler?.showLoading()
        self.apiProvider.homeApi.getCompetitionsByCategories(category: self.category, subcategory: self.subCategory) { categoryComps, error in
            self.viewHandler?.stopLoading()
            if error != nil {
                self.handleError(error: error)
            } else {
                self.competitions = []
                self.competitions?.append(contentsOf: categoryComps?.activityList ?? [])
                self.competitions?.append(contentsOf: categoryComps?.competitions ?? [])
                self.viewHandler?.reloadView()
            }
        }
    }
    
    func backButtonTapped() {
        self.viewHandler?.popViewController()
    }
    
    func itemSelected(index: Int) {
        if let activity = self.competitions?[index] {
            if activity.categoryType == "ACADEMIC" {
                let activityMain = AcademicCompetitions(rewardType: activity.rewardType,
                                                        entryFee: activity.entryFee,
                                                        status: activity.status,
                                                        participationCount: activity.participationCount,
                                                        maxAge: activity.maxAge,
                                                        rewardRuleId: activity.rewardRuleID,
                                                        createdTimeStamp: activity.createdTimeStamp,
                                                        background: activity.background,
                                                        endTime: activity.endTime,
                                                        activity: activity.activity,
                                                        name: activity.name,
                                                        priority: activity.priority,
                                                        prize: activity.prize,
                                                        imageUrl: activity.imageURL,
                                                        id: activity.id,
                                                        questionCriteria: activity.questionCriteria,
                                                        paid: activity.paid,
                                                        participationCloseTime: activity.participationCloseTime,
                                                        subCategory: activity.participationCloseTime,
                                                        minParticipants: activity.minParticipants,
                                                        contentMaxDuration: activity.minParticipants,
                                                        minAge: activity.minAge,
                                                        certificateGenerated: activity.certificateGenerated,
                                                        maxParticipants: activity.maxParticipants,
                                                        standards: activity.standards,
                                                        sample: activity.sample,
                                                        mediaType: activity.mediaType,
                                                        startTime: activity.startTime,
                                                        guide: nil,
                                                        evaluationDetails: activity.evaluationDetails,
                                                        categoryType: activity.categoryType,
                                                        description: activity.activityListDescription,
                                                        categoryImage: activity.categoryImage)
                
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                guard let ob_vc = storyBoard.instantiateViewController(withIdentifier: "CompetitionDetailedViewController") as? CompetitionDetailedViewController else {return}
                ob_vc.type = .detailedView_accademic
                ob_vc.academicCompetition = activityMain
                self.viewHandler?.pushViewController(viewController: ob_vc)

            } else {
                let activityMain = Activity(rewardType: activity.rewardType,
                                            entryFee: activity.entryFee,
                                            status: activity.status,
                                            participationCount: activity.participationCount,
                                            maxAge: activity.maxAge,
                                            rewardRuleId: activity.rewardRuleID,
                                            createdTimeStamp: activity.createdTimeStamp,
                                            background: activity.background,
                                            endTime: activity.endTime,
                                            activity: activity.activity,
                                            name: activity.name,
                                            priority: activity.priority,
                                            prize: activity.prize,
                                            imageUrl: activity.imageURL,
                                            id: activity.id,
                                            paid: activity.paid,
                                            contentMaxDuration: activity.contentMaxDuration,
                                            participationCloseTime: activity.participationCloseTime,
                                            subCategory: activity.subCategory,
                                            minParticipants: activity.minParticipants,
                                            certificateGenerated: activity.certificateGenerated,
                                            minAge: activity.minAge,
                                            standards: activity.standards,
                                            maxParticipants: activity.maxParticipants,
                                            sample: activity.sample,
                                            mediaType: activity.mediaType,
                                            guide: nil,
                                            startTime: activity.startTime,
                                            evaluationDetails: activity.evaluationDetails,
                                            categoryType: activity.categoryType,
                                            description: activity.activityListDescription,
                                            sponsorDetails: nil,
                                            categoryImage: activity.categoryImage)
                
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                guard let ob_vc = storyBoard.instantiateViewController(withIdentifier: "CompetitionDetailedViewController") as? CompetitionDetailedViewController else {return}
                ob_vc.type = .detailedView
                ob_vc.completitionDetails = activityMain
                self.viewHandler?.pushViewController(viewController: ob_vc)
            }
        }
    }
}
