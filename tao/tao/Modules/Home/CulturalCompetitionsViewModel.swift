//
//  CulturalCompetitionsViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 03/09/22.
//

import Foundation

import Foundation

class CulturalCompetitionsViewModel: BaseViewModel {
    
    var competitions: [Activity]
    
    init(competitions: [Activity]) {
        self.competitions = competitions
        super.init()
    }
    
    func itemSelected(index: Int) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let ob_vc = storyBoard.instantiateViewController(withIdentifier: "CompetitionDetailedViewController") as? CompetitionDetailedViewController else {return}
        ob_vc.type = .detailedView
        ob_vc.completitionDetails = self.competitions[index]
        self.viewHandler?.pushViewController(viewController: ob_vc)
    }
}
