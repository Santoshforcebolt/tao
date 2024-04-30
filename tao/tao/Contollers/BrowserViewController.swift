//
//  BrowserViewController.swift
//  tao
//
//  Created by Betto Akkara on 02/04/22.
//

import UIKit
import WebKit

class BrowserViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    @IBOutlet weak var containerView : UIView!
    
    var webView: WKWebView!

    var url_str = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.ignoresViewportScaleLimits = true
        webConfiguration.suppressesIncrementalRendering = true
        webConfiguration.allowsInlineMediaPlayback = true
        webConfiguration.allowsAirPlayForMediaPlayback = false
        webConfiguration.allowsPictureInPictureMediaPlayback = true
        webConfiguration.mediaTypesRequiringUserActionForPlayback = .all
        webConfiguration.requiresUserActionForMediaPlayback = true
        
        self.webView = WKWebView(frame: self.containerView.bounds, configuration: webConfiguration)
        self.webView.uiDelegate = self
        self.webView.navigationDelegate = self
        
        self.containerView = self.webView
        
        TaoHelper.delay(0.5) {
            DispatchQueue.main.async {
                print(self.url_str)
                let url = URL(string: self.url_str)!
                self.webView.load(URLRequest(url: url))
                self.webView.allowsBackForwardNavigationGestures = true
            }
        }
        
    }
}
