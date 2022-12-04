//
//  ImdbViewController.swift
//  breakingBadAPI
//
//  Created by Tarik Efe on 25.11.2022.
//

import UIKit
import WebKit

class ImdbViewController: BaseViewController, WKNavigationDelegate {
    //MARK: Variables
    @IBOutlet weak var webView: WKWebView!
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://www.imdb.com/title/tt0903747/"
        if let url = URL(string: urlString) {
            webView.navigationDelegate = self
            indicator.startAnimating()
            webView.load(URLRequest(url: url))
        }
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [refresh]
        navigationController?.isToolbarHidden = false
    }
    //MARK: Methods
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
        indicator.stopAnimating()
    }
}
