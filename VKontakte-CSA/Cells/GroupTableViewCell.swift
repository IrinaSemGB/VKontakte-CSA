//
//  GroupTableViewCell.swift
//  VKontakte-CSA
//
//  Created by Ирина Семячкина on 28.06.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    @IBOutlet weak var groupImage: UIImageView?
    @IBOutlet weak var groupNameLabel: UILabel?
    @IBOutlet weak var groupScreennameLabel: UILabel?
    
    func setGroup(group: Group) {
        
        self.groupImage?.image = UIImage(named: group.photo)
        self.groupNameLabel?.text = group.name
        self.groupScreennameLabel?.text = group.screenName
    }
}