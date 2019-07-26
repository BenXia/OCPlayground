//
//  UIView+SnapKit.swift
//  QQingCommon
//
//  Created by zhouyihua on 22/05/2018.
//  Copyright © 2018 QQingiOSTeam. All rights reserved.
//

// MARK: - safeArea
import UIKit;
import Foundation;
import SnapKit;
import ReactiveSwift;
import ReactiveCocoa;

public extension UIView {

    var safeAreaSnp: ConstraintBasicAttributesDSL {

        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        }
        return self.snp
    }
}

// MARK: - make constraint

public extension UIView {
    
    @discardableResult
    func qSnpMakeConstraints(_ closure: (_ make: ConstraintMaker) -> Void) -> UIView {
        
        self.snp.makeConstraints(closure)
        return self
    }
    
    @discardableResult
    func qSnpRemakeConstraints(_ closure: (_ make: ConstraintMaker) -> Void) -> UIView {
        
        self.snp.remakeConstraints(closure)
        return self
    }
    
    @discardableResult
    func qSnpUpdateConstraints(_ closure: (_ make: ConstraintMaker) -> Void) -> UIView {
        
        self.snp.updateConstraints(closure)
        return self
    }
}
