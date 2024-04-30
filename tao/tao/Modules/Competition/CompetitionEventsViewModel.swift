//
//  CompetitionEventsViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 14/08/22.
//

import Foundation

enum EntryFlow {
    case user
    case competition
}

class CompetitionEventsViewModel: BaseViewModel {
    
    var competitionId: String
    var cursor: String?
    var entries: CompetitionEntries?
    var flow: EntryFlow
    
    init(competitionId: String,
         for flow: EntryFlow = .competition) {
        self.competitionId = competitionId
        self.flow = flow
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewHandler?.showLoading()
        switch flow {
        case .user:
            self.apiProvider.competitionApi.getUserEntries(cursor: self.cursor) { entries, error in
                self.viewHandler?.stopLoading()
                if error != nil {
                    self.handleError(error: error)
                } else {
                    self.entries = entries
                    self.cursor = entries?.body?.nextCursor
                    self.viewHandler?.reloadView()
                }
            }
        case .competition:
            self.apiProvider.competitionApi.getEntries(competitionId: self.competitionId,
                                                       cursor: self.cursor) { entries, error in
                self.viewHandler?.stopLoading()
                if error != nil {
                    self.handleError(error: error)
                } else {
                    self.entries = entries
                    self.cursor = entries?.body?.nextCursor
                    self.viewHandler?.reloadView()
                }
            }
        }

    }
    
    func loadMediaEntries() {
        if let cursor = self.cursor {
            switch flow {
            case .user:
                self.apiProvider.competitionApi.getUserEntries(cursor: self.cursor) { entries, error in
                    self.viewHandler?.stopLoading()
                    if error != nil {
                        self.handleError(error: error)
                    } else {
                        self.entries = entries
                        self.cursor = entries?.body?.nextCursor
                        self.viewHandler?.reloadView()
                    }
                }
            case .competition:
                self.apiProvider.competitionApi.getEntries(competitionId: self.competitionId,
                                                           cursor: cursor) { entries, error in
                    if error != nil {
                        self.handleError(error: error)
                    } else {
                        self.entries?.body?.data?.append(contentsOf: entries?.body?.data ?? [])
                        self.cursor = entries?.body?.nextCursor
                        self.viewHandler?.reloadView()
                    }
                }
            }
            

        }
    }
    
    func backButtonTapped() {
        self.viewHandler?.popViewController()
    }
    
    func itemSelected(index: Int) {
        var tvMedias: [TVMedia] = []
        if let entries = entries?.body?.data {
            for entry in entries {
                let tvMedia = TVMedia(userId: entry.userID,
                                      userShared: entry.userShared,
                                      likes: entry.likes,
                                      competitionCategory: entry.competitionCategory,
                                      shares: entry.shares,
                                      reported: entry.reported,
                                      views: entry.views,
                                      participantName: entry.participantName,
                                      competitionName: entry.competitionName,
                                      name: entry.name,
                                      resourceURL: entry.resourceURL,
                                      id: entry.id,
                                      userLiked: entry.userLiked,
                                      mediaType: entry.mediaType,
                                      competitionSubCategory: entry.competitionSubCategory,
                                      blocked: entry.blocked,
                                      thumbnailURL: entry.thumbnailURL,
                                      competitionId: entry.competitionID,
                                      submittedTimestamp: entry.submittedTimestamp,
                                      description: entry.description)
                tvMedias.append(tvMedia)
            }
        }
        self.viewHandler?.showStoryView(mediaEntries: tvMedias, index: index)
    }
}
