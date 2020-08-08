//
//  CouplesViewController.swift
//  soku
//
//  Created by 酒井ゆうき on 2020/08/04.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class CouplesViewController : UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTV()
    }
    
    //MARK: - Parts
    
    private func configureTV() {
        
        view.backgroundColor = .black
        
        tableView.separatorColor = .white
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = 200
        tableView.register(CouplesCell.self, forCellReuseIdentifier: CouplesCell.identifier)
        
        
    }
}


//MARK: - tableview ddelegate

extension CouplesViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CouplesCell.identifier, for: indexPath) as! CouplesCell
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

