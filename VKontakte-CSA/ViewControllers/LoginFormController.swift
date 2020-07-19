//
//  LoginFormController.swift
//  VKontakte-CSA
//
//  Created by Ирина Семячкина on 15.06.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

class LoginFormController: UIViewController {
    
    
    // MARK: - Outlets
    
    @IBOutlet private weak var scroll: UIScrollView?
    @IBOutlet private weak var webView: WKWebView? {
        didSet {
            webView?.navigationDelegate = self
        }
    }
    
    // MARK: - Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.logoutVK()
        self.openVKAutorization()
    }
    
    
    // API request
    
    private func openVKAutorization() {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "6972579"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        webView?.load(request)
    }
    
    
    // MARK: - Logout

    private func logoutVK() {
        
        let dataStore = WKWebsiteDataStore.default()
        dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            dataStore.removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(),
                                 for: records.filter { $0.displayName.contains("vk") },
                                 completionHandler: { })
        }
    }
    
    
    // MARK: - Actions
    
    @IBAction func logoutButtomAction(segue: UIStoryboardSegue?) {
        self.logoutVK()
        webView?.reload()
    }
}


    // MARK: - WKNavigationDelegate

extension LoginFormController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
            
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
            
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
            
        guard let token = params["access_token"],
            let userId = Int(params["user_id"]!) else {
            decisionHandler(.cancel)
            return
        }
            
        Session.instance.token = token
        Session.instance.userID = userId
            
        print(token, userId)
        performSegue(withIdentifier: "openVK", sender: nil)
        decisionHandler(.cancel)
    }
}


