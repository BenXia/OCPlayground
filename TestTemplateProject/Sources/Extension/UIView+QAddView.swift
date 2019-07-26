//
//  UIView+QAddView.swift
//  QQingCommon
//
//  Created by zhouyihua on 24/05/2018.
//  Copyright © 2018 QQingiOSTeam. All rights reserved.
//

import SnapKit

extension UIView {
    
    // MARK: view
    
    @discardableResult
    public func qAddView(backgroundColor: UIColor? = nil, clipsToBounds: Bool = false) -> UIView {
        
        let view: UIView = UIView()
        view.backgroundColor = backgroundColor ?? self.backgroundColor
        view.clipsToBounds = clipsToBounds
        self.addSubview(view)
        return view
    }
    
    // MARK: line
    
    @discardableResult
    /// - Parameters:
    ///   - lastView: priority higher than top
    public func qAddLine(backgroundColor: UIColor? = UIColor.gray, top: Bool = false, left: Double = 0, right: Double = 0, height: Double = 1, lastView: UIView? = nil) -> UIView {
        
        let line: UIView = self.qAddView(backgroundColor: backgroundColor)
        line.snp.makeConstraints { (make) in
            
            if let lastView = lastView {
                make.top.equalTo(lastView.snp.bottom)
            } else {
                if top {
                    make.top.equalToSuperview()
                } else {
                    make.bottom.equalToSuperview()
                }
            }
            make.left.equalTo(left);
            make.right.equalTo(-right);
            make.height.equalTo(height);
        }
        return line
    }
    
    // MARK: label
    
    @discardableResult
    public func qAddLabel(
        text: String? = nil,
        attrText: NSAttributedString? = nil,
        font: UIFont? = nil,
        textColor: UIColor? = nil,
        
        textAlignment: NSTextAlignment = .left,
        numberOfLines: Int = 1,
        adjustsFontSizeToFitWidth: Bool = false,
        
        backgroundColor: UIColor? = nil
        ) -> UILabel {
        
        let label: UILabel = UILabel()
        label.text = text
        label.font = font
        label.textColor = textColor
        
        label.textAlignment = textAlignment
        label.numberOfLines = numberOfLines
        label.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        
        label.backgroundColor = backgroundColor ?? self.backgroundColor
        
        /// attrText 会被上面的属性覆盖，所以放在最后赋值
        if let attrText = attrText {
            label.attributedText = attrText
        }
        self.addSubview(label)
        return label
    }
    
    // MARK: imageView
    
    @discardableResult
    public func qAddImageView(image: UIImage? = nil, contentMode: UIViewContentMode? = .scaleAspectFit, backgroundColor: UIColor? = nil) -> UIImageView {
        
        let imageView: UIImageView = UIImageView()
        imageView.image = image
        imageView.backgroundColor = backgroundColor ?? self.backgroundColor
        imageView.contentMode = contentMode!
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        self.addSubview(imageView)
        return imageView
    }
    
    // MARK: button
    
    @discardableResult
    public func qAddButton(handler: (() -> Void)? = nil) -> UIButton {
        
        let button: UIButton = UIButton()
        if let handler = handler {
            button.bindAction({
                handler()
            })
        }
        self.addSubview(button)
        return button
    }
}

extension UIView {
    
    // MARK: addSubview
    
    @discardableResult
    public func qAddSubView<T: UIView>(_ view: T) -> T {
        
        self.addSubview(view)
        return view
    }
    
    // MARK: set lastView
    
//    @discardableResult
    public func qSetBottom(offset: CGFloat = 0, priority: ConstraintPriority = .required) {
        
        self.snp.makeConstraints { (make) in
            make.bottom.equalTo(-offset).priority(priority)
        }
    }
}
