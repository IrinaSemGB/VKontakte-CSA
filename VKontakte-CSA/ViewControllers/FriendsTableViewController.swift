//
//  FriendsTableViewController.swift
//  VKontakte-CSA
//
//  Created by Ирина Семячкина on 28.06.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import UIKit
import RealmSwift


class FriendsTableViewController: UITableViewController {
    
    
    private let vkService = VKService()
    private var friends: [Friend] = []
    private var id = 6492
    var friendsInSections: [String : [Friend]] = [:]
    private var sections: [String] = []
    

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 31/255, green: 37/255, blue: 63/255, alpha: 1)

        self.vkService.loadFriends(id: id) { [weak self] friends in
            
            self?.loadFriendsFromRealm()
            self?.fillSections()
            self?.reloadFriends()
            self?.tableView.reloadData()
        }
    }
    
    
    // MARK: - loadFriendsFromRealm
    
    private func loadFriendsFromRealm() {
        do {
            let realm = try Realm()
            let friends = realm.objects(Friend.self).filter("id == %@", self.id)
            self.friends = Array(friends)
        } catch {
            print(error)
        }
    }
    
    
    // MARK: - fillSections
    
    private func fillSections() {
        self.sections.removeAll()
        
        let aScalars = "A".unicodeScalars
        let aCode = aScalars[aScalars.startIndex].value
        
        if let unicode = UnicodeScalar(aCode) {
            let letter = Character(unicode)
            self.sections.append(String(letter))
        }
        
        for _ in 0..<31 {
            guard let lastSymbol = self.sections.last else {
                continue
            }
            
            let lastUnicode = lastSymbol.unicodeScalars
            let code = lastUnicode[lastUnicode.startIndex].value
            
            guard let unicode = UnicodeScalar(code + 1) else {
                continue
            }
            
            let letter = Character(unicode)
            self.sections.append(String(letter))
        }
    }
    
    
    // MARK: - reloadFriends
    
    private func reloadFriends() {
        self.friendsInSections.removeAll()
        
        for friend in self.friends {
            
            guard let firstLetter = friend.firstName.first else {
                continue
            }
            
            var friends: [Friend] = []
            
            if let friendsInSections = self.friendsInSections[String(firstLetter)] {
                friends.append(contentsOf: friendsInSections)
            }
            
            friends.append(friend)
            self.friendsInSections[String(firstLetter)] = friends
        }
        
        self.tableView.reloadData()
    }

    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sectionName: String = self.sections[section]
        if let friendsInSection: [Friend] = self.friendsInSections[sectionName] {
            return friendsInSection.count
        }
        return 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendTableViewCell", for: indexPath) as! FriendTableViewCell

        let sectionName: String = self.sections[indexPath.section]
        if let friendsInSection: [Friend] = self.friendsInSections[sectionName] {
            let friend = friendsInSection[indexPath.row]
            cell.setFriends(friend: friend)
        }
        cell.backgroundColor = .clear

        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = self.sections[section]
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .clear
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionName: String = self.sections[section]
        
        if let friendsInSections: [Friend] = self.friendsInSections[sectionName],
            friendsInSections.count > 0 {
            return 20
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
