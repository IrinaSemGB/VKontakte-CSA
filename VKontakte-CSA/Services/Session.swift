//
//  Session.swift
//  VKontakte-CSA
//
//  Created by Ирина Семячкина on 12.06.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import Foundation

class Session {
    
    static let instance = Session()
    
    private init() {}
    
    var token: String = ""
    var userID: Int = 0
}
