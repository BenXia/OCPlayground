//
//  Array+QExtension.swift
//  QQingCommon
//
//  Created by iOSZhouYihua on 2018/7/10.
//  Copyright © 2018 QQingiOSTeam. All rights reserved.
//

import UIKit
import SnapKit

// MARK: - distribute views

public extension Array {
    
    enum QAxisType {
        case horizontal
        case vertical
    }
    
    func qDistributeViews(alongAxis axisType: QAxisType, fixedItemLength: Double, leadSpacing: Double, tailSpacing: Double) {
        
        guard self.count >= 2 else {
            print("views to distribute need to bigger than one")
            return
        }
        
        guard let `self` = self as? [UIView] else {
            print("array need to be views array")
            return
        }
        
        guard let tempSuperView = self.first?.superview else {
            print("views array should have superview")
            return
        }
        
        if axisType == .horizontal {
            
            var prev: UIView! = nil
            for i in 0..<self.count {
                
                let v: UIView = self[i]
                v.snp.makeConstraints({ (make) in
                    make.width.equalTo(fixedItemLength)
                    if prev != nil {
                        if (i == self.count - 1) {//last one
                            make.right.equalTo(tempSuperView).offset(-tailSpacing)
                        }
                        else {
                            let offset: Double = (1-(Double(i)/Double(self.count-1)))*(fixedItemLength+leadSpacing)-Double(i)*tailSpacing/(Double(self.count-1))
                            
                            make.right.equalTo(tempSuperView).multipliedBy(Double(i)/Double(self.count-1)).offset(offset)
                        }
                    }
                    else {//first one
                        make.left.equalTo(tempSuperView).offset(leadSpacing)
                    }
                })
                prev = v
            }
        }
        else {
            var prev: UIView! = nil
            for i in 0..<self.count {
                
                let v: UIView = self[i]
                v.snp.makeConstraints({ (make) in
                    make.height.equalTo(fixedItemLength)
                    if prev != nil {
                        if (i == self.count - 1) {//last one
                            make.bottom.equalTo(tempSuperView).offset(-tailSpacing)
                        }
                        else {
                            let offset: Double = (1-(Double(i)/Double(self.count-1)))*(fixedItemLength+leadSpacing)-Double(i)*tailSpacing/(Double(self.count-1))
                            
                            make.bottom.equalTo(tempSuperView).multipliedBy(Double(i)/Double(self.count-1)).offset(offset)
                        }
                    }
                    else {//first one
                        make.top.equalTo(tempSuperView).offset(leadSpacing)
                    }
                })
                prev = v
            }
        }
    }
    
    func qDistributeViews(alongAxis axisType: QAxisType, fixedSpacing: Double, leadSpacing: Double, tailSpacing: Double) {
        
        guard self.count >= 2 else {
            print("views to distribute need to bigger than one")
            return
        }
        
        guard let `self` = self as? [UIView] else {
            print("array need to be views array")
            return
        }
        
        guard let tempSuperView = self.first?.superview else {
            print("views array should have superview")
            return
        }
        
        if axisType == .horizontal {
            
            var prev: UIView! = nil
            for i in 0..<self.count {
                
                let v: UIView = self[i]
                v.snp.makeConstraints({ (make) in
                    if prev != nil {
                        make.width.equalTo(prev)
                        make.left.equalTo(prev.snp.right).offset(fixedSpacing);
                        if (i == self.count - 1) {//last one
                            make.right.equalTo(tempSuperView).offset(-tailSpacing);
                        }
                    }
                    else {//first one
                        make.left.equalTo(tempSuperView).offset(leadSpacing)
                    }
                })
                prev = v
            }
        }
        else {
            var prev: UIView! = nil
            for i in 0..<self.count {
                
                let v: UIView = self[i]
                v.snp.makeConstraints({ (make) in
                    if prev != nil {
                        make.height.equalTo(prev);
                        make.top.equalTo(prev.snp.bottom).offset(fixedSpacing);
                        if (i == self.count - 1) {//last one
                            make.bottom.equalTo(tempSuperView).offset(-tailSpacing);
                        }
                    }
                    else {//first one
                        make.top.equalTo(tempSuperView).offset(leadSpacing)
                    }
                })
                prev = v
            }
        }
    }
}

// MARK: - snapkit

public extension Array {
    
    func qSnpMakeConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
        
        for item in self {
            if let view: UIView = item as? UIView {
                view.snp.makeConstraints(closure)
            }
        }
    }
}

// MARK: - safe

public extension Array {
    
    func objectAtIndex(_ index: Int) -> Element? {
        
        if 0 <= index, index < self.count {
            return self[index]
        }
        return nil
    }
}
