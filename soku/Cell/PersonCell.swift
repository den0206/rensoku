//
//  PersonCell.swift
//  soku
//
//  Created by 酒井ゆうき on 2020/08/19.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class PersonCell : UITableViewCell {
    
    static let identifier = "PersonCell"
    
    var person : Person? {
        didSet {
            configure()
        }
    }
    
    //MARK: - Parts
    
    private let personLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .black
        
        addSubview(personLabel)
        personLabel.centerY(inView: self)
        personLabel.anchor(left : leftAnchor,right: rightAnchor,paddingLeft: 16,paddingRight: 16)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI
    
    private func configure() {
        guard let person = person else {return}
        
        personLabel.attributedText = createAttribute(person: person)
        
        if person.sex == "Man" {
            personLabel.textColor = .systemBlue
        } else {
            personLabel.textColor = .systemPink
        }
    }

}
