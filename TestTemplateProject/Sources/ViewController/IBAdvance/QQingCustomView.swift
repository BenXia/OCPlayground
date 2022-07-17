//
//  QQingCustomView.swift
//  student
//
//  Created by Ben on 2021/4/28.
//

import UIKit
import MapKit

@IBDesignable @objc(QQingCustomView) class QQingCustomView: UIView {

    @IBOutlet var view: UIView!
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var testButtom: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customSetup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customSetup()
    }
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        customSetup()
//    }
//    override func prepareForInterfaceBuilder() {
//        super.prepareForInterfaceBuilder()
//        customSetup()
//    }
    @IBInspectable @objc var testText: String? {
        get {
            return testLabel.text
        }
        set (testText) {
            if let testLabel2 = testLabel {
                testLabel2.text = testText
            }
        }
    }
    @IBInspectable @objc var cornerValue: CGFloat {
        get {
            return self.view.layer.cornerRadius
        }
        set (cornerValue) {
            if let view2 = self.view {
                view2.layer.cornerRadius = cornerValue
            }
        }
    }
    func customSetup() {
//        view = (Bundle.main.loadNibNamed("QQingCustomView", owner: self, options: nil)?.first as! UIView)
        view = loadViewFromNibAction()
        view.frame = bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(view)
    }
    func loadViewFromNibAction() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib.init(nibName: "QQingCustomView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
}


