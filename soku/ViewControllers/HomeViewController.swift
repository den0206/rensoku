//
//  HomeViewController.swift
//  soku
//
//  Created by 酒井ゆうき on 2020/08/01.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class HomeViewController : UIViewController {
    
    var uid : String?
    
    //MARK: - parts
    
    private let uidLabel : UILabel = {
        let label = UILabel()
        label.text = "UID"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(currentUID())
        confifureUI()
    }
    
    //MARK: - UI
    
    private func confifureUI() {
        
        view.backgroundColor = .black

        view.addSubview(uidLabel)
        uidLabel.text = "\(uid!) さん"
        uidLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,right: view.rightAnchor,paddingTop: 16,paddingRight: 16)
        
    }

}
