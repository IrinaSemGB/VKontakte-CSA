//
//  ProfileViewController.swift
//  VKontakte-CSA
//
//  Created by Ирина Семячкина on 21.06.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift


class ProfileViewController: UIViewController {
    
    @IBOutlet private weak var photoImageView: UIImageView?
    @IBOutlet private weak var nameLabel: UILabel?
    @IBOutlet private weak var statusLabel: UILabel?
    @IBOutlet private weak var bdImageView: UIImageView?
    @IBOutlet private weak var bdHintLabel: UILabel?
    @IBOutlet private weak var bdLabel: UILabel?
    @IBOutlet private weak var locationImageView: UIImageView?
    @IBOutlet private weak var locationHintLabel: UILabel?
    @IBOutlet private weak var locationLabel: UILabel?
    
    
    let vkService = VKService()
    var user: [User] = []
    var id = Session.instance.userID
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.vkService.loadUser(id: id) { [weak self] users in
            self?.loadUserFromRealm()
            self?.updateView()
        }
    }
    
    
    func loadUserFromRealm() {
        
        do {
            let realm = try Realm()
            let user = realm.objects(User.self).filter("id == %@", self.id)
            self.user = Array(user)
        } catch {
            print(error)
        }
    }
    
    
    func updateView() {
        
        let user = self.user[0]
        
        self.nameLabel?.text = user.name + " " + user.lastName
        self.statusLabel?.text = user.status
        self.bdLabel?.text = user.birthDay
        self.locationLabel?.text = user.city
        
        if let photoURL = URL(string: user.photo) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: photoURL)
                if let data = data {
                    let photo = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.photoImageView?.image = photo
                    }
                }
            }
        }
    }
}
