//
//  UIImage+QExtension.swift
//  QQingCommon
//
//  Created by iOSZhouYihua on 2018/12/4.
//  Copyright © 2018 QQingiOSTeam. All rights reserved.
//

import Foundation

// MARK: - 拉伸图片

public extension UIImage {
    
    @discardableResult
    /// 中间拉伸
    func qResizableImageCenter() -> UIImage {
        
        let imageSize: CGSize = self.size
        let centerPoint: CGPoint = CGPoint(x: imageSize.width / 2, y: imageSize.height / 2)
        return self.resizableImage(withCapInsets: UIEdgeInsets(top: centerPoint.y, left: centerPoint.x, bottom: centerPoint.y + 1, right: centerPoint.x + 1), resizingMode: UIImageResizingMode.stretch)
    }
    
    @discardableResult
    /// 顶部拉伸
    func qResizableImageTop() -> UIImage {
        
        let imageSize: CGSize = self.size
        let topPoint: CGPoint = CGPoint(x: imageSize.width / 2, y: 0)
        return self.resizableImage(withCapInsets: UIEdgeInsets(top: topPoint.y, left: topPoint.x, bottom: topPoint.y + 1, right: topPoint.x + 1), resizingMode: UIImageResizingMode.stretch)
    }
}
