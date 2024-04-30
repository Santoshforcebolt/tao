//
//  NetworkReachability.swift
//  tao
//
//  Created by Betto Akkara on 03/02/22.
//

import Foundation

class ConnectionManager {

static let sharedInstance = ConnectionManager()
private var reachability : Reachability!

    static var is_reachable : Bool!

func observeReachability(){
    do {
        try! self.reachability = Reachability()
    }catch(let error) {
        Logger.i("Error occured while starting reachability : \(error.localizedDescription)")
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
        break
    case .wifi:
        Logger.i("Network available via WiFi.")
        ConnectionManager.is_reachable = true
        break
    case .unavailable:
        Logger.i("Network is  unavailable.")
        ConnectionManager.is_reachable = false
        break
    }
  }
}
