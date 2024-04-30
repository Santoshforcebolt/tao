//
//  NetworkReachability.swift
//  creditcardapp
//
//  Created by Betto Akkara on 18/09/21.
//

import Foundation
import UIKit

class ConnectionManager {

static let sharedInstance = ConnectionManager()
private var reachability : Reachability!

    static var is_reachable : Bool!

func observeReachability(){
    do {
        try self.reachability = Reachability()
    } catch let err {
        Logger.i(err)
    }

    NotificationCenter.default.addObserver(self, selector:#selector(self.reachabilityChanged), name: NSNotification.Name.reachabilityChanged, object: nil)
    do {
        try self.reachability.startNotifier()
    }
    catch(let error) {
        Logger.i("Error occured while starting reachability notifications : \(error.localizedDescription)")
    }
}

@objc func reachabilityChanged(note: Notification) {
    let reachability = note.object as! Reachability
    switch reachability.connection {
    case .cellular:
        Logger.i("Network available via Cellular Data.")
        ConnectionManager.is_reachable = true
        AlertPage.dismiss()
        break
    case .wifi:
        Logger.i("Network available via WiFi.")
        ConnectionManager.is_reachable = true
        AlertPage.dismiss()
        break
    case .unavailable:
        Logger.i("Network is  unavailable.")
        ConnectionManager.is_reachable = false
        AlertPage.show(data: AlertPageData(title: "No Internet", message: "Oops, There is no internet connection.\nYou need to be connected to the internet. Make sure that you have connected to WiFi or Cellular Data, then try again.", image: UIImage(), btnTitile: "RETRY"), controller: ((UIWindow.key_window?.visibleViewController) ?? UIApplication.topViewController())!)
        break
    }
  }
}
