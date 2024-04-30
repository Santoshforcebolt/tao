//
//  CulturalListViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 01/09/22.
//

import Foundation

class CulturalListViewModel: BaseViewModel {
    var competitions: [AcademicCompetitions]
    
    init(competitions: [AcademicCompetitions]) {
        self.competitions = competitions
        super.init()
    }
    
    func backButtonTapped() {
        self.viewHandler?.popViewController()
    }
}
