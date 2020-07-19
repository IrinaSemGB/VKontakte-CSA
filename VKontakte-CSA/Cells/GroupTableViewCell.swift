//
//  GroupTableViewCell.swift
//  VKontakte-CSA
//
//  Created by Ирина Семячкина on 28.06.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {
    
    
    // MARK: - Outlets

    @IBOutlet private weak var groupImage: UIImageView? {
        didSet {
            groupImage?.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet private weak var groupNameLabel: UILabel? {
        didSet {
            groupNameLabel?.font = UIFont(name: "system", size: 23)
            groupNameLabel?.adjustsFontSizeToFitWidth = true
            groupNameLabel?.textColor = .white
        }
    }
    
    @IBOutlet private weak var groupScreennameLabel: UILabel? {
        didSet {
            groupScreennameLabel?.font = UIFont(name: "system", size: 16)
            groupScreennameLabel?.adjustsFontSizeToFitWidth = true
            groupScreennameLabel?.textColor = UIColor(red: 151/255, green: 157/255, blue: 189/255, alpha: 1)
        }
    }
    
    
    // MARK: - setGroup
    
    public func setGroup(group: Group) {
        
        self.groupImage?.image = UIImage(named: group.photo)
        self.groupNameLabel?.text = group.name
        self.groupScreennameLabel?.text = group.screenName
        
        if let photoURL = URL(string: group.photo) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: photoURL)
                if let data = data {
                    let photo = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.groupImage?.image = photo
                    }
                }
            }
        }
    }
}
