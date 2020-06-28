//
//  VKService.swift
//  VKontakte-CSA
//
//  Created by Ирина Семячкина on 21.06.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class VKService {
    
    let baseUrl = "https://api.vk.com"
    let accessToken = Session.instance.token
    
    
    // MARK: - FRIENDS
    
    public func loadFriends(id: Int, completion: @escaping ([Friend]) -> Void) {
        
// https://api.vk.com/method/friends.get?user_id=6492&order=name&fields=photo_200_orig&count=20&access_token=\(Session.instance.token)&v=5.110
        
        let path = "/method/friends.get"
        
        let parameters: Parameters = [
            "user_id" : id,
            "order" : "name",
            "fields": "photo_200_orig",
            "count" : "20",
            "access_token" : self.accessToken,
            "v" : "5.110"
        ]
        
        let url = self.baseUrl + path

        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            switch response.result {
            
            case .success(let value):
                let json = JSON(value)
                let friends = json["response"]["items"].arrayValue.map { Friend(json: $0) }
                completion(friends)
            
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
        // MARK: - GROUPS
    
// https://api.vk.com/method/groups.get?user_id=35162218&extended=1&count=10&access_token=\(Session.instance.token)&v=5.110
    
    public func loadGroups(id: Int, completion: @escaping ([Group]) -> Void) {
        
        let path = "/method/groups.get"
        
        let parameters: Parameters = [
            "user_id" : id,
            "extended" : "1",
            "access_token" : self.accessToken,
            "v" : "5.110"
        ]
        
        let url = self.baseUrl + path
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            switch response.result {
            
            case .success(let value):
                let json = JSON(value)
                let groups = json["response"]["items"].arrayValue.map { Group(json: $0) }
                completion(groups)
            
            case .failure(let error):
                print(error)
            }
        }
    }
}

