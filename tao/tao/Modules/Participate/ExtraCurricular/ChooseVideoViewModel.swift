//
//  ChooseVideoViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 28/05/22.
//

import Foundation
import AVFoundation

class ChooseVideoViewModel: BaseViewModel {
    
    private let competionDetails: Activity
    private var mediaDetails: MediaDetails?
    
    init(competionDetails: Activity) {
        self.competionDetails = competionDetails
        super.init()
    }
    
    private let uploadUrlParam = "http://video.bunnycdn.com/library/%@/videos/%@"
    
    var bannerImageUrl: URL? {
        if let imageURLString = self.competionDetails.imageUrl,
           let imageURL = URL(string: imageURLString) {
           return imageURL
        }
        return nil
    }
    
    var bannerBackgroundColor: UIColor {
        return UIColor(hex: self.competionDetails.background) ?? .white
    }
    
    var titleText: String {
        return self.competionDetails.name ?? ""
    }
    
    var endDate: Date? {
        if let endTime = self.competionDetails.endTime {
            let date = DateConverter.convertDateFormat(endTime,
                                                       inputFormat: "yyyy-MM-dd'T'HH:mm:ss")
            return date
        }
        return nil
    }
    
    var rulesText: String {
        return "Rules\n\n1. Make sure that your face is clearly visible\n2. Do no upload screen recorded video\n\nFailure to adhere the rules will lead to deletion of entry"
    }
    
    var maxSizeOfVideo: Double {
        return Double(TaoHelper.configDetails?.maxUploadSize ?? 0)
    }
    
    func chooseButtonTapped() {
        if self.permissionManager.isPhotoLibraryPermissionGranted {
            self.viewHandler?.getMediaURLFromLibrary(completion: { videoURL in
                self.uploadVideo(videoURL: videoURL)
            })
        } else {
            self.permissionManager.requestForLibrary { isGranted in
                if isGranted {
                    self.viewHandler?.getMediaURLFromLibrary(completion: { videoURL in
                        self.uploadVideo(videoURL: videoURL)
                    })
                }
            }
        }
    }
    
    private func validateVideo(videoURL: URL) -> (Bool, String?) {
        let avAsset = AVURLAsset(url: videoURL)
        let maxDuration = Double(self.competionDetails.contentMaxDuration ?? 0)/1000.00
        let videoSeconds = avAsset.duration.seconds
        let fileSize: Double = Double(avAsset.fileSize ?? 0) / 1000000.00
        
        var error = ""
        
        if videoSeconds > maxDuration {
            error.append(contentsOf: "Video should not be longer than \(maxDuration) seconds")
        }
        if fileSize > self.maxSizeOfVideo {
            error.append(contentsOf: "\nVideo should not be greater than \(maxSizeOfVideo) mb")
            return (false, error)
        }
        return (true, nil)
    }
    
    private func uploadVideo(videoURL: URL) {
        let (isValid, error) = self.validateVideo(videoURL: videoURL)
        if isValid {
            let url = String(format: self.uploadUrlParam,
                             self.mediaDetails?.libraryId ?? "",
                             self.mediaDetails?.videoId ?? "")
            
            guard let bytes = NSData(contentsOf: videoURL) else { return }
            let parameters = ["file": bytes]
            self.viewHandler?.showLoading()
            self.apiProvider.mediaApi.uploadVideo(url: url,
                                                  videoUrl: videoURL,
                                                  parameters: parameters,
                                                  additionalHeaders: ["AccessKey": self.mediaDetails?.apiKey ?? "",
                                                                      "Content-Type": "application/*json"]) { bunnyUploadDetails, error in
                self.viewHandler?.stopLoading()
                if error != nil {
                    self.handleError(error: error)
                } else {
                    print("Succesfully Uploaded")
                    if bunnyUploadDetails?.success == true {
                        if let mediaDetails = self.mediaDetails {
                            self.viewHandler?.showAddCaption(mediaDetails: mediaDetails, mediaType: self.competionDetails.mediaType ?? "")
                        }
                    } else {
                        self.viewHandler?.showToast(with: "Uploading failed, Please try again")
                    }
                }
            }

            
        } else {
            self.viewHandler?.showToast(with: error)
        }
    }
    
    override func viewDidLoad() {
        self.apiProvider.mediaApi.getMediaDetails(userId: TaoHelper.userID ?? "",
                                                  competitionId: self.competionDetails.id ?? "",
                                                  parameters: ["name": self.competionDetails.name ?? ""],
                                                  additionalHeaders: nil) { mediaDetails, error in
            if error != nil {
                self.handleError(error: error)
            } else {
                self.mediaDetails = mediaDetails
            }
        }
    }
    
    func backButtonTapped() {
        self.viewHandler?.popViewController()
    }
}

extension AVURLAsset {
    var fileSize: Int? {
        let keys: Set<URLResourceKey> = [.totalFileSizeKey, .fileSizeKey]
        let resourceValues = try? url.resourceValues(forKeys: keys)

        return resourceValues?.fileSize ?? resourceValues?.totalFileSize
    }
}
