//
//  HomeViewController.swift
//  soku
//
//  Created by 酒井ゆうき on 2020/08/01.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit
import Charts

class CoupleDetailViewController : UIViewController {
    
    lazy var headerView = DetailHeaderView(couple: couple)
    lazy var chartView = ChartsView(couple: couple)
    
    let couple : Couple
    
    var voted = false
    
    private var tableView = UITableView()
    
    init(couple : Couple) {
        self.couple = couple
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        view.backgroundColor = .black
        configureUI()
        configureTV()
        
        checkVoted()
        
        
    }
    
    //MARK: - UI
    
    private func configureUI() {
        
        view.addSubview(headerView)
        headerView.anchor(top : view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor, right: view.rightAnchor,width: view.frame.width,height: 200)
        
        headerView.delegate = chartView
        


    }
    
    private func configureTV() {
        
        tableView.frame = CGRect(x: 0, y: 300, width: view.frame.width, height: view.frame.height)
        tableView.backgroundColor = .black
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = chartView
        chartView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        view.addSubview(tableView)
        
        
    }
    
    //MARK: - API
    
    private func checkVoted() {
        CoupleService.checkVoted(couple: couple) { (voted) in
            
            self.voted = voted
            self.headerView.voted = voted
            
            
        }
    }
}

extension CoupleDetailViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        return cell
    }
    
    
}
