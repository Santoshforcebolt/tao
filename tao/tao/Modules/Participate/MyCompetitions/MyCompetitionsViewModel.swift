//
//  MyCompetitionsViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 10/08/22.
//

import Foundation

class MyCompetitionsViewModel: BaseViewModel {
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
    
    func loadCompetitions() {
        if let cursor = cursor {
            self.apiProvider.competitionApi.getMyCompetitions(cateogry: "ALL", cursor: cursor) { myCompetitions, error in
                if error != nil {
                    self.handleError(error: error)
                } else {
                    self.cursor = myCompetitions?.body?.cursor
                    self.myCompetitions?.body?.data?.append(contentsOf: myCompetitions?.body?.data ?? [])
                    self.viewHandler?.reloadView()
                }
            }

        }
    }
    
    func itemTapped(index: Int) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let ob_vc = storyBoard.instantiateViewController(withIdentifier: "CompetitionDetailedViewController") as? CompetitionDetailedViewController else {return}
        ob_vc.competitionId = self.myCompetitions?.body?.data?[index].competitionId
        self.viewHandler?.pushViewController(viewController: ob_vc)
//        self.parentViewController?.navigationController?.pushViewController(ob_vc, animated: true)
    }
    
}
