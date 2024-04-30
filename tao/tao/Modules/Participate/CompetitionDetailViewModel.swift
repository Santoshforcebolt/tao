//
//  ComeptitionDetailViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 02/06/22.
//

import Foundation

class CompetitionDetailViewModel: BaseViewModel {
    
    func backButtonTapped() {
        self.viewHandler?.popViewController()
    }
}
