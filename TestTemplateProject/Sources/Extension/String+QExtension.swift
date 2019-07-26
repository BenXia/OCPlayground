//
//  String+Image.swift
//  QQingCommon
//
//  Created by zhouyihua on 24/05/2018.
//  Copyright © 2018 QQingiOSTeam. All rights reserved.
//

// MARK: - path

public extension String {
    
    var lastPathComponent: String {
        return (self as NSString).lastPathComponent
    }
    
    var pathExtension: String {
        return (self as NSString).pathExtension
    }
    
    var stringByDeletingLastPathComponent: String {
        return (self as NSString).deletingLastPathComponent
    }
    
    var stringByDeletingPathExtension: String {
        return (self as NSString).deletingPathExtension
    }
    
    var pathComponents: [String] {
        return (self as NSString).pathComponents
    }
    
    func stringByAppendingPathComponent(path: String) -> String {
        let nsSt = self as NSString
        return nsSt.appendingPathComponent(path)
    }
    
    func stringByAppendingPathExtension(ext: String) -> String? {
        let nsSt = self as NSString
        return nsSt.appendingPathExtension(ext)
    }
}

// MARK: - image

public extension String {
    
    /// 主工程图片
    var image: UIImage? {
        return UIImage.init(named: self)
    }
    
    /// 主工程图片
    var imageWithRenderingModeAlwaysTemplate: UIImage? {
        return UIImage.init(named: self)?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
    }

    /// 主工程图片
    var imageWithRenderingModeAlwaysOriginal: UIImage? {
        return UIImage.init(named: self)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    }
    
    /// 子工程图片
    var commonImage: UIImage? {
        let imagePath: String = Bundle.main.resourcePath?.stringByAppendingPathComponent(path: "QQingCommonBundle.bundle/\(self)") ?? ""
        return UIImage(contentsOfFile: imagePath)
    }
}
