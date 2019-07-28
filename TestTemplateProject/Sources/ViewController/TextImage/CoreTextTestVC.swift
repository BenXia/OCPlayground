//
//  CoreTextTestVC.swift
//  TestTemplateProject
//
//  Created by Ben on 2019/7/26.
//  Copyright © 2019 iOSStudio. All rights reserved.
//

import UIKit
import SnapKit

class CoreTextTestVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.initUI()
    }
    
    func initUI() {
        let backView: UIView = self.view
        var lastView: UIView! = nil
        
        backView.removeAllSubviews()
        
        // MARK: 时间要求
        self.addBlankView(to: backView, height: 20, lastView: &lastView)

        self.addTitleAndExpandableMultiLineContentView(to: backView, titleText: "时间要求", contentText: "中国日报网7月26日电（刁云娇）今年以来，我国各项宏观调控政策有序实施效应持续显现，减税降费效应不断释放。7月23日，国家税务总局公布的数据显示，2019年上半年，全国累计新增减税降费11709亿元，已完成全年减税降费2万亿元任务目标的58.5%。实打实的减税降费，让企业和人民得到了“真金白银”的实惠。上半年减税降费成效如何？通过下面一图看懂。", defaultLine: 2, lastView: &lastView)
    }
    
    /// 添加空白行
    ///
    /// - Parameters:
    ///   - lastView: 内部会修改值
    func addBlankView(to backView: UIView, height: Double, color: UIColor? = nil, lastView: inout UIView!) {
        
        let backView: UIView = backView.qAddView(backgroundColor: color ?? self.view.backgroundColor)
        backView.snp.makeConstraints({ (make) in
            make.top.equalTo(lastView?.snp.bottom ?? 0)
            make.left.right.equalToSuperview()
            make.height.equalTo(height)
        })
        
        lastView = backView
    }
    
    /// 添加标题和多行文本（带展开按钮，默认收起）
    ///
    /// - Parameters:
    ///   - lastView: 内部会修改值
    ///   - defaultLine: 默认显示行数
    func addTitleAndExpandableMultiLineContentView(to backView: UIView, titleText: String, contentText: String, defaultLine: Int, lastView: inout UIView!) {
        
        guard defaultLine > 0 else { return }
        
        let backView: UIView = backView.qAddView(clipsToBounds: true)
        backView.snp.makeConstraints({ (make) in
            make.top.equalTo(lastView?.snp.bottom ?? 0)
            make.left.right.equalToSuperview()
            //            make.height.equalTo(50)
        })
        
        /// 标题
        lastView = backView.qAddLabel(text: titleText, font: UIFont.qSize(15), textColor: UIColor.gray)
            .qSnpMakeConstraints { (make) in
                make.left.equalTo(13)
                make.top.equalToSuperview()
                make.height.equalTo(21)
        }
        
        /// 内容
        do {
            /// 内容的边距
            let contentViewInset: UIEdgeInsets = UIEdgeInsetsMake(0, 98, 0, 13)
            
            /// 用于计算文本显示
            let tempLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: SwiftUtility.kScreenWidth_ - contentViewInset.left - contentViewInset.right - 5, height: 0))
            tempLabel.text = contentText
            tempLabel.font = UIFont.qSize(15)
            
            let textArray: [String] = self.getLinesArrayOfString(in: tempLabel)
            
            /// 超过指定行数，显示展开按钮
            if textArray.count > defaultLine {
                
                /// 全部文字
                do {
                    let backView: UIView = backView
                        .qAddView(clipsToBounds: true)
                        .qSnpMakeConstraints { (make) in
                            make.edges.equalTo(contentViewInset)
                    }
                    
                    lastView = nil
                    
                    for index in 1 ... textArray.count {
                        lastView = backView.qAddLabel(text: textArray.objectAtIndex(index - 1), font: UIFont.qSize(15), textColor: UIColor.darkGray)
                            .qSnpMakeConstraints { (make) in
                                make.top.equalTo(lastView?.snp.bottom ?? 0)
                                make.left.right.equalToSuperview()
                                make.height.equalTo(21)
                        }
                    }
                    
                    lastView.qSetBottom(priority: .high)
                }
                
                /// 前几行文字 和 展开按钮
                do {
                    let backView: UIView = backView
                        .qAddView(clipsToBounds: true)
                        .qSnpMakeConstraints { (make) in
                            make.edges.equalTo(contentViewInset)
                    }
                    
                    lastView = nil
                    
                    /// 前几行显示全部
                    if defaultLine > 1 {
                        
                        for index in 1 ..< defaultLine {
                            lastView = backView.qAddLabel(text: textArray.objectAtIndex(index - 1), font: UIFont.qSize(15), textColor: UIColor.darkGray)
                                .qSnpMakeConstraints { (make) in
                                    make.top.equalTo(lastView?.snp.bottom ?? 0)
                                    make.left.right.equalToSuperview()
                                    make.height.equalTo(21)
                            }
                        }
                    }
                    
                    /// 最后一行要显示文字和按钮
                    do {
                        lastView = backView.qAddLabel(text: textArray.objectAtIndex(defaultLine - 1), font: UIFont.qSize(15), textColor: UIColor.darkGray)
                            .qSnpMakeConstraints { (make) in
                                make.top.equalTo(lastView?.snp.bottom ?? 0)
                                make.left.equalToSuperview()
                                make.right.lessThanOrEqualTo(-70)
                                make.height.equalTo(21)
                        }
                        let lastLineLabel: UILabel = (lastView as! UILabel)
                        
                        /// 这个 view 用来空出底部距离
                        var hideContentViewConstraint: Constraint! = nil
                        lastView = backView.qAddView()
                            .qSnpMakeConstraints { (make) in
                                make.top.equalTo(lastView?.snp.bottom ?? 0)
                                make.left.right.equalToSuperview()
                                hideContentViewConstraint = make.height.equalTo(0).constraint
                        }
                        
                        /// 按钮文字
                        backView.qAddLabel(text: "展开", font: UIFont.qSize(15), textColor: UIColor.orange)
                            .qSnpMakeConstraints { (make) in
                                make.centerY.equalTo(lastLineLabel)
                                make.right.equalTo(-27)
                        }
                        
                        /// 按钮箭头
                        backView
                            .qAddImageView(image: "icon_fsyb_zhankai".image, contentMode: UIViewContentMode.scaleAspectFill)
                            .qSnpMakeConstraints { (make) in
                                make.centerY.equalTo(lastLineLabel)
                                make.right.equalTo(-13)
                                make.size.equalTo(CGSize(width: 13, height: 13))
                        }
                        
                        /// 点击 事件
                        backView
                            .qAddButton(handler: { /*[weak self] in
                                 guard let `self` = self else { return }*/
                                
                                hideContentViewConstraint.deactivate()
                                backView.isHidden = true
                            })
                            .qSnpMakeConstraints { (make) in
                                make.edges.equalToSuperview()
                        }
                    }
                    
                    lastView.qSetBottom()
                }
            }
                /// 如果不超过指定行数
            else {
                /// 内容
                lastView = backView.qAddLabel(text: contentText, font: UIFont.qSize(15), textColor: UIColor.darkGray, numberOfLines: 0)
                    .qSnpMakeConstraints { (make) in
                        make.edges.equalTo(contentViewInset)
                        make.height.greaterThanOrEqualTo(21)
                }
            }
        }
        
        lastView = backView
    }
    
    /*
     获取 label 的每行文本
     https://stackoverflow.com/questions/4421267/how-to-get-text-string-from-nth-line-of-uilabel/14413484#14413484（How to get text / String from nth line of UILabel?）
     */
    func getLinesArrayOfString(in label: UILabel) -> [String] {
        
        /// An empty string's array
        var linesArray = [String]()
        
        guard let text = label.text, let font = label.font else {return linesArray}
        
        let rect = label.frame
        
        let myFont: CTFont = CTFontCreateWithName(font.fontName as CFString, font.pointSize, nil)
        let attStr = NSMutableAttributedString(string: text)
        attStr.addAttribute(kCTFontAttributeName as NSAttributedString.Key, value: myFont, range: NSRange(location: 0, length: attStr.length))
        
        let frameSetter: CTFramesetter = CTFramesetterCreateWithAttributedString(attStr as CFAttributedString)
        let path: CGMutablePath = CGMutablePath()
        path.addRect(CGRect(x: 0, y: 0, width: rect.size.width, height: 100000), transform: .identity)
        
        let frame: CTFrame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, nil)
        guard let lines = CTFrameGetLines(frame) as? [Any] else {return linesArray}
        
        for line in lines {
            let lineRef = line as! CTLine
            let lineRange: CFRange = CTLineGetStringRange(lineRef)
            let range = NSRange(location: lineRange.location, length: lineRange.length)
            let lineString: String = (text as NSString).substring(with: range)
            linesArray.append(lineString)
        }
        return linesArray
    }
}


