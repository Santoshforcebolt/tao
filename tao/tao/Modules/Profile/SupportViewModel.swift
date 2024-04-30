//
//  SupportViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 12/08/22.
//

import Foundation

class SupportViewModel: BaseViewModel {
    
    func openWhatsapp() {
        let urlWhats = "whatsapp://send?phone=+918095563666&abid=12354&text=Hello"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL) {
                    UIApplication.shared.open(whatsappURL,
                                              options: [:],
                                              completionHandler: nil)
                } else {
                    print("Install Whatsapp")
                }
            }
        }
    }
    
    func openEmail() {
        let email = "support@tao.live"
        if let url = URL(string: "mailto:\(email)") {
          if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
          } else {
            UIApplication.shared.openURL(url)
          }
        }
    }
    
    func openPhone() {
        if let url = URL(string: "tel://8095563666") {
          if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
          } else {
            UIApplication.shared.openURL(url)
          }
        }

    }
    
    func backButtonTapped() {
        self.viewHandler?.popViewController()
    }
}
