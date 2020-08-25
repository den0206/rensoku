//
//  exAddNewsViewController.swift
//  soku
//
//  Created by 酒井ゆうき on 2020/08/02.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class AddCoupleViewController : UIViewController {
    //MARK: - Property
    
    var relationUrl : String?
    
    //MARK: - Parts
    
    private let person_1Label : UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 10))
        label.text = "1人目"
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    /// fam1
    private lazy var person_1SexSegmentController : UISegmentedControl = {
        let sc = createSexSegmentControl(selectedColor: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1))
        sc.tag = 0
        sc.addTarget(self, action: #selector(indexChanged(_ :)), for: .valueChanged)
        return sc

    }()
    
    private lazy var person_1NameContainerView : UIView = {
        
        return inputContainerView(withImage: UIImage(systemName: "person")!, textField: person_1NameTextField)
    }()
    
    private lazy var person_1NameTextField : UITextField = {
        
        return createTextField(withPlaceholder: "名前", isSecureType: false)
    }()
    
    private lazy var person_1ProffesionContainerView : UIView = {
        
        return inputContainerView(withImage: UIImage(systemName: "wrench")!, textField: person_1ProfessionTextField)
    }()
    
    private lazy var person_1ProfessionTextField : UITextField = {
        
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
    
    private let person_2Label : UILabel = {
           let label = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 10))
           label.text = "2人目"
           label.textColor = .lightGray
           label.font = UIFont.boldSystemFont(ofSize: 16)
           return label
    }()
    
    private lazy var person_2SexSegmentController : UISegmentedControl = {
       
        let sc =  createSexSegmentControl(selectedIndex: 1, selectedColor: .systemPink)
        
        sc.tag = 1
        sc.addTarget(self, action: #selector(indexChanged(_ :)), for: .valueChanged)
        return sc
    }()
    
    private lazy var person_2NameContainerView : UIView = {
        
        return inputContainerView(withImage: UIImage(systemName: "person")!, textField: person_2NameTextField)
    }()
    
    private lazy var person_2NameTextField : UITextField = {
        
        return createTextField(withPlaceholder: "名前", isSecureType: false)
    }()
    
    private lazy var person_2ProffesionContainerView : UIView = {
        
        return inputContainerView(withImage: UIImage(systemName: "wrench")!, textField: person_2ProfessionTextField)
    }()
    
    private lazy var person_2ProfessionTextField : UITextField = {
        
        return createTextField(withPlaceholder: "サブタイトル", isSecureType: false)
    }()
    
    private lazy var relationUrlContainerView : UIView = {
           
           return inputContainerView(withImage: UIImage(systemName: "link")!, textField: relationUrlTextField)
       }()
       
       private lazy var relationUrlTextField : UITextField = {
           
           return createTextField(withPlaceholder: "関連URL", isSecureType: false)
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
        closeButton.tintColor = .black
        
        let doneButton = UIBarButtonItem(image: UIImage(systemName: "folder.fill.badge.plus"), style: .plain, target: self, action: #selector(handleSave))
        doneButton.tintColor = .lightGray
        doneButton.isEnabled = false
        
        navigationItem.leftBarButtonItem = closeButton
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func configureUI() {
        
//        let fam1Arrays = [fam1Label, fam1SexSegmentController,fam1NameContainerView, fam1ProffesionContainerView]
//
//        let fam2Arrays = [fam2Label, fam2SexSegmentController,fam2NameContainerView, fam1ProffesionContainerView]
//
        
        let stack = UIStackView(arrangedSubviews: [person_1Label, person_1SexSegmentController,person_1NameContainerView, person_1ProffesionContainerView, heartImage,  person_2Label, person_2SexSegmentController,person_2NameContainerView, person_2ProffesionContainerView,relationUrlContainerView])
        
        person_1NameTextField.delegate = self

        person_2NameTextField.delegate = self
        
        
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 16
        
        view.addSubview(stack)
        //        stack.centerY(inView: view, constant: 40)
        stack.anchor(top : view.safeAreaLayoutGuide.topAnchor, left : view.leftAnchor,  right: view.rightAnchor,paddingTop: 20,paddingLeft: 16,paddingRight: 16)
        
        saveButton.widthAnchor.constraint(equalToConstant: 100).isActive = true

    }
    
    //MARK: - Actions
    
    @objc func handleDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleSave() {
       
        guard person_1NameTextField.text != "" && person_2NameTextField.text != "" else {
            self.showErrorAlert(message: "両方の名前は埋めてください")
            return
        }
        
        if relationUrlTextField.text != "" {
            if verifyUrl(urlString: relationUrlTextField.text) {
                self.relationUrl = relationUrlTextField.text!
            } else {
                self.showErrorAlert(message: "URLが無効です")
                return
            }

        }
        
        
        guard let name1 = person_1NameTextField.text else {return}
        guard let name2 = person_2NameTextField.text else {return}

        
        
        guard let sex1 = person_1SexSegmentController.titleForSegment(at: person_1SexSegmentController.selectedSegmentIndex) else {return}

         guard let sex2 = person_2SexSegmentController.titleForSegment(at: person_2SexSegmentController.selectedSegmentIndex) else {return}

        self.navigationController?.showPresentLoadindView(true)

        let profession1 = person_1ProfessionTextField.text ?? ""
        let profession2 = person_2ProfessionTextField.text ?? ""

        let coupleID = UUID().uuidString
        let userID = currentUID()



        let person1 = Person(name: name1, proffesion: profession1, sex: sex1)
        let person2 = Person(name: name2, proffesion: profession2, sex: sex2)


        let couple = Couple(coupleId: coupleID, userId: userID, person_1: person1, person_2: person2, urlString: nil, date: Date())

        Service.saveCouple(couple: couple, relationUrl: relationUrl) { (error) in
            self.dismiss(animated: true, completion: {
                self.navigationController?.showPresentLoadindView(false)

            })
        }

        
        
    }
    
  
    
}

extension AddCoupleViewController : UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if person_1NameTextField.text != "" && person_2NameTextField.text != "" {
            navigationItem.rightBarButtonItem?.tintColor = .blue
            navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            navigationItem.rightBarButtonItem?.tintColor = .lightGray
            navigationItem.rightBarButtonItem?.isEnabled = false


        }
    }
}

//MARK: - helpers

extension AddCoupleViewController {
    
    @objc func indexChanged(_ sender : UISegmentedControl) {
         if sender.tag == 0 {
             switch sender.selectedSegmentIndex {
             case 0:
                 
                 if #available(iOS 13.0, *) {
                     person_1SexSegmentController.selectedSegmentTintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
                 }
                 else {
                     person_1SexSegmentController.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
                 }
                 
             case 1 :
                 if #available(iOS 13.0, *) {
                     person_1SexSegmentController.selectedSegmentTintColor = .systemPink
                 }
                 else {
                     person_1SexSegmentController.tintColor = .systemPink
                 }
             default:
                 return
             }
         } else {
             switch sender.selectedSegmentIndex {
             case 0:
                 
                 if #available(iOS 13.0, *) {
                     person_2SexSegmentController.selectedSegmentTintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
                 }
                 else {
                     person_2SexSegmentController.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
                 }
                 
             case 1 :
                 if #available(iOS 13.0, *) {
                     person_2SexSegmentController.selectedSegmentTintColor = .systemPink
                 }
                 else {
                     person_2SexSegmentController.tintColor = .systemPink
                 }
             default:
                 return
             }
         }
        
     }
    
}
