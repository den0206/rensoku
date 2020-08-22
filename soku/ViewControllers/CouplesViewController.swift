//
//  CouplesViewController.swift
//  soku
//
//  Created by 酒井ゆうき on 2020/08/04.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit
import FirebaseFirestore

class CouplesViewController : UITableViewController {
    
    //MARK: - Property
    
    var couples = [Couple]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    let refreshController = UIRefreshControl()
    
    var lastDocument : DocumentSnapshot?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTV()
        
        fetchCouples()
    }
    
    //MARK: - Parts
    
    private func configureTV() {
        
        view.backgroundColor = .black
        
        tableView.refreshControl = refreshController
        refreshController.tintColor = .white
        refreshController.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        
        tableView.delaysContentTouches = true
        tableView.separatorColor = .white
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = 200
        tableView.register(CouplesCell.self, forCellReuseIdentifier: CouplesCell.identifier)
        
        tableView.tableFooterView = UIView()
        
        
    }
    
    //MARK: - Actions
    
    @objc func handleRefresh() {
        
        self.couples.removeAll(keepingCapacity: false)
        
        refreshController.beginRefreshing()
        fetchCouples()
    }
    
    //MARK: - API
    
    private func fetchCouples() {
        
        self.navigationController?.showPresentLoadindView(true)
        
        
        CoupleService.fetchCouples(firstLoad: true, limit: 5, lastDocument: nil) { (couples, error, lastDocument) in
            
            if error != nil {
                self.refreshController.endRefreshing()

                self.navigationController?.showPresentLoadindView(false)
                self.showErrorAlert(message: error!.localizedDescription)
                
                return
            }
            
            self.lastDocument = lastDocument
            self.couples = couples
            
            self.refreshController.endRefreshing()

            self.navigationController?.showPresentLoadindView(false)
        }
    }
    
    /// padination
    private func fetchMoreCouples() {
        guard let lastDoc = lastDocument else {return}
        
        CoupleService.fetchCouples(firstLoad: false, limit: 5, lastDocument: lastDoc) { (moreCouples, error, lastDocument) in
            if error != nil {
                
                self.navigationController?.showPresentLoadindView(false)
                self.showErrorAlert(message: error!.localizedDescription)
                
                return
            }
            
            self.lastDocument = lastDocument
            self.couples.append(contentsOf: moreCouples)
            
            
            self.navigationController?.showPresentLoadindView(false)
        }
    }
}


//MARK: - tableview ddelegate

extension CouplesViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return couples.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CouplesCell.identifier, for: indexPath) as! CouplesCell
        
        cell.type = .All
        cell.couple = couples[indexPath.row]
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let couple = couples[indexPath.row]
        
        let detailVC = CoupleDetailViewController(couple: couple)
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    /// pagination
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
       
        if couples.count >= 5 && indexPath.row == (self.couples.count - 2) {
             print("Call")
            fetchMoreCouples()
        }
    }
}

