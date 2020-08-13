//
//  DetailHeaderView.swift
//  soku
//
//  Created by 酒井ゆうき on 2020/08/01.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

protocol DetailHeaderViewDelegate : class {
    func handleLike(header : DetailHeaderView, couple : Couple)
    func handleUnlike(header : DetailHeaderView, couple : Couple)

}

class DetailHeaderView : UIView {
    
    let couple : Couple
    
    var voted = false {
        didSet {
            if voted {
                disableButton()
            } else {
                buttonStack.isHidden = false
            }
        }
    }
    
    weak var delegate : DetailHeaderViewDelegate?
    
    //MARK: - Parts
    
    private lazy var manNameLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.attributedText = createAttribute(person: couple.person1)
        return label
        
        
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
    
    private lazy var womanNameLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center

        label.attributedText = createAttribute(person: couple.person2)
        return label
    }()
    
    let LikeButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("お似合い", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 35 / 2
        button.backgroundColor = .systemPink
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        return button
    }()
    
    let unLikeButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ショック", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 35 / 2
        button.backgroundColor = .systemBlue
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(handleUnlike), for: .touchUpInside)
        
        return button
    }()
    
    lazy var buttonStack = UIStackView(arrangedSubviews: [unLikeButton,LikeButton])
   
    
    lazy var stack = UIStackView(arrangedSubviews: [manNameLabel, heartImage,womanNameLabel, buttonStack])

    
    init(couple : Couple) {
        self.couple = couple
        super.init(frame: .zero)
        
        backgroundColor = .clear
        
        buttonStack.axis = .horizontal
        buttonStack.spacing = 36
        buttonStack.distribution = .fillEqually
        buttonStack.isHidden = true
       

        stack.axis = .vertical
        stack.spacing = 12
        stack.distribution = .fillProportionally
        
        addSubview(stack)
        buttonStack.heightAnchor.constraint(equalToConstant: 35).isActive = true
        buttonStack.anchor(left : leftAnchor,right: rightAnchor,paddingLeft: 24,paddingRight: 24)
               
        stack.fillSuperview()
        
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI
    
    func disableButton() {
        buttonStack.isHidden = true
//
//        [LikeButton,unLikeButton].forEach { (button) in
//            button.alpha = 0.4
//            button.isEnabled = false
//        }
    }
    
    //MARK: - Actions
    
    @objc func handleLike() {
        
        delegate?.handleLike(header: self, couple: couple)
    }
    
    @objc func handleUnlike() {
        delegate?.handleUnlike(header: self, couple: couple)
    }
    

}
