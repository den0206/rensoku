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
    let chartView = ChartsView()
    
    let couple : Couple
    
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
    }
    
    //MARK: - UI
    
    private func configureUI() {
        
        view.addSubview(headerView)
        headerView.anchor(top : view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor, right: view.rightAnchor,width: view.frame.width,height: 200)
        
        


    }
    
    private func configureTV() {
        
        tableView.frame = CGRect(x: 0, y: 250, width: view.frame.width, height: view.frame.height)
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
