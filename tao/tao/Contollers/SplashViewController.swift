//
//  ViewController.swift
//  tao
//
//  Created by Betto Akkara on 02/02/22.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        TaoHelper.delay(1) {
            if AppController.shared.isUserSignedin {
                let parentVC = ParentViewController()
                self.navigationController?.pushViewController(parentVC, animated: true)
            } else {
                guard let ob_vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
                    return
                }
                self.navigationController?.navigationBar.isHidden = true
                self.navigationController?.pushViewController(ob_vc, animated: true)
            }
        }
        
    }
}

