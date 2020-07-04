//
//  Group.swift
//  VKontakte-CSA
//
//  Created by Ирина Семячкина on 28.06.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Group: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var photo = ""
    @objc dynamic var screenName = ""
    
    required convenience init(json: JSON) {
        self.init()
        
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.photo = json["photo_200"].stringValue
        self.screenName = json["screen_name"].stringValue
    }
}
