//
//  TaoNavigationController.swift
//  tao
//
//  Created by Betto Akkara on 06/02/22.
//

import Foundation
import UIKit

class TaoNavigationController: UINavigationController {
    
    
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.filter({$0.isKind(of: ofClass)}).last {
            popToViewController(vc, animated: animated)
        }
    }
    
    func showAlert(title: String?,
                   message: String?,
                   actions: [UIAlertAction],
                   controller: UIViewController) {
        let alertViewController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)
        
        for action in actions {
            alertViewController.addAction(action)
        }
        
        controller.navigationController?.present(alertViewController,
                                                 animated: true,
                                                 completion: nil)
    }
    
}
