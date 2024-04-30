//
//  ApiProvider.swift
//  tao
//
//  Created by Mayank Khursija on 28/05/22.
//

import Foundation

protocol ApiProvider {
    var mediaApi: MediaApi { get }
    var storeApi: StoreApi { get }
    var tvApi: TVApi { get }
    var profileApi: ProfileApi { get }
    var leaderBoardApi: LeaderBoardApi { get }
    var manageSubscription: ManageSubscriptionApi { get }
    var competitionApi: CompetitionApi { get }
    var quizApi: QuizApi { get }
    var notificationApi: NotificationApi { get }
    var homeApi: HomeApi { get }
}

class ApiProviderImpl: ApiProvider {

    static var instance = ApiProviderImpl()
    
    private init() {
        //
    }
    
    var mediaApi: MediaApi {
        return MediaApiImpl()
    }
    
    var storeApi: StoreApi {
        return StoreApiImpl()
    }
    
    var tvApi: TVApi {
        return TVApiImpl()
    }
    
    var profileApi: ProfileApi {
        return ProfileApiImpl()
    }
    
    var leaderBoardApi: LeaderBoardApi {
        return LeaderBoardApiImpl()
    }
    
    var manageSubscription: ManageSubscriptionApi {
        return ManageSubscriptionApiImpl()
    }
    
    var competitionApi: CompetitionApi {
        return CompetitionApiImpl()
    }
    
    var quizApi: QuizApi {
        return QuizApiImpl()
    }
    
    var notificationApi: NotificationApi {
        return NotificationApiImpl()
    }
    
    var homeApi: HomeApi {
        return HomeApiImpl()
    }
}
