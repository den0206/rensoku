//
//  CouplesCell.swift
//  soku
//
//  Created by 酒井ゆうき on 2020/08/08.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class CouplesCell : UITableViewCell {
    
    static let identifier = "CouplesCell"
    //MARK: - Parts
    
    private let person1Label : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        
        let attributeName = NSMutableAttributedString(string: "Man", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemBlue, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 24) ])
        
          let subtitle = NSAttributedString(string: "(職業)", attributes:  [NSAttributedString.Key.foregroundColor : UIColor.systemBlue ])
        
        attributeName.append(subtitle)
        
        
        label.attributedText = attributeName
        
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
    
    
    
    private let person2Label : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        
        let attributeName = NSMutableAttributedString(string: "WosMan", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemPink, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 24) ])
        
        label.attributedText = attributeName
        
        return label
      
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let selectedView = UIView()
        selectedView.backgroundColor = .blue
        selectedBackgroundView = selectedView
        
        backgroundColor = .black
        
        let stack = UIStackView(arrangedSubviews: [person1Label,heartImage, person2Label])
        
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fillProportionally
        
        addSubview(stack)
        stack.anchor(top: topAnchor,left: leftAnchor,bottom: bottomAnchor,right: rightAnchor,paddingTop: 16,paddingLeft: 16,paddingBottom: 16,paddingRight: 16)

        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
