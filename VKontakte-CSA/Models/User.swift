//
//  User.swift
//  VKontakte-CSA
//
//  Created by Ирина Семячкина on 21.06.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import Foundation

class User: Codable {
    
    var id: Int
    var first_name: String
    var last_name: String
    var bdate: String
    var status: String
    var photo_200: String
    var city: City
}

class City: Codable {
    var id: Int
    var title: String
}

class UserResponse: Codable {
    var response: [User] = []
}
