//
//  SwiftBenTestView.swift
//  teacher
//
//  Created by Ben on 2019/6/24.
//

import UIKit

@objc(SwiftBenTestView) class SwiftBenTestView: UIView {
    var contentView:UIView!
    
    static let kTestViewWidth:  CGFloat = 200
    static let kTestViewHeight: CGFloat = 100
    
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    
    var model: SwiftBenTestModel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear;
        contentView = loadXib()
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear;
        contentView = loadXib()
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    func loadXib() ->UIView {
        let className = type(of:self)
        let bundle = Bundle(for:className)
        let name = NSStringFromClass(className).components(separatedBy: ".").last
        let nib = UINib(nibName: name!, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
    
    func refreshUI(model: SwiftBenTestModel) {
        self.model = model
        
        self.startTimeLabel.text = NSDate.string(from: Date(timeIntervalSince1970: Double(self.model.startTime) / 1000.0))
        self.endTimeLabel.text = NSDate.string(from: Date(timeIntervalSince1970: Double(self.model.endTime) / 1000.0))
    }
}


