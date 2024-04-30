//
//  SpecialComtetitionTableViewCell.swift
//  tao
//
//  Created by Betto Akkara on 19/02/22.
//

import UIKit

class SpecialComtetitionTableViewCell: UICollectionViewCell {

    @IBOutlet weak var enterCodeTextField: UITextField!
    var code: String = ""
    var presentingVC: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.enterCodeTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.code = textField.text ?? ""
    }
    
    @IBAction func enterCodeButtonTapped(_ sender: Any) {
        ApiProviderImpl.instance.competitionApi.getCompetitions(with: self.code) { competitionData, error in
            if error != nil {
                print(error.debugDescription)
            } else {
                if let competitionData = competitionData,
                   let presentingVC = self.presentingVC {
                    let viewModel = PrivateCompetitionViewModel(competitionsData: competitionData)
                    let viewController = PrivateCompetitionViewController(viewModel)
                    let viewHandler = BaseViewHandler(presentingViewController: presentingVC)
                    viewModel.viewHandler = viewHandler
                    viewHandler.pushViewController(viewController: viewController)
                }
            }
        }
    }
}
