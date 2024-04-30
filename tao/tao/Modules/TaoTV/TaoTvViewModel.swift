//
//  TaoStoreViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 08/06/22.
//

import Foundation

class TaoTvViewModel: BaseViewModel {
    
    private var tvMedia: [TVMedia] = []
    var pills: [String] = ["All", "Singing", "Dance", "Art", "Maths", "Science"]
    var currentPill = "All"
    var cursor: String?
    
    var mediaEntries: [MediaEntryResponseList] {
        return TaoHelper.homeDetails?.mediaEntryResponseList ?? []
    }
    
    var numberOfEntries: Int {
        return self.tvMedia.count
    }
    
    func getMediaItem(index: Int) -> TVMedia? {
        return self.tvMedia[index]
    }

    func itemSelected(index: Int) {
        self.viewHandler?.showStoryView(mediaEntries: self.tvMedia, index: index)
    }
    
    func searchButtonTapped() {
        self.viewHandler?.showSearchScreen(searchFlow: .user)
    }
    
    func pillSelected(index: Int) {
        self.currentPill = self.pills[index]
        self.loadForPills()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        let params = ["type" : self.currentPill.uppercased(), "userId": TaoHelper.userID ?? ""]
        self.tvMedia = [] //Reset Media
        self.viewHandler?.showLoading()
        self.apiProvider.tvApi.getAllMedia(parameters: params) { tvItem, error in
            self.viewHandler?.stopLoading()
            if error != nil {
                self.handleError(error: error)
            } else {
                self.tvMedia.append(contentsOf: tvItem?.body?.media ?? [])
                self.cursor = tvItem?.body?.nextCursor
                self.viewHandler?.reloadView()
            }
        }
    }
    
    func loadMediaEntries() {
        let params: [String: Any]
        if self.cursor != nil {
            params = ["type" : self.currentPill.uppercased(),
                      "userId": TaoHelper.userID ?? "",
                      "cursor": self.cursor ?? ""]
            self.apiProvider.tvApi.getAllMedia(parameters: params) { tvItem, error in
                if error != nil {
                    self.handleError(error: error)
                } else {
                    self.tvMedia.append(contentsOf: tvItem?.body?.media ?? [])
                    self.cursor = tvItem?.body?.nextCursor
                    self.viewHandler?.reloadView()
                }
            }
        }
    }
    
    func loadForPills() {
        let params: [String: Any]
        if self.cursor != nil {
            self.cursor = nil
            self.tvMedia = []
        }
        self.viewHandler?.showLoading()
        params = ["type" : self.currentPill.uppercased(),
                  "userId": TaoHelper.userID ?? "",
                  "cursor": self.cursor ?? ""]
        self.apiProvider.tvApi.getAllMedia(parameters: params) { tvItem, error in
            self.viewHandler?.stopLoading()
            if error != nil {
                self.handleError(error: error)
            } else {
                self.tvMedia = tvItem?.body?.media ?? []
                self.cursor = tvItem?.body?.nextCursor
                self.viewHandler?.reloadView()
            }
        }
    }
}
