//
//  FriendTableViewCell.swift
//  VKontakte-CSA
//
//  Created by Ирина Семячкина on 28.06.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    @IBOutlet weak var photoFriendImage: UIImageView?
    @IBOutlet weak var nameFriendLabel: UILabel?
    @IBOutlet weak var onlineImage: UIImageView?
    
    func setFriends(friend: Friend) {
        
        self.photoFriendImage?.image = UIImage(named: friend.photo)
        self.nameFriendLabel?.text = friend.firstName + " " + friend.lastName
        
        if friend.online == 0 {
            self.onlineImage?.image = UIImage(systemName: "hand.raised.slash")
        } else {
            self.onlineImage?.image = UIImage(systemName: "hand.raised")
        }
    }
}
