//
//  Group.swift
//  VKontakte-CSA
//
//  Created by Ирина Семячкина on 28.06.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import Foundation
import SwiftyJSON

class Group {
    
    var name = ""
    var photo = ""
    var screenName = ""
    
    required convenience init(json: JSON) {
        self.init()
        
        self.name = json["name"].stringValue
        self.photo = json["photo_200"].stringValue
        self.screenName = json["screen_name"].stringValue
    }
}
