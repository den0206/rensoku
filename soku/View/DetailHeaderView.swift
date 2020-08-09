//
//  DetailHeaderView.swift
//  soku
//
//  Created by 酒井ゆうき on 2020/08/01.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class DetailHeaderView : UIView {
    
    let couple : Couple
    
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
        button.setTitle("お気に入り", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 35 / 2
        button.backgroundColor = .systemPink
//        button.layer.borderWidth = 2
//        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    let unLikeButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ショック", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 35 / 2
        button.backgroundColor = .systemBlue
//        button.layer.borderWidth = 2
//        button.layer.borderColor = UIColor.white.cgColor
        
        return button
    }()

    
    init(couple : Couple) {
        self.couple = couple
        super.init(frame: .zero)
        
        print(couple)
        backgroundColor = .clear
        
        let buttonStack = UIStackView(arrangedSubviews: [unLikeButton,LikeButton])
        buttonStack.axis = .horizontal
        buttonStack.spacing = 36
        buttonStack.distribution = .fillEqually
       
        let stack = UIStackView(arrangedSubviews: [manNameLabel, heartImage,womanNameLabel, buttonStack])
        
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
    

}
