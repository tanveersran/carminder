//
//  WebKitViewController.swift
//  CarMinder
//
//  Created by Tanveer on 4/15/24.
// This file is used to show the web page in our application using WebKit.
//

import UIKit
import WebKit

class WebKitViewController: UIViewController , WKNavigationDelegate{
    
    @IBOutlet var webView : WKWebView!
    @IBOutlet var activity : UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

            let urlAddress = URL(string: "https://t.ly/kTu2b")
            let url = URLRequest(url: urlAddress!)
            webView?.load(url)
            webView.navigationDelegate = self
       

    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activity.isHidden = false
        activity.startAnimating()
    }
    

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activity.isHidden = true
        activity.stopAnimating()
    }
    


}
