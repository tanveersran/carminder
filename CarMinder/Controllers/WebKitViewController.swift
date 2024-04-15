//
//  WebKitViewController.swift
//  CarMinder
//
//  Created by Default User on 4/15/24.
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
