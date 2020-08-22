//
//  PersonDetailView.swift
//  soku
//
//  Created by 酒井ゆうき on 2020/08/20.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class PersonDetailView : UITableViewController  {
    
    let person : Person
    
    var couples = [Couple]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    //MARK: - Parts
    
    private lazy var headerView : UIView = {
        
        let header = UIView()
        header.backgroundColor = .black
        
        let pesronLabel = UILabel()
        pesronLabel.attributedText = createAttribute(person: person)
        header.addSubview(pesronLabel)
        pesronLabel.center(inView: header)
        
        return header
    }()
    
    init(peson : Person) {
        self.person = peson
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTV()
        
        fetchCouples()
        
    }
    
    //MARK: - UI
    
    private func configureTV() {
        
        tableView.backgroundColor = .black
        tableView.separatorColor = .white
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = 60
        tableView.register(CouplesCell.self, forCellReuseIdentifier: CouplesCell.identifier)
        
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 100)
        tableView.tableHeaderView = headerView
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = .systemGray
        
        headerView.addSubview(bottomLine)
        bottomLine.anchor(left : view.leftAnchor,bottom: headerView.bottomAnchor,right: view.rightAnchor,width: view.frame.width,height: 0.75)
        
        tableView.tableFooterView = UIView()

        
    }
    
    //MARK: - API
    
    private func fetchCouples() {
        CoupleService.fetchCoupleFromPeson(person: person) { (couples) in
            self.couples = couples
            
        }
    }
    
}

extension PersonDetailView {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return couples.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CouplesCell.identifier, for: indexPath) as! CouplesCell
        
        cell.type = .Person
        cell.couple = couples[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let couple = couples[indexPath.row]
        
        let detailVC = CoupleDetailViewController(couple: couple)
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    
}
