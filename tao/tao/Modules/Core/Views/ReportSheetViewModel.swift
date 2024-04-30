//
//  BottomSheetViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 14/06/22.
//

import Foundation

enum ReportSheetState {
    case mainOptions
    case reportOptions
}

class ReportSheetViewModel: BaseViewModel {
    
    private let listOfMainItems: [String]
    private var listOfReportItems: [ReportReason]?
    var sheetItems: [String]
    private var sheetState: ReportSheetState = .mainOptions
    private var userId: String
    private var mediaId: String
    private var completion: (String)-> Void
    
    init(listOfMainItems: [String],
         listOfReportItems: [String],
         mediaId: String,
         userId: String,
         completion: @escaping (String)-> Void) {
        self.listOfMainItems = listOfMainItems
        self.sheetItems = self.listOfMainItems
        self.mediaId = mediaId
        self.userId = userId
        self.completion = completion
        super.init()
        
        self.apiProvider.tvApi.getReportReasons { reasons, error in
            if error != nil {
                self.handleError(error: error)
            } else {
                self.listOfReportItems = reasons
            }
        }
    }
    
    //MARK: Completion is hack, Reason: we can not give view handler to this view model
    func itemSelected(index: Int, completion: ()->Void) {
        if self.sheetItems[index].lowercased().contains("block") {
            let cancelAlertAction = UIAlertAction(title: "Cancel",
                                                  style: .cancel,
                                                  handler: nil)
            let blockAlertAction = UIAlertAction(title: "Block", style: .default) { _ in
                self.apiProvider.tvApi.reportUser(userId: self.userId) { _, error in
                    if error != nil {
                        self.handleError(error: error)
                    } else {
                        self.completion("user")
                    }
                }
            }
            
            self.viewHandler?.showAlert(with: "Block this user?",
                                        message: "Please be sure if you want to block this user. ",
                                        actions: [cancelAlertAction, blockAlertAction])
        } else {
            switch self.sheetState {
            case .mainOptions:
                var items: [String] = []
                for index in 0..<(self.listOfReportItems?.count ?? 0) {
                    items.append(self.listOfReportItems?[index].description ?? "")
                }
                self.sheetItems = items
                self.sheetState = .reportOptions
                completion()
            case .reportOptions:
                if let reportReason = self.listOfReportItems?[index] {
                    self.apiProvider.tvApi.reportMedia(userId: self.userId,
                                                       mediaId: self.mediaId,
                                                       reportReason: reportReason) { _, error in
                        if error != nil {
                            self.handleError(error: error)
                        } else {
                            self.completion("media")
                        }
                    }

                }
            }
        }
    }
}
