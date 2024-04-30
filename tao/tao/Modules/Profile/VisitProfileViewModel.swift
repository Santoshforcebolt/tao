//
//  VisitProfileViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 03/07/22.
//

import Foundation

class VisitProfileViewModel: BaseViewModel {
    
    var userId: String
    var profile: VisitProfile?
    var profileMediaEntries: ProfileMediaBody?
    var completion: (Bool) -> Void
    
    init(userId: String, completion: @escaping (Bool) -> Void) {
        self.userId = userId
        self.completion = completion
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewHandler?.showLoading()
        self.apiProvider.profileApi.getProfile(for: self.userId) { profile, error in
            self.viewHandler?.stopLoading()
            if error != nil {
                self.handleError(error: error)
            } else {
                self.viewHandler?.showLoading()
                self.profile = profile
                if self.profile?.blocked ?? false {
                    self.completion(true)
                } else {
                    self.apiProvider.profileApi.getUserProfileEntries(id: self.userId) { profileMedia, error in
                        self.viewHandler?.stopLoading()
                        if error != nil {
                            self.handleError(error: error)
                        } else {
                            self.profileMediaEntries = profileMedia?.body
                            self.viewHandler?.reloadView()
                        }
                    }
                }
            }
        }
    }
    
    func followButtonTapped() {
        self.viewHandler?.showLoading()
        if self.profile?.following ?? false {
            self.apiProvider.profileApi.unfollowUser(id: self.userId) { emptyResponse, error in
                self.viewHandler?.stopLoading()
                if error != nil {
                    self.handleError(error: error)
                } else {
                    self.profile?.following = false
                    self.viewHandler?.reloadView()
                }
            }
        } else {
            self.apiProvider.profileApi.followUser(id: self.userId) { emptyResponse, error in
                self.viewHandler?.stopLoading()
                if error != nil {
                    self.handleError(error: error)
                } else {
                    self.profile?.following = true
                    self.viewHandler?.reloadView()
                }
            }
        }
    }
    
    func blockButtonTapped() {
        self.viewHandler?.showLoading()
        self.apiProvider.profileApi.blockUser(id: self.userId) { response, error in
            self.viewHandler?.stopLoading()
            if error != nil {
                self.handleError(error: error)
            } else {
                self.completion(true)
            }
        }
    }
    
    func itemSelected(index: Int) {
        if let mediaEntries = self.profileMediaEntries?.data {
            self.viewHandler?.showStoryView(mediaEntries: mediaEntries, index: index)
        }
    }
    
    func backButtonTapped() {
        self.viewHandler?.popViewController()
    }
}
