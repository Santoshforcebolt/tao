//
//  PlayerLayerView.swift
//  tao
//
//  Created by Mayank Khursija on 10/06/22.
//

import Foundation
import AVKit

class PlayerView: UIView {

    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }

    var playerLayer: AVPlayerLayer {
    
        return layer as! AVPlayerLayer
    }

    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
    
        set {
            playerLayer.player = newValue
        }
    }
}
