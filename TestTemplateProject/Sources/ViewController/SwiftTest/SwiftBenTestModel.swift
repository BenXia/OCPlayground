//
//  SwiftBenTestModel.swift
//  teacher
//
//  Created by Ben on 2019/6/24.
//

import UIKit

@objc(SwiftBenTestModel) class SwiftBenTestModel : NSObject {
    @objc var qingqingWhateverId: String = ""
    @objc var adjusted: Bool = false
    @objc var startTime: Int64 = 0
    @objc var endTime: Int64 = 0
    
    override var description: String {
        return "================================\n" +
               "qingqingWhateverId: \(qingqingWhateverId)\n" +
               "adjusted: \(adjusted)\n" +
               "startTime: \(startTime)\n" +
               "endTime: \(endTime)\n" +
              "================================\n"
    }
}


