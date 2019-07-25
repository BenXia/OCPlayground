//
//  TextViewTestVC.swift
//  TestTemplateProject
//
//  Created by Ben on 2019/7/26.
//  Copyright © 2019 iOSStudio. All rights reserved.
//

import Foundation
import UIKit

@objc(TextViewTestVC) class TextViewTestVC: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = UIBezierPath(rect: CGRect(x: 200, y: 5 * 20 - 1, width: textView.frame.size.width - 200, height: 20))
        textView.textContainer.exclusionPaths = [path]
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        textView.textContainer.maximumNumberOfLines = 5
        textView.textContainer.lineBreakMode = NSLineBreakMode.byTruncatingTail
    }
    
    @IBAction func hide(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            textView.textContainer.maximumNumberOfLines = 0
            textView.textContainer.exclusionPaths = []
        } else {
            textView.textContainer.maximumNumberOfLines = 5
            let path = UIBezierPath(rect: CGRect(x: 200, y: 5 * 20 - 1, width: textView.frame.size.width - 200, height: 20))
            textView.textContainer.exclusionPaths = [path]
        }
    }
    
    @IBAction func showTextImageVC(_ sender: Any) {
        let vc = TextImageVC()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
