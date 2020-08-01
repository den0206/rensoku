//
//  DetailHeaderView.swift
//  soku
//
//  Created by 酒井ゆうき on 2020/08/01.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class DetailHeaderView : UIView {
    
    //MARK: - Parts
    
    private let manNameLabel : UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.text = "男の名前"
        return label
    }()
    
    private let subtitleManNameLabel : UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.text = "サブタイトル"
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
    
    private let womanNameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        
        label.textColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        label.textAlignment = .center
        
        label.text = "女の名前"
        return label
    }()
    
    private let subtitleWomanNameLabel : UILabel = {
          let label = UILabel()
           label.textColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
          label.font = UIFont.systemFont(ofSize: 14)
          label.textAlignment = .center
          label.text = "サブタイトル"
          return label
      }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI
    
    private func configureUI() {
        backgroundColor = .clear
        
        let stack = UIStackView(arrangedSubviews: [manNameLabel, heartImage,womanNameLabel])
        
        stack.axis = .vertical
        stack.spacing = 12
        stack.distribution = .fillEqually
        
        addSubview(stack)
        stack.fillSuperview()
        
        
//        stack.addSubview(subtitleManNameLabel)
//        subtitleManNameLabel.centerX(inView: manNameLabel)
//        subtitleManNameLabel.anchor(bottom : stack.arrangedSubviews[0].topAnchor, paddingBottom: 8)
//
//        stack.addSubview(subtitleWomanNameLabel)
//              subtitleWomanNameLabel.centerX(inView: womanNameLabel)
//              subtitleWomanNameLabel.anchor(bottom : stack.arrangedSubviews[2].topAnchor, paddingBottom: 8)
        

    }
}
