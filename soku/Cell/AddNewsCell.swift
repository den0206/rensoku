//
//  AddNewsCell.swift
//  soku
//
//  Created by 酒井ゆうき on 2020/08/02.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

enum newsCellType  {
    case InputField
    case SegmentVontroller
}

class AddNewsCell: UITableViewCell {
    
    static let identifier = "AddnewsCell"
    
    var cellType : newsCellType? {
        didSet {
            connfigureUI()
        }
    }

//
//    let titleLabel : UILabel = {
//        let label = UILabel()
//        label.text = "名前:"
//        label.font = UIFont.systemFont(ofSize: 16)
//
//        return label
//    }()
    
    private let  inputField : UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 16)
        
        let paddingView = UIView()
        paddingView.setDimensions(height: 50, width: 20)
        tf.leftView = paddingView
        tf.leftViewMode = .always
        
        tf.placeholder = "名前"
        
        return tf
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none

    }
    
    //MARK: - UI
    
    private func connfigureUI() {
        guard let type = cellType else {return}
        
        switch type {
        case .SegmentVontroller :
            backgroundColor = .black
        default:
            
            addSubview(inputField)
            
            inputField.anchor(top :topAnchor,left: leftAnchor,bottom: bottomAnchor,right: rightAnchor,paddingTop: 8,paddingLeft: 14,paddingRight: 14)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
