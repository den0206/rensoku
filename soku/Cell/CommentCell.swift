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
    
    let commentLabel : UILabel = {
        let label = UILabel()
        label.text = "Comments"
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .black
        
        addSubview(commentLabel)
        commentLabel.anchor(top : topAnchor,left:  leftAnchor,bottom: bottomAnchor,right: rightAnchor,paddingTop: 16,paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Configure
    
    private func configureUI() {
        
        guard let comment = comment else {return}
        commentLabel.text = comment.text
        
    }
    
}
