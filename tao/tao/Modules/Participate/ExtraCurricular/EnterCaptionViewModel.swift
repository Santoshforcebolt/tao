//
//  EnterCaptionViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 01/06/22.
//

import Foundation

class EnterCaptionViewModel: BaseViewModel {
    
    var mediaDetails: MediaDetails
    var mediaType: String
    init(mediaDetails: MediaDetails, mediaType: String) {
        self.mediaDetails = mediaDetails
        self.mediaType = mediaType
        super.init()
    }
    
    func submitButtonTapped(text: String) {
        self.viewHandler?.showLoading()
        self.apiProvider.mediaApi.submitEntry(text: text, mediaType: self.mediaType, media: mediaDetails) { _, error in
            if error != nil {
                self.handleError(error: error)
            } else {
                self.viewHandler?.showSubmitVideo()
            }
        }
    }
    
    func backButtonTapped() {
        self.viewHandler?.popViewController()
    }
}
