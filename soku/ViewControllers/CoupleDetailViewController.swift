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
        
        chartView.delegate = self
        
        tableView.frame = CGRect(x: 0, y: 300, width: view.frame.width, height: view.frame.height)
        tableView.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .white
        tableView.tableHeaderView = chartView
        chartView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200)
        
        /// section1
        tableView.register(AddCommentCell.self, forCellReuseIdentifier: AddCommentCell.identifier)
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1 :
            return 20
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var commetCell : AddCommentCell!
        var cell : UITableViewCell!
        
        switch indexPath.section {
        case 0:
            commetCell = tableView.dequeueReusableCell(withIdentifier: AddCommentCell.identifier, for: indexPath) as? AddCommentCell
            
            commetCell.delegate = self
            return commetCell
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        }
        
      
        cell.backgroundColor = .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 150
        default:
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "新しいコメント"
        case 1 :
            return "Comments"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        view.tintColor = .black
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .white
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    
}

extension CoupleDetailViewController : AddCommentCellDelegate {
    
    func handleSend(text: String) {
        
        guard text != "" else {return}
        guard currentUID() != "" else {return}
        let commentId = UUID().uuidString
        
        let comment = Comment(id: commentId, text: text, date: Date(), userId: currentUID(), couple: couple)
        
        print(comment)
    }
    
    
    
}

extension CoupleDetailViewController : ChartsViewDelegate {
    func showLoadingView() {
        self.navigationController?.showPresentLoadindView(true)
    }
    
    func dismissLoadingView() {
        self.navigationController?.showPresentLoadindView(false)

    }
    
    
}

