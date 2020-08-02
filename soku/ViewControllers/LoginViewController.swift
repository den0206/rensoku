//
//  LoginViewController.swift
//  soku
//
//  Created by 酒井ゆうき on 2020/08/02.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class LoginViewController : UIViewController{
    
    //MARK: - Parts
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.font = UIFont(name: "Avenir-Light", size: 36)
        label.textColor = .white
        return label
    }()
    
    private lazy var nameTextField : UITextField = {
        let tf = UITextField()
        tf.borderStyle = .line
        
        tf.backgroundColor = .white
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.textColor = .black
        tf.keyboardAppearance = .light
        tf.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        tf.autocapitalizationType = .none
        tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tf.layer.cornerRadius = 13 / 2
        tf.addTarget(self, action: #selector(editingChange(_ :)), for: .editingChanged)
        tf.clipsToBounds = true
        
        return tf
    }()
    
    private let loginButton : UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        button.setTitle("匿名ログイン", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.isEnabled = true
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        
    }
    
    //MARK: - UI
    private func configureUI() {
        
        view.addSubview(titleLabel)
        titleLabel.centerX(inView: view)
        titleLabel.anchor(top : view.safeAreaLayoutGuide.topAnchor,paddingTop: 40)
        
        let stack = UIStackView(arrangedSubviews: [loginButton])
        stack.axis = .vertical
        stack.spacing = 40
        stack.distribution = .fillProportionally
        
        view.addSubview(stack)
        
        stack.centerY(inView: view)
        stack.anchor(left : view.leftAnchor,right: view.rightAnchor,paddingLeft: 40,paddingRight: 40)
        
   
        
        
    }
    
    //MARK: - Action
    
    @objc func handleLogin() {
        
        Service.anonymousLogin { (error) in
            if error != nil {
                self.showErrorAlert(message: error!.localizedDescription)
                return
            }
            
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
                
            }
        }
        
        
    }
    
    @objc func editingChange(_ sender : UITextField) {
        if sender.text != "" {
            loginButton.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            loginButton.isEnabled = true
        } else {
            loginButton.backgroundColor = .lightGray
            loginButton.isEnabled = false
            
        }
    }
    



}
