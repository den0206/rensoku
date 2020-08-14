//
//  CustomInputTextView.swift
//  soku
//
//  Created by 酒井ゆうき on 2020/08/14.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class CustomInputTextView : UITextView {
    
    //MARK: - Parts
    
    let placeholderLabel : UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
        
    }()
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        backgroundColor = .black
        font = UIFont.systemFont(ofSize: 16)
        textColor = .white
        isScrollEnabled = false
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        
        addSubview(placeholderLabel)
        placeholderLabel.anchor(top : topAnchor,left: leftAnchor,paddingTop: 8,paddingLeft: 8)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Action
    
    @objc func handleTextChange() {
        placeholderLabel.isHidden = !text.isEmpty
    }
}
