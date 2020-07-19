//
//  FriendTableViewCell.swift
//  VKontakte-CSA
//
//  Created by Ирина Семячкина on 28.06.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import UIKit


class FriendTableViewCell: UITableViewCell {
    

    // MARK: - Outlets
    
    @IBOutlet private weak var shadowView: UIView? {
        didSet {
            shadowView?.backgroundColor = .clear
            shadowView?.layer.shadowOffset = .zero
            shadowView?.layer.shadowOpacity = 0.4
            shadowView?.layer.shadowRadius = 6
            shadowView?.layer.shadowColor = UIColor.lightGray.cgColor
        }
    }
    
    @IBOutlet private weak var photoFriendImage: UIImageView? {
        didSet {
            photoFriendImage?.contentMode = .scaleAspectFit
            photoFriendImage?.layer.cornerRadius = (photoFriendImage?.frame.width ?? 80) / 2
            photoFriendImage?.layer.borderColor = UIColor.white.cgColor
            photoFriendImage?.layer.borderWidth = 1
        }
    }
    
    @IBOutlet private weak var nameFriendLabel: UILabel? {
        didSet {
            nameFriendLabel?.textColor = .white
            nameFriendLabel?.font = UIFont(name: "Optima", size: 18)
        }
    }
    
    @IBOutlet private weak var onlineImage: UIImageView? {
        didSet {
            onlineImage?.tintColor = UIColor(red: 151/255, green: 157/255, blue: 189/255, alpha: 1)
            onlineImage?.alpha = 0.8
        }
    }
    
    @IBOutlet private weak var onlineLabel: UILabel? {
        didSet {
            onlineLabel?.textColor = UIColor(red: 151/255, green: 157/255, blue: 189/255, alpha: 1)
            onlineLabel?.font = UIFont(name: "Optima", size: 10)
            onlineLabel?.contentMode = .center
        }
    }
    
    
    // MARK: - setFriends
    
    public func setFriends(friend: Friend) {
        
        self.photoFriendImage?.image = UIImage(named: friend.photo)
        self.nameFriendLabel?.text = friend.firstName + " " + friend.lastName
        
        if friend.online == 0 {
            self.onlineImage?.image = UIImage(systemName: "hand.raised")
            self.onlineLabel?.text = "ONLINE"
        } else {
            self.onlineImage?.image = UIImage(systemName: "hand.raised.slash")
            self.onlineLabel?.text = "OFFLINE"
        }
        
        if let photoURL = URL(string: friend.photo) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: photoURL)
                if let data = data {
                    let photo = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.photoFriendImage?.image = photo
                    }
                }
            }
        }
    }
}
