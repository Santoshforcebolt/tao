//
//  PermissionManager.swift
//  tao
//
//  Created by Mayank Khursija on 28/05/22.
//

import Foundation
import PhotosUI

class PermissionManager {
    
    var isPhotoLibraryPermissionGranted: Bool {
        return PHPhotoLibrary.authorizationStatus() == .authorized ? true : false
    }
    
    func requestForLibrary(completed: @escaping (Bool) -> Void) {
        
        let permission = PHPhotoLibrary.authorizationStatus()
        if permission == .notDetermined || permission == .denied {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized {
                    completed(true)
                } else {
                    completed(false)
                }
            })
        }
    }
}
