//
//  GroupsTableViewController.swift
//  VKontakte-CSA
//
//  Created by Ирина Семячкина on 28.06.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import UIKit
import RealmSwift


class GroupsTableViewController: UITableViewController {
    
    
    private let vkService = VKService()
    private var groups: [Group] = []
    private var filteredGroups: [Group] = []
    private var id = 6492

    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 31/255, green: 37/255, blue: 63/255, alpha: 1)

        self.vkService.loadGroups(id: id) { [weak self] groups in
            
            self?.loadGroupsFromRealm()
            self?.filter(query: "")
            self?.tableView.reloadData()
        }
    }
    
    
    // MARK: - loadGroupsFromRealm
    
    private func loadGroupsFromRealm() {
        
        do {
            let realm = try Realm()
            let groups = realm.objects(Group.self).filter("id == %@", self.id)
            self.groups = Array(groups)
        } catch {
            print(error)
        }
    }
    
    
    // MARK: - filter
    
    private func filter(query: String) {
         self.filteredGroups.removeAll()
         
         for group in self.groups {
             var isInFilter = true
             
             if query.count > 0 {
                 isInFilter = group.name.lowercased().contains(query.lowercased())
             }
             
             if isInFilter {
                 self.filteredGroups.append(group)
             }
         }
         self.tableView.reloadData()
     }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredGroups.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTableViewCell", for: indexPath) as! GroupTableViewCell

        let group = self.filteredGroups[indexPath.row]
        cell.setGroup(group: group)
        cell.backgroundColor = .clear

        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}


    //MARK: - SearchBar Delegate

extension GroupsTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filter(query: searchText)
    }
}
