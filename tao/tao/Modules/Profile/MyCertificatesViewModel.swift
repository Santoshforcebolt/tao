//
//  MyCertificatesViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 15/08/22.
//

import Foundation

class MyCertificatesViewModel: BaseViewModel {
    var cursor: String?
    var myCompetitions: MyCompetitions?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewHandler?.showLoading()
        self.apiProvider.competitionApi.getMyCompetitions(cateogry: "ALL", cursor: nil) { myCompetitions, error in
            self.viewHandler?.stopLoading()
            if error != nil {
                self.handleError(error: error)
            } else {
                self.cursor = myCompetitions?.body?.cursor
                self.myCompetitions = myCompetitions
                self.viewHandler?.reloadView()
            }
        }
    }
    
    func backButtonTapped() {
        self.viewHandler?.popViewController()
    }
    
    func loadMore() {
        if let cursor = cursor {
            self.apiProvider.competitionApi.getMyCompetitions(cateogry: "ALL", cursor: cursor) { myCompetitions, error in
                if error != nil {
                    self.handleError(error: error)
                } else {
                    self.cursor = myCompetitions?.body?.cursor
                    self.myCompetitions = myCompetitions
                    self.viewHandler?.reloadView()
                }
            }
        }
    }
    
    func downloadTapped(index: Int) {
        self.viewHandler?.showLoading()
        if let competition = self.myCompetitions?.body?.data?[index],
           let link = competition.certificateLink {
            DownloadManager.instance.saveFile(url: link,
                                              fileName: "Tao-Certificate-\(self.myCompetitions?.body?.data?[index].competitionName ?? "")") { success in
                
                DispatchQueue.main.async {
                    if success {
                        self.viewHandler?.showToast(with: "Certificate downloaded!")
                    } else {
                        self.viewHandler?.showToast(with: "Some error occured! Please try again!")
                    }
                }
            }
        } else {
            self.apiProvider.competitionApi.getCertificateDetails(competitionId: self.myCompetitions?.body?.data?[index].competitionId ?? "") { certificateData, error in
                self.viewHandler?.stopLoading()
                if error != nil {
                    self.handleError(error: error)
                } else {
                    if let link = certificateData?.certificateLink {
                        DownloadManager.instance.saveFile(url: link,
                                                          fileName: "Tao-Certificate-\(self.myCompetitions?.body?.data?[index].competitionName ?? "")") { success in
                            
                            DispatchQueue.main.async {
                                if success {
                                    self.viewHandler?.showToast(with: "Certificate downloaded!")
                                } else {
                                    self.viewHandler?.showToast(with: "Some error occured! Please try again!")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    //MARK: - Save Image callback

    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            self.viewHandler?.showToast(with: error.localizedDescription)

        } else {
            self.viewHandler?.showToast(with: "Certificate Downloaded")
        }
    }
}
