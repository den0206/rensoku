//
//  Extensions.swift
//  soku
//
//  Created by 酒井ゆうき on 2020/08/01.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import Foundation
import UIKit

public struct AnchoredConstraints {
    public var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}

 func verifyUrl (urlString: String?) -> Bool {
    if let urlString = urlString {
        if let url = NSURL(string: urlString) {
            return UIApplication.shared.canOpenURL(url as URL)
        }
    }
    return false
}

func createAttribute(person : Person) -> NSAttributedString {
    
    let personalColor : UIColor = person.sex == "Man" ? UIColor.systemBlue :UIColor.systemPink
    
    let personName = NSMutableAttributedString(string: person.name, attributes: [NSAttributedString.Key.foregroundColor : personalColor, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 24) ])
    
    if person.proffesion != "" {
        let subtitle = NSAttributedString(string: "  (\(person.proffesion))", attributes:  [NSAttributedString.Key.foregroundColor : personalColor])
        
        personName.append(subtitle)
    }
    
    return personName
}

extension String {
    
    func textToImage() -> UIImage? {
        let nsString = (self as NSString)
        let font = UIFont.systemFont(ofSize: 1024) // you can change your font size here
        let stringAttributes = [NSAttributedString.Key.font: font]
        let imageSize = nsString.size(withAttributes: stringAttributes)

        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0) //  begin image context
        UIColor.clear.set() // clear background
        UIRectFill(CGRect(origin: CGPoint(), size: imageSize)) // set rect size
        nsString.draw(at: CGPoint.zero, withAttributes: stringAttributes) // draw text within rect
        let image = UIGraphicsGetImageFromCurrentImageContext() // create image from context
        UIGraphicsEndImageContext() //  end image context

        return image ?? UIImage()
    }
}


extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                   right: NSLayoutXAxisAnchor? = nil,
                   paddingTop: CGFloat = 0,
                   paddingLeft: CGFloat = 0,
                   paddingBottom: CGFloat = 0,
                   paddingRight: CGFloat = 0,
                   width: CGFloat? = nil,
                   height: CGFloat? = nil) {
           
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func centerX(inView view : UIView, topAnchor : NSLayoutYAxisAnchor? = nil, paddingTop : CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if let topAnchor = topAnchor {
            self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop!).isActive = true
        }
    }
    
    func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil,
                 paddingLeft: CGFloat = 0, constant: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
        
        if let left = leftAnchor {
            anchor(left: left, paddingLeft: paddingLeft)
        }
    }
    
    func center(inView view : UIView, yConstant : CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant!).isActive = true
    }
    
    func setDimensions(height: CGFloat, width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    @discardableResult
    open func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> AnchoredConstraints {
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing, anchoredConstraints.width, anchoredConstraints.height].forEach{ $0?.isActive = true }
        
        return anchoredConstraints
    }
    
    @discardableResult
    open func fillSuperview(padding: UIEdgeInsets = .zero) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        let anchoredConstraints = AnchoredConstraints()
        guard let superviewTopAnchor = superview?.topAnchor,
            let superviewBottomAnchor = superview?.bottomAnchor,
            let superviewLeadingAnchor = superview?.leadingAnchor,
            let superviewTrailingAnchor = superview?.trailingAnchor else {
                return anchoredConstraints
        }
        
        return anchor(top: superviewTopAnchor, leading: superviewLeadingAnchor, bottom: superviewBottomAnchor, trailing: superviewTrailingAnchor, padding: padding)
    }
    
    @discardableResult
    open func fillSuperviewSafeAreaLayoutGuide(padding: UIEdgeInsets = .zero) -> AnchoredConstraints {
        let anchoredConstraints = AnchoredConstraints()
        if #available(iOS 11.0, *) {
            guard let superviewTopAnchor = superview?.safeAreaLayoutGuide.topAnchor,
                let superviewBottomAnchor = superview?.safeAreaLayoutGuide.bottomAnchor,
                let superviewLeadingAnchor = superview?.safeAreaLayoutGuide.leadingAnchor,
                let superviewTrailingAnchor = superview?.safeAreaLayoutGuide.trailingAnchor else {
                    return anchoredConstraints
            }
            return anchor(top: superviewTopAnchor, leading: superviewLeadingAnchor, bottom: superviewBottomAnchor, trailing: superviewTrailingAnchor, padding: padding)
            
        } else {
            return anchoredConstraints
        }
    }
    
    open func centerInSuperview(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
        
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    open func centerXToSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
    }
    
    open func centerYToSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
    }
    
    @discardableResult
    open func constrainHeight(_ constant: CGFloat) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        anchoredConstraints.height = heightAnchor.constraint(equalToConstant: constant)
        anchoredConstraints.height?.isActive = true
        return anchoredConstraints
    }
    
    @discardableResult
    open func constrainWidth(_ constant: CGFloat) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        anchoredConstraints.width = widthAnchor.constraint(equalToConstant: constant)
        anchoredConstraints.width?.isActive = true
        return anchoredConstraints
    }
    
    open func setupShadow(opacity: Float = 0, radius: CGFloat = 0, offset: CGSize = .zero, color: UIColor = .black) {
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
    }
    
    convenience public init(backgroundColor: UIColor = .clear) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
    }
}

