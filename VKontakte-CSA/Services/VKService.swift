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
import RealmSwift

class VKService {
    
    let baseUrl = "https://api.vk.com"
    let accessToken = Session.instance.token
    let userID = Session.instance.userID
    
    
    // MARK: - USER
    
    func saveUser(_ user: [User], id: Int) {
        
        do {
            let realm = try Realm()
            let oldUsers = realm.objects(User.self).filter("id == %@", id)
            realm.beginWrite()
            realm.delete(oldUsers)
            realm.add(user)
            try realm.commitWrite()
            print(realm.configuration.fileURL as Any)
        } catch {
            print(error)
        }
    }
    
//    URL(string: "https://api.vk.com/method/users.get?user_ids=\(Session.instance.userID)&fields=city,bdate,photo_200,status&access_token=\(Session.instance.token)&v=5.110")!
    
    public func loadUser(id: Int, completion: @escaping ([User]) -> Void) {
        
        let path = "/method/users.get"
        
        let parameters: Parameters = [
            "user_ids" : self.userID,
            "fields" : "city,bdate,photo_200,status",
            "access_token" : self.accessToken,
            "v" : "5.110"
        ]
        
        let url = baseUrl + path
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            switch response.result {
                
            case .success(let value):
                let json = JSON(value)
                let user = json["response"].arrayValue.map { User(json: $0) }
                user.forEach { $0.id = id }
                self.saveUser(user, id: id)
                completion(user)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    // MARK: - FRIENDS
    
    func saveFriends(_ friends: [Friend], id: Int) {
        
        do {
            let realm = try Realm()
            let oldFriends = realm.objects(Friend.self).filter("id == %@", id)
            realm.beginWrite()
            realm.delete(oldFriends)
            realm.add(friends)
            try realm.commitWrite()
            print(realm.configuration.fileURL as Any)
        } catch {
            print(error)
        }
    }
    
    
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
                friends.forEach { $0.id = id }
                self.saveFriends(friends, id: id)
                completion(friends)
            
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
        // MARK: - GROUPS
    
    func saveGroups(_ groups: [Group], id: Int) {
        
        do {
            let realm = try Realm()
            let oldGroups = realm.objects(Group.self).filter("id == %@", id)
            realm.beginWrite()
            realm.delete(oldGroups)
            realm.add(groups)
            try realm.commitWrite()
            print(realm.configuration.fileURL as Any)
        } catch {
            print(error)
        }
    }
    
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
                groups.forEach { $0.id = id }
                self.saveGroups(groups, id: id)
                completion(groups)
            
            case .failure(let error):
                print(error)
            }
        }
    }
}

