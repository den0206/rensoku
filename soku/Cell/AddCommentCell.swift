//
//  AddCommentCell.swift
//  soku
//
//  Created by 酒井ゆうき on 2020/08/14.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class AddCommentCell : UITableViewCell {
    
    static let identifier = "AddCommentCell"
    
    let commentTextView : CustomInputTextView = {
        let tv = CustomInputTextView()
        tv.placeholderLabel.text = "コメント"
        return tv
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .black
        
        addSubview(commentTextView)
        commentTextView.anchor(top :topAnchor,left: leftAnchor,bottom: bottomAnchor,right: rightAnchor,paddingTop: 8,paddingLeft: 14,paddingRight: 14)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
