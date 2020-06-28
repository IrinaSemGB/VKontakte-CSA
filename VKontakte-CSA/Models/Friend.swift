//
//  Friend.swift
//  VKontakte-CSA
//
//  Created by Ирина Семячкина on 28.06.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import Foundation
import SwiftyJSON

class Friend  {
    
    var firstName = ""
    var lastName = ""
    var photo = ""
    var online = 0
    
    required convenience init(json: JSON) {
        self.init()
        
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.photo = json["photo_200_orig"].stringValue
        self.online = json["online"].intValue
    }
}
