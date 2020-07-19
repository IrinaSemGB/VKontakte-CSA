//
//  TabBarViewController.swift
//  VKontakte-CSA
//
//  Created by Ирина Семячкина on 18.07.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import UIKit


class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.isTranslucent = true
        tabBar.alpha = 0.9
        
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = UIColor(red: 151/255, green: 157/255, blue: 189/255, alpha: 1)
        
        tabBar.barTintColor = .clear
        tabBar.barStyle = .default
    }
}