extension UIViewController {
    
    
    func showErrorAlert(message : String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func showPresentLoadindView(_ present : Bool, message : String? = nil) {
        
        if present {
            
            let whiteView = UIView()
            whiteView.frame = self.view.bounds
            whiteView.backgroundColor = .white
            whiteView.alpha = 0
            whiteView.tag = 1
            
            let indicator = UIActivityIndicatorView()
            indicator.color = .white
            indicator.style = .large
            indicator.center = whiteView.center
            
            let label = UILabel()
            label.text = message
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = .white
            label.textAlignment = .center
            label.alpha = 0.7
            
            self.view.addSubview(whiteView)
            whiteView.addSubview(indicator)
            whiteView.addSubview(label)
            
            label.centerX(inView: view)
            label.anchor(top : indicator.bottomAnchor,paddingTop: 23)
            
            indicator.startAnimating()
            
            UIView.animate(withDuration: 0.2) {
                whiteView.alpha = 0.7
            }
            
            
        } else {
            
            // hide
            view.subviews.forEach { (subview) in
                
                if subview.tag == 1 {
                    UIView.animate(withDuration: 0.5, animations: {
                        subview.alpha = 0
                    }) { (_) in
                        subview.removeFromSuperview()
                    }
                }
            }
            
        }
    }
    
    func inputContainerView(withImage : UIImage, textField : UITextField? = nil) -> UIView {
        
        let view = UIView()
        
        let iv = UIImageView()
        iv.image = withImage
        iv.tintColor = .lightGray
        iv.alpha = 0.87
        view.addSubview(iv)
        
        if let textField = textField {
            iv.centerY(inView: view)
            iv.anchor(left : view.leftAnchor, paddingLeft: 8, width: 24, height: 24)
            
            view.addSubview(textField)
            textField.centerY(inView: view)
            textField.anchor(left : iv.rightAnchor, bottom:  view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, paddingBottom: 8)
        }
        
        let separatorVIew = UIView()
        separatorVIew.backgroundColor = .lightGray
        view.addSubview(separatorVIew)
        separatorVIew.anchor(left : view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, height: 0.75)
        
        return view
    }
    
    func createTextField(withPlaceholder : String, isSecureType : Bool) -> UITextField {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.textColor = .white
        tf.keyboardAppearance = .light
        tf.isSecureTextEntry = isSecureType
        tf.attributedPlaceholder = NSAttributedString(string: withPlaceholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        tf.autocapitalizationType = .none
        
        return tf
    }
    
    func createSexSegmentControl(selectedIndex : Int = 0, selectedColor : UIColor) -> UISegmentedControl {
        let sc = UISegmentedControl(items: ["Man", "Woman"])
        // 選択時の背景色
        if #available(iOS 13.0, *) {
            sc.selectedSegmentTintColor = selectedColor
        }
        else {
            sc.tintColor = selectedColor
        }
        sc.backgroundColor = .black
        // 文字色
        sc.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor:UIColor.white], for: .normal)
        // 枠線
        sc.layer.borderWidth = 2

        sc.layer.borderColor = UIColor.white.cgColor
        sc.selectedSegmentIndex = selectedIndex
        return sc
    }
}






func currentUID() -> String {
    if let uid = UserDefaults.standard.object(forKey: kCURRENTUID) as? String {
        return uid
    }
    
    return ""
}
