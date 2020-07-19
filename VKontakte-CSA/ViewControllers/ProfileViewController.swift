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
    
    
    // MARK: - Outlets
    
    @IBOutlet private weak var profileView: UIView? {
        didSet {
            profileView?.backgroundColor = UIColor(red: 60/255, green: 65/255, blue: 99/255, alpha: 1)
            profileView?.layer.cornerRadius = 10
        }
    }
    @IBOutlet private weak var photoImageView: UIImageView? {
        didSet {
            photoImageView?.contentMode = .scaleAspectFit
            photoImageView?.layer.cornerRadius = 100
            photoImageView?.layer.borderColor = UIColor(red: 151/255, green: 157/255, blue: 189/255, alpha: 1).cgColor
            photoImageView?.layer.borderWidth = 10
        }
    }
    @IBOutlet private weak var nameLabel: UILabel? {
        didSet {
            nameLabel?.textColor = .white
            nameLabel?.font = UIFont(name: "Didot", size: 28)
        }
    }
    @IBOutlet private weak var statusLabel: UILabel? {
        didSet {
            statusLabel?.textColor = UIColor(red: 151/255, green: 157/255, blue: 189/255, alpha: 1)
            statusLabel?.font = UIFont(name: "Didot", size: 18)
        }
    }
    
    @IBOutlet private weak var bdView: UIView? {
        didSet {
            bdView?.backgroundColor = UIColor(red: 60/255, green: 65/255, blue: 99/255, alpha: 1)
        }
    }
    @IBOutlet private weak var redColorLine: UIView? {
        didSet {
            redColorLine?.backgroundColor = UIColor(red: 216/255, green: 79/255, blue: 63/255, alpha: 1)
        }
    }
    @IBOutlet private weak var bdImageView: UIImageView? {
        didSet {
            bdImageView?.image = UIImage(systemName: "gift")
            bdImageView?.tintColor = UIColor(red: 151/255, green: 157/255, blue: 189/255, alpha: 1)
        }
    }
    @IBOutlet private weak var bdHintLabel: UILabel? {
        didSet {
            bdHintLabel?.text = "день рождения"
            bdHintLabel?.font = UIFont(name: "Didot", size: 13)
            bdHintLabel?.textColor = UIColor(red: 151/255, green: 157/255, blue: 189/255, alpha: 1)
            bdHintLabel?.adjustsFontSizeToFitWidth = true
        }
    }
    @IBOutlet private weak var bdLabel: UILabel? {
        didSet {
            bdLabel?.font = UIFont(name: "Didot", size: 22)
            bdLabel?.textColor = .white
            bdLabel?.adjustsFontSizeToFitWidth = true
        }
    }
    
    @IBOutlet private weak var locationView: UIView? {
        didSet {
            locationView?.backgroundColor = UIColor(red: 60/255, green: 65/255, blue: 99/255, alpha: 1)
        }
    }
    @IBOutlet private weak var blueColorLine: UIView? {
        didSet {
            blueColorLine?.backgroundColor = UIColor(red: 65/255, green: 164/255, blue: 171/255, alpha: 1)
        }
    }
    @IBOutlet private weak var locationImageView: UIImageView? {
        didSet {
            locationImageView?.image = UIImage(systemName: "location")
            locationImageView?.tintColor = UIColor(red: 151/255, green: 157/255, blue: 189/255, alpha: 1)
        }
    }
    @IBOutlet private weak var locationHintLabel: UILabel? {
        didSet {
            locationHintLabel?.text = "местоположение"
            locationHintLabel?.font = UIFont(name: "Didot", size: 13)
            locationHintLabel?.textColor = UIColor(red: 151/255, green: 157/255, blue: 189/255, alpha: 1)
            locationHintLabel?.adjustsFontSizeToFitWidth = true
        }
    }
    @IBOutlet private weak var locationLabel: UILabel? {
        didSet {
            locationLabel?.font = UIFont(name: "Didot", size: 22)
            locationLabel?.textColor = .white
            locationLabel?.adjustsFontSizeToFitWidth = true
        }
    }
    
    
    @IBOutlet private weak var logoutView: UIView? {
        didSet {
            logoutView?.backgroundColor = UIColor(red: 60/255, green: 65/255, blue: 99/255, alpha: 1)
        }
    }
    @IBOutlet private weak var yellowColorLine: UIView? {
        didSet {
            yellowColorLine?.backgroundColor = UIColor(red: 237/255, green: 186/255, blue: 105/255, alpha: 1)
        }
    }
    @IBOutlet private weak var logoutImage: UIImageView? {
        didSet {
            logoutImage?.image = UIImage(systemName: "hand.point.left")
            logoutImage?.tintColor = UIColor(red: 151/255, green: 157/255, blue: 189/255, alpha: 1)
        }
    }
    @IBOutlet private weak var logoutButton: UIButton? {
        didSet {
            logoutButton?.setTitle("Выйти из профиля", for: .normal)
            logoutButton?.setTitleColor(UIColor(red: 151/255, green: 157/255, blue: 189/255, alpha: 1), for: .normal)
            logoutButton?.titleLabel?.font = UIFont(name: "Didot", size: 22)
            logoutButton?.contentHorizontalAlignment = .left
        }
    }
    
    
    private let vkService = VKService()
    private var user: [User] = []
    private var id = Session.instance.userID
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 31/255, green: 37/255, blue: 63/255, alpha: 1)
    
        self.vkService.loadUser(id: id) { [weak self] users in
            self?.loadUserFromRealm()
            self?.updateView()
        }
    }
    
    
    // MARK: - Load data from Realm
    
    private func loadUserFromRealm() {
        
        do {
            let realm = try Realm()
            let user = realm.objects(User.self).filter("id == %@", self.id)
            self.user = Array(user)
        } catch {
            print(error)
        }
    }
    
    
    // MARK: - Update
    
    private func updateView() {
        
        guard let user = self.user.first else {return}
        
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
