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
    }
    
    func configureNav() {
        
        //        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.lightGray]
        navigationItem.title = "Add Item"
        
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "clear"), style: .plain, target: self, action: #selector(handleDismiss))
        closeButton.tintColor = .lightGray
        
        let doneButton = UIBarButtonItem(image: UIImage(systemName: "folder.fill.badge.plus"), style: .plain, target: self, action: #selector(handleDone))
        doneButton.tintColor = .lightGray
        
        navigationItem.leftBarButtonItem = closeButton
        navigationItem.rightBarButtonItem = doneButton
    }
    
    //MARK: - Actions
    
    @objc func handleDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleDone() {
        
    }
    
    
}
