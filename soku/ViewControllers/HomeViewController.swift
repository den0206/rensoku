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
    
    let actionButton : UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 45, weight: .regular, scale: .large)
        button.setImage(UIImage(systemName: "plus.circle", withConfiguration: largeConfig )?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.addTarget(self, action: #selector(handleTappedAddNews), for: .touchUpInside)
        
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confifureUI()
    }
    
    //MARK: - UI
    
    private func confifureUI() {
        
        view.backgroundColor = .black
        
        view.addSubview(actionButton)
        actionButton.anchor( top: view.safeAreaLayoutGuide.topAnchor, right: view.rightAnchor, paddingTop : 16, paddingRight: 16, width: 48, height: 48)

        view.addSubview(uidLabel)
        uidLabel.text = "\(uid!) さん"
        uidLabel.centerX(inView: self.view)
        uidLabel.anchor(bottom : view.safeAreaLayoutGuide.bottomAnchor,paddingBottom: 24)
        
    }
    
    //MARK: - Actions
    
    @objc func handleTappedAddNews() {
        
        let addVC = AddNewsViewController()
        let nav = UINavigationController(rootViewController: addVC)
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true, completion: nil)
    }
}
