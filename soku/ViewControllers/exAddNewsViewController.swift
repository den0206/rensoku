//
//  exAddNewsViewController.swift
//  soku
//
//  Created by 酒井ゆうき on 2020/08/02.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class exAddNewsViewController : UIViewController {
    
    
    private let fam1Label : UILabel = {
        let label = UILabel()
        label.text = "一人目"
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    /// fam1
    private lazy var fam1SexSegmentController : UISegmentedControl = {

        return createSexSegmentControl(selectedColor: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1))

    }()
    
    private lazy var fam1NameContainerView : UIView = {
        
        return inputContainerView(withImage: UIImage(systemName: "person")!, textField: fam1NameTextField)
    }()
    
    private lazy var fam1NameTextField : UITextField = {
        
        return createTextField(withPlaceholder: "名前", isSecureType: false)
    }()
    
    private lazy var fam1ProffesionContainerView : UIView = {
        
        return inputContainerView(withImage: UIImage(systemName: "wrench")!, textField: fam1ProfessionTextField)
    }()
    
    private lazy var fam1ProfessionTextField : UITextField = {
        
        return createTextField(withPlaceholder: "サブタイトル", isSecureType: false)
    }()
    
   private let heartImage : UIImageView = {
       let iv = UIImageView()
       iv.contentMode = .scaleAspectFit
       iv.setDimensions(height: 40, width: 40)
       
       let image = UIImage(systemName: "suit.heart.fill")?.withRenderingMode(.alwaysTemplate)
       iv.image = image
       iv.tintColor = .red
       return iv
   }()
    
    /// fam2
    
    private let fam2Label : UILabel = {
           let label = UILabel()
           label.text = "2人目"
           label.textColor = .lightGray
           label.font = UIFont.boldSystemFont(ofSize: 16)
           return label
    }()
    
    private lazy var fam2SexSegmentController : UISegmentedControl = {
       
        return createSexSegmentControl(selectedIndex: 1, selectedColor: .systemPink)
    }()
    
    private lazy var fam2NameContainerView : UIView = {
        
        return inputContainerView(withImage: UIImage(systemName: "person")!, textField: fam2NameTextField)
    }()
    
    private lazy var fam2NameTextField : UITextField = {
        
        return createTextField(withPlaceholder: "名前", isSecureType: false)
    }()
    
    private lazy var fam2ProffesionContainerView : UIView = {
        
        return inputContainerView(withImage: UIImage(systemName: "wrench")!, textField: fam2ProfessionTextField)
    }()
    
    private lazy var fam2ProfessionTextField : UITextField = {
        
        return createTextField(withPlaceholder: "サブタイトル", isSecureType: false)
    }()
    
    private let saveButton : UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .lightGray
        button.setTitle("追加する", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNav()
        configureUI()
        
    }
    
    func configureNav() {
        
        navigationItem.title = "Add Item"
        
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "clear"), style: .plain, target: self, action: #selector(handleDismiss))
        closeButton.tintColor = .lightGray
        
        let doneButton = UIBarButtonItem(image: UIImage(systemName: "folder.fill.badge.plus"), style: .plain, target: self, action: #selector(handleSave))
        doneButton.tintColor = .lightGray
        
        navigationItem.leftBarButtonItem = closeButton
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func configureUI() {
        
//        let fam1Arrays = [fam1Label, fam1SexSegmentController,fam1NameContainerView, fam1ProffesionContainerView]
//
//        let fam2Arrays = [fam2Label, fam2SexSegmentController,fam2NameContainerView, fam1ProffesionContainerView]
//
        
        let stack = UIStackView(arrangedSubviews: [fam1Label, fam1SexSegmentController,fam1NameContainerView, fam1ProffesionContainerView, heartImage,fam2Label, fam2SexSegmentController,fam2NameContainerView, fam2ProffesionContainerView,saveButton])
        
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 16
        
        view.addSubview(stack)
        //        stack.centerY(inView: view, constant: 40)
        stack.anchor(top : view.safeAreaLayoutGuide.topAnchor, left : view.leftAnchor, right: view.rightAnchor,paddingTop: 20,paddingLeft: 16,paddingRight: 16)
        
        saveButton.widthAnchor.constraint(equalToConstant: 100).isActive = true

    }
    
    //MARK: - Actions
    
    @objc func handleDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleSave() {
        print("Save")
    }
    
}
