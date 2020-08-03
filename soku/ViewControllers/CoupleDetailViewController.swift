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
    
    var headerView = DetailHeaderView()
    let chartView = ChartsView()
    
   
    
    private var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        configureUI()
        configureTV()
    }
    
    //MARK: - UI
    
    private func configureUI() {
        
        view.addSubview(headerView)
        headerView.anchor(top : view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,right: view.rightAnchor,width: view.frame.width,height: 150)
        
        
    
//        view.addSubview(chartView)
//        chartView.anchor(top : headerView.bottomAnchor,left: view.leftAnchor, right: view.rightAnchor,width: view.frame.width,height: 200)

    }
    
    private func configureTV() {
        
        tableView.frame = CGRect(x: 0, y: 200, width: view.frame.width, height: view.frame.height)
        tableView.backgroundColor = .white
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = chartView
        chartView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        view.addSubview(tableView)
        
        
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
