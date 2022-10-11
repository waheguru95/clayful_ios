//
//  FeedbackPopUpVC.swift
//  Clayful
//
//  Created by netset on 15/07/22.
//

import UIKit
import WebKit

class FeedbackPopUpVC: UIViewController,WKNavigationDelegate {
    
    @IBOutlet weak var webVwFeedback: WKWebView!
    
    var linkUrlStr = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataOnWebView()
    }
    
    //MARK:- WKNavigationDelegate Method
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("My Url String :- ",webView.url?.absoluteString ?? "")
        let urlString = webView.url?.absoluteString ?? ""
        if urlString.contains("https://app.clayfulhealth.com/mindfulness") {
            self.dismiss(animated: true,completion: nil)
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
}
extension FeedbackPopUpVC {
    
    func loadDataOnWebView() {
        webVwFeedback.navigationDelegate = self
        webVwFeedback.scrollView.bounces = false
        debugPrint("Web View Url:- ",linkUrlStr)
        if let url = URL(string: linkUrlStr) {
            self.webVwFeedback.load(URLRequest(url: url))
        }
    }
}
