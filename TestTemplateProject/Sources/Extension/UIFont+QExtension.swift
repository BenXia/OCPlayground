//
//  UIFont+QExtension.swift
//  QQingCommon
//
//  Created by iOSZhouYihua on 2018/12/4.
//  Copyright © 2018 QQingiOSTeam. All rights reserved.
//

import Foundation

// MARK: - 返回不同粗细的字体

public extension UIFont {
    
    @discardableResult
    static func qSize(_ size: CGFloat) -> UIFont {
        
        return UIFont.systemFont(ofSize: size)
    }
    
    @discardableResult
    static func qMediumSize(_ size: CGFloat) -> UIFont {
        
        if #available(iOS 8.2, *) {
            return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.medium)
        } else {
            return UIFont.boldSystemFont(ofSize: size)
        }
    }
    
    @discardableResult
    static func qSemiboldSize(_ size: CGFloat) -> UIFont {
        
        if #available(iOS 8.2, *) {
            return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.semibold)
        } else {
            return UIFont.boldSystemFont(ofSize: size)
        }
    }
    
    @discardableResult
    static func qBoldSize(_ size: CGFloat) -> UIFont {
        
        return UIFont.boldSystemFont(ofSize: size)
    }
}
