//
//  Friend.swift
//  VKontakte-CSA
//
//  Created by Ирина Семячкина on 28.06.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Friend: Object  {
    
    @objc dynamic var id = 0
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var photo = ""
    @objc dynamic var online = 0
    
    required convenience init(json: JSON) {
        self.init()
        
        self.id = json["id"].intValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.photo = json["photo_200_orig"].stringValue
        self.online = json["online"].intValue
    }
}
