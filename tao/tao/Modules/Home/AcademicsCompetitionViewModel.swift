//
//  AcademicsCompetitionViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 03/09/22.
//

import Foundation

class AcademicsCompetitionViewModel: BaseViewModel {
    
    var competitions: [AcademicCompetitions]
    
    init(competitions: [AcademicCompetitions]) {
        self.competitions = competitions
        super.init()
    }
    
    func itemSelected(index: Int) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let ob_vc = storyBoard.instantiateViewController(withIdentifier: "CompetitionDetailedViewController") as? CompetitionDetailedViewController else {return}
        ob_vc.type = .detailedView_accademic
        ob_vc.academicCompetition = self.competitions[index]
        self.viewHandler?.pushViewController(viewController: ob_vc)
    }
}
