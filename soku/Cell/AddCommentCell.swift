//
//  AddCommentCell.swift
//  soku
//
//  Created by 酒井ゆうき on 2020/08/14.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

protocol AddCommentCellDelegate : class {
    func handleSend(text : String)
}

class AddCommentCell : UITableViewCell, UITextViewDelegate {
    
    static let identifier = "AddCommentCell"
    
    weak var delegate : AddCommentCellDelegate?
    
    let commentTextView : CustomInputTextView = {
        let tv = CustomInputTextView()
        tv.placeholderLabel.text = "コメント"
        return tv
    }()
    
    lazy var sendButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.backgroundColor = .lightGray
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        button.setDimensions(height: 25, width: 100)
        button.clipsToBounds = true
        button.layer.cornerRadius = 13 / 2
        return button
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .black
        selectionStyle = .none
        
        commentTextView.delegate = self
        addSubview(commentTextView)
        commentTextView.anchor(top :topAnchor,left: leftAnchor,right: rightAnchor,paddingTop: 8,paddingLeft: 14,paddingRight: 14, height: 100)
        
        addSubview(sendButton)
        sendButton.anchor(top : commentTextView.bottomAnchor,bottom: bottomAnchor,right: rightAnchor,paddingTop: 8,paddingBottom: 4,paddingRight: 14)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc func handleSend() {
        
        guard let text = commentTextView.text else {return}
        
        delegate?.handleSend(text: text)
    }
    
    //MARK: - UITextView delegate
    
    func textViewDidChange(_ textView: UITextView) {
        
        if textView.text != "" {
            sendButton.backgroundColor = .blue
            sendButton.isEnabled = true
        } else {
            sendButton.backgroundColor = .lightGray
            sendButton.isEnabled = false
        }
    }
    
}


