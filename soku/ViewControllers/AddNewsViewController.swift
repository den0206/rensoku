//
//  addNewsViewController.swift
//  soku
//
//  Created by 酒井ゆうき on 2020/08/02.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class AddNewsViewController : UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNav()
        configureTV()
        
    }
    
    func configureNav() {
        
        navigationItem.title = "Add Item"
        
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "clear"), style: .plain, target: self, action: #selector(handleDismiss))
        closeButton.tintColor = .lightGray
        
        let doneButton = UIBarButtonItem(image: UIImage(systemName: "folder.fill.badge.plus"), style: .plain, target: self, action: #selector(handleDone))
        doneButton.tintColor = .lightGray
        
        navigationItem.leftBarButtonItem = closeButton
        navigationItem.rightBarButtonItem = doneButton
    }
    
    private func configureTV() {
        
        tableView.backgroundColor = .black
        tableView.rowHeight = 60
        tableView.register(AddNewsCell.self, forCellReuseIdentifier: AddNewsCell.identifier)
        
        
    }
    
    //MARK: - Actions
    
    @objc func handleDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleDone() {
        
    }
    
    
}

//MARK: - TableView Delegate

extension AddNewsViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return NewsSections.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = NewsSections(rawValue: section) else {return 1}
        
        switch section {
        case .url:
            return 1
        default:
            return 3
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AddNewsCell.identifier, for: indexPath) as! AddNewsCell
        
        guard let section = NewsSections(rawValue: indexPath.section) else {return cell }
        
        switch section {
        case .famous1,.famous2 :
            
            switch indexPath.row {
            case 0:
                cell.cellType = .SegmentVontroller
            default:
                break
            }
        default :
            break
        }
        
        cell.cellType = .InputField
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = NewsSections(rawValue: section) else {return ""}
        
        
        return section.title
    }
    
    
}
