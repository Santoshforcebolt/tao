//
//  StoryCellViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 13/06/22.
//

import Foundation

class StoryCellViewModel: BaseViewModel {
    
    var mediaEntry: TVMedia
    var userLiked: Bool
    
    private var moreMainOptions = ["Report", "Block this User"]
    private var reportOptions = ["It’s a spam", "Adult Content", "Hate Speech or Symbols", "False Information", "I just don’t like it"]
    
    init(mediaEntry: TVMedia) {
        self.mediaEntry = mediaEntry
        self.userLiked = self.mediaEntry.userLiked ?? false
        super.init()
    }
    
    var participationName: String {
        return self.mediaEntry.participantName ?? ""
    }
    
    var description: String {
        return self.mediaEntry.description ?? ""
    }
    
    var resourceUrl: String {
        return self.mediaEntry.resourceURL ?? ""
    }
    
    var likesText: String {
        return "\(self.mediaEntry.likes ?? 0)"
    }
    
    var competitionName: String {
        return self.mediaEntry.competitionName ?? ""
    }
    
    var viewCount: String {
        return "\(self.mediaEntry.views ?? 0)"
    }
    
    func profileTapped() {
        self.viewHandler?.showVisitProfile(userId: self.mediaEntry.userId ?? "")
    }
    
    func closeClicked() {
        self.viewHandler?.popViewController()
    }
    
    func likeButtonClicked(completion: @escaping (Bool)-> Void) {
        let toggle = !self.userLiked
        self.apiProvider.tvApi.like(parameters: ["mediaId": self.mediaEntry.id ?? "",
                                                 "activity": toggle ? "LIKE" : "UNLIKE",
                                                 "userId": TaoHelper.userID ?? ""]) { _, error in
            if error != nil {
                self.handleError(error: error)
            } else {
                self.userLiked = toggle
                completion(toggle)
            }
        }
    }
    
    func shareButtonClicked() {
        self.viewHandler?.share(text: "Upvote \(mediaEntry.participantName ?? "")’s  entry for \(mediaEntry.competitionName ?? "") on https://tao.live/view/\(mediaEntry.id ?? "") to help them win this competition.")
    }
    
    func moreButtonClicked() {
        self.viewHandler?.showReportSheet(listOfMainItems: self.moreMainOptions,
                                          listOfReportItems: self.reportOptions,
                                          mediaId: self.mediaEntry.id ?? "",
                                          userId: self.mediaEntry.userId ?? "")
    }
    
    func trackView() {
        let params = ["view" : "1",
                      "mediaId": self.mediaEntry.id ?? ""]
        self.apiProvider.tvApi.trackView(parameters: params) { _, error in
            // do nothing if call fails
        }
    }
}
