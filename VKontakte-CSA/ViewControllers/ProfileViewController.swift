//
//  ProfileViewController.swift
//  VKontakte-CSA
//
//  Created by Ирина Семячкина on 21.06.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import UIKit
import Alamofire


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
    
    
    var user = UserResponse()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.updateUser()
    }
    
    
    func updateUser(){
        
        let session = URLSession.shared
        let url = URL(string: "https://api.vk.com/method/users.get?user_ids=\(Session.instance.userID)&fields=city,bdate,photo_200,status&access_token=\(Session.instance.token)&v=5.110")!
        
        let task = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print(error as Any)
                return
            }
            
            do {
                self.user = try JSONDecoder().decode(UserResponse.self, from: data!)
                print(self.user)
                DispatchQueue.main.async {
                    self.updateView()
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    
    func updateView() {
        let user = self.user.response[0]
        
        self.nameLabel?.text = user.first_name + " " + user.last_name
        self.statusLabel?.text = user.status
        self.bdLabel?.text = user.bdate
        self.locationLabel?.text = user.city.title
    }
}
