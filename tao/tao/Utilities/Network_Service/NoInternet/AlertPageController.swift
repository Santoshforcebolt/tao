//
//  AlertPageController.swift
//  creditcardapp
//
//  Created by Betto Akkara on 18/09/21.
//

import UIKit

var AlertPage = AlertPageController.init()

open class AlertPageController: NSObject {

    private static var alertPage : NointernetViewController?

    func show(data : AlertPageData?, controller: UIViewController, delegate : Any? = nil) {

        let vc = NointernetViewController.loadVCFromNib
        vc.modalPresentationStyle = .overFullScreen
        vc.data = data
        vc.delegate = delegate == nil ? (controller as? AlertpageDelegate) : (delegate as? AlertpageDelegate)
        AlertPageController.alertPage = vc
        delay(0.1, completion: {
            DispatchQueue.main.async {
                controller.present(vc, animated: false, completion: nil)
            }
        })
    }

    func dismiss() {
        DispatchQueue.main.async {
            AlertPageController.alertPage?.dismiss(animated: true, completion: {
                AlertPageController.alertPage?.AlertPageDismiss()
            })
        }
    }

}
