//
//  User.swift
//  VKontakte-CSA
//
//  Created by Ирина Семячкина on 21.06.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class User: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var lastName: String  = ""
    @objc dynamic var birthDay: String  = ""
    @objc dynamic var status: String  = ""
    @objc dynamic var photo: String  = ""
    @objc dynamic var city: String  = ""
    
    required convenience init(json: JSON) {
        self.init()
        
        self.id = json["id"].intValue
        self.name = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.birthDay = json["bdate"].stringValue
        self.status = json["status"].stringValue
        self.photo = json["photo_200"].stringValue
        self.city = json["city"]["title"].stringValue
    }
}




