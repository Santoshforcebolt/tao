//
//  TrendingVideosCollectionViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 01/09/22.
//

import Foundation

class TrendingVideosCollectionViewModel: BaseViewModel {
    
    var competitions: [MediaEntryResponseList]?
    
    init(competitions: [MediaEntryResponseList]?) {
        self.competitions = competitions
        super.init()
    }
    
    func trendingItemSelected(index: Int) {
        var tvMediaList: [TVMedia] = []
        if let mediaEntries = self.competitions {
            for mediaEntry in mediaEntries {
                let tvMedia = TVMedia(userId: mediaEntry.userId,
                                      userShared: mediaEntry.userShared,
                                      likes: mediaEntry.likes,
                                      competitionCategory: mediaEntry.competitionCategory,
                                      shares: mediaEntry.shares,
                                      reported: mediaEntry.reported,
                                      views: mediaEntry.views,
                                      participantName: mediaEntry.participantName,
                                      competitionName: mediaEntry.competitionName,
                                      name: mediaEntry.name,
                                      resourceURL: mediaEntry.resourceURL,
                                      id: mediaEntry.id,
                                      userLiked: mediaEntry.userLiked,
                                      mediaType: mediaEntry.mediaType,
                                      competitionSubCategory: mediaEntry.competitionSubCategory,
                                      blocked: mediaEntry.blocked,
                                      thumbnailURL: mediaEntry.thumbnailURL,
                                      competitionId: mediaEntry.competitionId,
                                      submittedTimestamp: mediaEntry.submittedTimestamp,
                                      description: mediaEntry.description)
                tvMediaList.append(tvMedia)
            }
        }
        self.viewHandler?.showStoryView(mediaEntries: tvMediaList, index: index)
    }
}
