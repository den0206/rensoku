//
//  CommentCell.swift
//  soku
//
//  Created by 酒井ゆうき on 2020/08/15.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class CommentCell : UITableViewCell {
    
    static let identifier = "CommentCell"
    
    var comment : Comment? {
        didSet {
            configureUI()
        }
    }
    
    let commentView : UITextView = {
        
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.isScrollEnabled = false
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isEditable = false
        tv.textColor = .white
        tv.text = "Test"
        
        return tv
        

    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .black
        selectionStyle = .none

        
        addSubview(commentView)
        
//        commentView.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        
        commentView.anchor(top : topAnchor,left:  leftAnchor,bottom: bottomAnchor,right: rightAnchor,paddingTop: 8,paddingLeft: 16, paddingBottom: 4, paddingRight: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Configure
    
    private func configureUI() {
        
        guard let comment = comment else {return}
        commentView.text = comment.text
        
    }
    
}
