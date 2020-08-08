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
    
    var lastDocument : DocumentSnapshot?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTV()
        
        fetchCouples()
    }
    
    //MARK: - Parts
    
    private func configureTV() {
        
        view.backgroundColor = .black
        
        tableView.separatorColor = .white
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = 200
        tableView.register(CouplesCell.self, forCellReuseIdentifier: CouplesCell.identifier)
        
        
    }
    
    //MARK: - API
    
    private func fetchCouples() {
        
        self.navigationController?.showPresentLoadindView(true)
        
        CoupleService.fetchCouples(firstLoad: true, limit: 5, lastDocument: nil) { (couples, error, lastDocument) in
            
            if error != nil {
                self.navigationController?.showPresentLoadindView(false)
                self.showErrorAlert(message: error!.localizedDescription)
                return
            }
            
            self.lastDocument = lastDocument
            self.couples = couples
            
            self.navigationController?.showPresentLoadindView(false)
            print(self.lastDocument)
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
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

