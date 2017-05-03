//
//  NewsDetailsVC.swift
//  NewsApp
//
//  Created by Songyee Park on 5/3/17.
//  Copyright © 2017 Songyee Park. All rights reserved.
//

import UIKit
import WebKit

class NewsDetailsVC: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    var urlString: String!

    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let articleURL = URL(string: urlString)
        let request = URLRequest(url: articleURL!)
        webView.load(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
