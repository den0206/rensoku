//
//  SearchViewController.swift
//  soku
//
//  Created by 酒井ゆうき on 2020/08/19.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class SearchViewController : UITableViewController {
    
    //MARK: - Property
    
    var persons = [Person]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var filterPersons = [Person]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    
    //MARK: - Parts
    private lazy var sexSegmentController : UISegmentedControl = {
        let sc = UISegmentedControl(items: ["All", "男", "女"])
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(changeValue(_ :)), for: .valueChanged)
        return sc
    }()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTV()
        configureSearch()
        
        fetchPersons()
        
//        print(TextConverter.convert("酒井", to: .katakana))
    }
    
    //MARK: - UI
    
    private func configureTV() {
        
        navigationItem.title = "Search"
        
        tableView.backgroundColor = .black
        tableView.rowHeight = 60
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .systemGray
        
        sexSegmentController.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 45)
        
        tableView.tableHeaderView = sexSegmentController
        tableView.tableFooterView = UIView()
        
        tableView.register(PersonCell.self, forCellReuseIdentifier: PersonCell.identifier)
        
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
    private func configureSearch() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
    }
    //MARK: - API
    
    private func fetchPersons(filter : String? = nil) {
        
        CoupleService.fetchAllPerson(filter: filter) { (persons) in
            
            self.persons = persons
        }
    }
    
    //MARK: - Actions
    
    @objc func changeValue(_ sender : UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
            
        case 0:
            fetchPersons()
        case 1 :
            fetchPersons(filter: kMAN)
        case 2 :
            fetchPersons(filter: kWOMAN)
        default:
            return
        }
    }
    
}

//MARK: - UItableView Delegate

extension SearchViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.isActive && searchController.searchBar.text != "" {
            return filterPersons.count
        }
        
        return persons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonCell.identifier, for: indexPath) as! PersonCell
        
        var person : Person
        
        if searchController.isActive && searchController.searchBar.text != "" {
            person = filterPersons[indexPath.row]
        } else {
            person = persons[indexPath.row]
        }
        cell.person = person
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var person : Person
        
        if searchController.isActive && searchController.searchBar.text != "" {
            person = filterPersons[indexPath.row]
        } else {
            person = persons[indexPath.row]
        }
        
        
        
        let detailVC = PersonDetailView(peson: person)
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
}

extension SearchViewController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContextForSearchText(searchText: searchController.searchBar.text!)
    }
    
    private func filterContextForSearchText(searchText : String) {
        filterPersons = persons.filter({ (person) -> Bool in
            return person.name.lowercased().contains(searchText.lowercased())
        })
        
        print(filterPersons.count)
    }
    
    
}
