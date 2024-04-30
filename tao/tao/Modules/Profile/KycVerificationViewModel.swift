//
//  KycVerificationViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 24/06/22.
//

import Foundation

class KycVerificationViewModel: BaseViewModel {
    
    enum IdType: String {
        case aadhar = "AADHAR"
        case schoolId = "SCHOOL_ID"
    }
    
    var previewImageUrl: URL?
    var idType: IdType = .aadhar
    var remark: String?
    
    func uploadDocumentTapped(uniqueId: String?) {
        if let fileURL = self.previewImageUrl {
            if self.validate(uniqueId: uniqueId) {
                self.viewHandler?.showLoading()
                self.apiProvider.profileApi.uploadId(fileURL: fileURL) { kycDocument, error in
                    self.viewHandler?.stopLoading()
                    if error != nil {
                        self.handleError(error: error)
                    } else {
                        self.viewHandler?.showLoading()
                        self.apiProvider.profileApi.requestForKYC(idType: self.idType.rawValue,
                                                                  uniqueId: uniqueId,
                                                                  idUrl: kycDocument?.url ?? "") { kycStatus, error in
                            self.viewHandler?.stopLoading()
                            if error != nil {
                                self.handleError(error: error)
                            } else {
                                self.viewHandler?.showAlert(with: "Verification Application Submitted",
                                                            message: "You will hear back from us within 24-72 hours",
                                                            actions: [UIAlertAction(title: "Okay",
                                                                                    style: .cancel,
                                                                                    handler: { _ in
                                    self.viewHandler?.popViewController()
                                })])
                            }
                        }
                    }
                }
            } else {
                self.viewHandler?.showToast(with: "Please Enter Aadhar Number")
            }
            
        } else {
            self.viewHandler?.getMediaURLFromLibrary(mediaType: .image) { url in
                self.previewImageUrl = url
                self.viewHandler?.reloadView()
            }
        }
    }
    
    private func validate(uniqueId: String?) -> Bool {
        switch self.idType {
        case .aadhar:
            return uniqueId == nil ? false : true
        case .schoolId:
            return true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewHandler?.showLoading()
        self.apiProvider.profileApi.getKycStatus { kycStatus, error in
            self.viewHandler?.stopLoading()
            if error != nil {
                self.handleError(error: error)
            } else {
                print(kycStatus?.status ?? "")
                self.remark = kycStatus?.remark
                let kycStatus = KycStatuses(rawValue: kycStatus?.status ?? "") ?? .REJECTED
                switch kycStatus {
                case .PENDING, .APPROVED:
                    self.viewHandler?.showKycStatus(status: kycStatus)
                case .REJECTED:
                    self.viewHandler?.reloadView()
                }
            }
        }
    }
    
    func backButtonTapped() {
        self.viewHandler?.popViewController()
    }
}
