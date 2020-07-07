//
//  WebViewController.swift
//  MyChurch
//
//  Created by Zhekon on 29.05.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    let mainView = WebView()
    var liqPayUrl = String()
    let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigView()
        
        webView.frame = view.bounds
        webView.navigationDelegate = self
        let url = URL(string: "\(liqPayUrl)")!
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
        webView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        view.addSubview(webView)
    }
    
    func ConfigView() {
        self.view.addSubview(mainView)
        self.mainView.frame = self.view.bounds
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let urlStr = navigationAction.request.url {
            print(urlStr)
            if urlStr.description == "https://wwww.google.com/" {
                let alert = UIAlertController(title: "Повiдомлення", message: "Дякуємо за ваш благодiйний внесок.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Закрити", style: .cancel, handler: { (action: UIAlertAction!) in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
        if navigationAction.navigationType == .linkActivated  {
            if let url = navigationAction.request.url,
                let host = url.host, !host.hasPrefix("https://wwww.google.com"),
                UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
                print(url)
                print("Redirected to browser. No need to open it locally")
                decisionHandler(.cancel)
            } else {
                print("Open it locally")
                decisionHandler(.allow)
            }
        } else {
            print("not a user click")
            decisionHandler(.allow)
        }
    }
}

