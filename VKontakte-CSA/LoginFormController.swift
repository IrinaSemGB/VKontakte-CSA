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

class LoginFormController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var scroll: UIScrollView?
    @IBOutlet weak var webView: WKWebView? {
        didSet {
            webView?.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.openVKAutorization()
    }
    
    
    func openVKAutorization() {
        
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
        
        let token = params["access_token"]
        
        let session = Session.instance
        session.token = token ?? "Token is not found"
        session.userID = 6972579
        
        print(session.token, "\(session.userID)")
        
        
        // профиль
        AF.request("https://api.vk.com/method/users.get?user_ids=210700286&fields=bdate&access_token=\(session.token)&v=5.110").responseJSON { (response) in
//            print(response.value as Any)
        }
        
        // список друзей
        AF.request("https://api.vk.com/method/friends.get?user_id=6492&order=name&fields=city,domain&name_case=ins&access_token=\(session.token)&v=5.110").responseJSON { (response) in
//        print(response.value as Any)
        }
        
        // список фото
        AF.request("https://api.vk.com/method/photos.get?owner_id=-1&album_id=wall&count=10&access_token=\(session.token)&v=5.110").responseJSON { (response) in
//            print(response.value as Any)
        }
        
        // список групп
        AF.request("https://api.vk.com/method/groups.get?user_id=35162218&extended=1&count=10&access_token=\(session.token)&v=5.110").responseJSON { (response) in
//                print(response.value as Any)
            }
        
        // поиск групп
        AF.request("https://api.vk.com/method/groups.search?q=Music&count=10&access_token=\(session.token)&v=5.110").responseJSON { (response) in
//            print(response.value as Any)
        }
        
        
        decisionHandler(.cancel)
    }
    
}
