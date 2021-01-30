//
//  SwiftBenTestVC.swift
//  teacher
//
//  Created by Ben on 2019/6/20.
//

import UIKit

extension Dictionary {
    func valuesForKeys(_ keys: [Key]) -> [Value?] {
        return keys.map { self[$0] }
    }
}

@objc(SwiftBenTestVC) class SwiftBenTestVC: BaseViewController {
    var vm : SwiftBenTestVM!
    
    var swiftKVOModel: SwiftBenTestModel!
    var swiftKVOModel2: SwiftBenTestModel!
    
    var observer1: NSKeyValueObservation?
    var observer2: NSKeyValueObservation?
    
    // MARK: - life cycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc init() {
        super.init(nibName: "SwiftBenTestVC", bundle: nil)
    }
    
    @objc init(vm viewModel: SwiftBenTestVM) {
        super.init(nibName: "SwiftBenTestVC", bundle: nil)
        
        self.vm = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initUI()
    }
    
    func initUI() {
        self.title = "Swift调试页面"
        
//        self.tempTestFunc()
        
//        self.testOptionalType()
//        self.testForceCastBasicDataType()
        
//        self.testReactiveSwiftBasic()
//
//        self.testReactiveObjCBasic()
//
//        self.testSwiftBlock()
//        
//        self.testSwiftArgDefaultValue("Wang")
        self.testSwiftArgDefaultValue(age: 13)
    }
    
    func tempTestFunc() {
        
//        let alertV = UIAlertView.init(title: "轻轻提示", message: "请在iPhone的“设置－隐私－相机”选项中，允许轻轻助教访问您的手机相册。", delegate: nil, cancelButtonTitle: "我知道了")
//        alertV.show()
        
        let alertView = UIAlertController(title: "轻轻提示", message: "请在iPhone的“设置－隐私－相机”选项中，允许轻轻助教访问您的手机相册。", preferredStyle: UIAlertController.Style.alert)
        let alertAction1 = UIAlertAction(title: "我知道了", style: UIAlertAction.Style.default, handler:{ _ in })
        alertView.addAction(alertAction1)
        self.present(alertView, animated: true, completion: nil)
        
        
//        let vc = PublicTransferSucessVC.init(needDeleteLastVC:false, completionBlock: { [weak self] in
//            guard let `self` = self else { return }
//
//            self.navigationController?.popToViewController(self, animated: true)
//        })
//
//        self.pushVC(vc);
        
        //VCSwitchHandler.sharedInstance()?.pushWebVC(withUrl: String.init(format: kStudent_ClassHourV2ContractURLString, "12345", 67890) as String, animated: true)
    }
    
    func testForceCastBasicDataType() {
        let a: Float32 = -Float32.greatestFiniteMagnitude
        let b: Float32 = Float32.nan
        let c: Float32 = Float32.infinity
        
        var ai: Int64 = 0
        var bi: Int64 = 0
        var ci: Int64 = 0
        if a > Float32(Int64.max) {
            ai = Int64.max
        } else if a < Float32(Int64.min) {
            ai = Int64.min
        } else if a.isNaN {
            ai = 0
        } else if a.isInfinite {
            ai = Int64.max
        } else {
            ai = Int64(a)
        }
        if b > Float32(Int64.max) {
            bi = Int64.max
        } else if b < Float32(Int64.min) {
            bi = Int64.min
        } else if b.isNaN {
            bi = 0
        } else if b.isInfinite {
            bi = Int64.max
        } else {
            bi = Int64(b)
        }
        if c > Float32(Int64.max) {
            ci = Int64.max
        } else if c < Float32(Int64.min) {
            ci = Int64.min
        } else if c.isNaN {
            ci = 0
        } else if c.isInfinite {
            ci = Int64.max
        } else {
            ci = Int64(c)
        }

        print("\(ai) + \(bi) + \(ci)")
    }
    
    func testOptionalType() {
        let dic: Dictionary = [ "1": 2, "3": 3, "4": 5 ]
        let t1 = dic.valuesForKeys(["1", "4"]).last
        let t2 = dic.valuesForKeys(["3", "9"]).last
        let t3 = dic.valuesForKeys([]).last

        print("t1: \(String(describing: t1!!))")
        print("t2: \(String(describing: t2!))")
        print("t3: \(String(describing: t3))")
        
//        t1: 5
//        t2: nil
//        t3: nil

        //(lldb) po t1
        //▿ Optional<Optional<Int>>
        //  ▿ some : Optional<Int>
        //    - some : 5
        //
        //(lldb) po t2
        //▿ Optional<Optional<Int>>
        //  - some : nil
        //
        //(lldb) po t3
        //nil
        //
        //(lldb) p t1
        //(Int??) $R38 = 5
        //(lldb) p t2
        //(Int??) $R40 = nil
        //(lldb) p t1!
        //(Int?) $R42 = 5
    }
    
    func testReactiveSwiftBasic() {
//        let model: SwiftBenTestModel = SwiftBenTestModel.init()
//        model.qingqingWhateverId = "11818212"
//        model.adjusted = false
//        model.startTime = 1563765226000
//        model.endTime = 1563765226000
//
//        let view: SwiftBenTestView = SwiftBenTestView.init(frame: CGRect(x: (SwiftUtility.kScreenWidth_ - SwiftBenTestView.kTestViewWidth) / 2, y: 100, width: SwiftBenTestView.kTestViewWidth, height:SwiftBenTestView.kTestViewHeight))
//        view.refreshUI(model: model)
//
//        self.view.addSubview(view)
//
//
//        // 第一种 swift model 的 KVO 观察实现方式（需要注意析构时候移除观察者）
//        self.swiftKVOModel = SwiftBenTestModel.init()
//        self.swiftKVOModel.qingqingWhateverId = "11818212"
//        self.swiftKVOModel.adjusted = false
//        self.swiftKVOModel.startTime = 1563765226000
//        self.swiftKVOModel.endTime = 1563765226000
//
//        self.swiftKVOModel.addObserver(self, forKeyPath: "qingqingWhateverId", options: [.new, .old], context: nil)
//        self.swiftKVOModel.addObserver(self, forKeyPath: "adjusted", options: [.new, .old], context: nil)
//
//        self.swiftKVOModel.qingqingWhateverId = "22222222"
//        self.swiftKVOModel.adjusted = true
        
        
        // 第二种 swift model 的 KVO 观察实现方式（感觉比第一种方式方便一点，代码集中一点，观察者对象释放时候就会自动解除观察（invalidate() will be called automatically when an NSKeyValueObservation is deinited））
        let swiftKVOModel2 = SwiftBenTestModel.init()
        var observer1: NSKeyValueObservation?
        var observer2: NSKeyValueObservation?

        swiftKVOModel2.qingqingWhateverId = "11818212"
        swiftKVOModel2.adjusted = false
        swiftKVOModel2.startTime = 1563765226000
        swiftKVOModel2.endTime = 1563765226000

        observer1 = swiftKVOModel2.observe(\SwiftBenTestModel.qingqingWhateverId, options: [.old, .new]) { (model, change) in
            if let old = change.oldValue {
                print("qingqingWhateverId oldValue: \(old)")
            }
            if let new = change.newValue {
                print("qingqingWhateverId newValue: \(new)")
            }
        }
        observer2 = swiftKVOModel2.observe(\SwiftBenTestModel.adjusted, options: [.old, .new]) { (model, change) in
            if let old = change.oldValue {
                print("adjusted oldValue: \(old)")
            }
            if let new = change.newValue {
                print("adjusted newValue: \(new)")
            }
        }

        swiftKVOModel2.qingqingWhateverId = "22222222"
        swiftKVOModel2.adjusted = true
        self.swiftKVOModel2 = swiftKVOModel2
        self.observer1 = observer1
        self.observer2 = observer2
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let `self` = self else { return }
            
            self.swiftKVOModel2.qingqingWhateverId = "33333333"
            self.swiftKVOModel2.adjusted = false
            
            ///invalidate() will be called automatically when an NSKeyValueObservation is deinited
            self.observer1 = nil
            self.observer2 = nil
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                guard let `self` = self else { return }
                
                self.swiftKVOModel2.qingqingWhateverId = "44444444"
                self.swiftKVOModel2.adjusted = true
                
            }
        }
        

//        let kvoModel: BenTestModelA = BenTestModelA.init()
//        kvoModel.reactive.producer(forKeyPath: "isSelected").startWithValues { (value) in
//            if value != nil {
//                print(value!)
//            }
//            //print(kvoModel.isSelected)
//        }
//
//        kvoModel.isSelected = false
//        kvoModel.isSelected = true
//
//
//        // 注意，如果此处的 BenTestModelA 是 OC 代码中定义的类，则使用下面语法是没有问题的
//        //let model2: BenTestModelA = BenTestModelA.init()
//        let model2: BenTestModelOCA = BenTestModelOCA.init()
//        model2.reactive.producer(forKeyPath: "adjusted").startWithValues { (value) in
//            print("A ajusted: \(value ?? "")")
//        }
//        model2.reactive.producer(forKeyPath: "name").startWithValues { (value) in
//            print("A name: \(value ?? "")")
//        }
//        //model2.reactive.producer(forKeyPath: "ageModel.age").startWithValues { (value) in
//        //    print("A ageModel age: \(value ?? "")")
//        //}
//
//        model2.adjusted = false
//        model2.adjusted = true
//        model2.name = "bbb"
//        model2.name = "ccc"
//        //model2.ageModel.age.value = 20
//
//
//        let model3: BenTestModelB = BenTestModelB.init()
//        model3.adjusted.producer.startWithValues { (value) in
//            print("B ajusted: \(value)")
//        }
//        model3.name.producer.startWithValues { (value) in
//            print("B name: \(value)")
//        }
//        model3.ageModel.age.producer.startWithValues { (value) in
//            print("B ageModel age: \(value)")
//        }
//
//        model3.adjusted.value = false
//        model3.adjusted.value = true
//        model3.name.value = "BBB"
//        model3.name.value = "CCC"
//        model3.ageModel.age.value = 20
//
//
//        BasicErrorHandler.sharedInstance()?.showToast(withAllError: NSError.init(domain: kErrorDomainPB_GeneralRequest, code: ErrorCodeCommon._Whatever.rawValue, userInfo: [ "ErrorUserInfoDict_ErrorMessageKey": "网络不给力，请稍候再试"]))
    }
    
    // 重写响应方法
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print("keypath: \(String(describing: keyPath))") // name
        if let old = change?[NSKeyValueChangeKey.oldKey] {
            print("oldValue: \(old)")
        }
        
        if let new = change?[NSKeyValueChangeKey.newKey] {
            print("newValue: \(new)")
        }
    }
    
    deinit {
        if let model = self.swiftKVOModel {
            model.removeObserver(self, forKeyPath: "qingqingWhateverId")
            model.removeObserver(self, forKeyPath: "adjusted")
        }
    }
    
    func testReactiveObjCBasic() {
//        let signal1 = TeacherInfoModel.sharedInstance().rac_values(forKeyPath: "needDetectAuthCertificate", observer: self).distinctUntilChanged()
//        let signal2 = TeacherInfoModel.sharedInstance().rac_values(forKeyPath: "remainDetectAuthTimes", observer: self).distinctUntilChanged()
//        
////        let combinedSignal = RACSignal<AnyObject>.combineLatest(NSArray(array: [signal1, signal2])).map { (value) -> Any? in
////            if value != nil {
////                let tuple: RACTuple = value!
////
////                //print("first: \(tuple.first)  second:\(tuple.second)")
////
////                var needDetect: Bool = false
////                var detectCount: Int32 = 0
////
////                if let val = tuple.first {
////                    if val is Bool {
////                        needDetect = val as! Bool
////                    }
////                }
////                if let count = tuple.second {
////                    if count is Int32 {
////                        detectCount = count as! Int32
////                    }
////                }
////
////                let objToReturn: AnyObject? = Bool(needDetect && (detectCount > 0)) as AnyObject
////
////                return objToReturn
////            } else {
////                return false as AnyObject
////            }
////        }.distinctUntilChanged()
//
////        let combinedSignal = RACSignal<AnyObject>.combineLatest(NSArray(array: [signal1, signal2]), reduce: { () -> AnyObject? in
////            let needDetect: Bool = TeacherInfoModel.sharedInstance().needDetectAuthCertificate
////            let detectCount: Int32 = TeacherInfoModel.sharedInstance().remainDetectAuthTimes
////
////            let objToReturn: AnyObject? = Bool(needDetect && (detectCount > 0)) as AnyObject
////
////            return objToReturn
////        }).distinctUntilChanged()
//        
//        let combinedSignal = RACSignal<AnyObject>.combineLatest(NSArray(array: [signal1, signal2])) { () -> AnyObject? in
//            let needDetect: Bool = TeacherInfoModel.sharedInstance().needDetectAuthCertificate
//            let detectCount: Int32 = TeacherInfoModel.sharedInstance().remainDetectAuthTimes
//
//            let objToReturn: AnyObject? = Bool(needDetect && (detectCount > 0)) as AnyObject
//
//            return objToReturn
//        }.distinctUntilChanged()
//
//        combinedSignal.subscribeNext { (value) in
//            if let val = value {
//                if val is Bool {
//                    let needToDetect: Bool = value! as! Bool
//                    print("needToDetect: \(needToDetect)")
//                }
//            }
//        }
//        
//        TeacherInfoModel.sharedInstance().needDetectAuthCertificate = true
//        TeacherInfoModel.sharedInstance().remainDetectAuthTimes = 0
//        TeacherInfoModel.sharedInstance().needDetectAuthCertificate = false
    }
    
    func testSwiftBlock() {
        typealias Fn = (Int) -> Int
        func getFn() -> Fn {
            var num = 0
            func plus(_ i: Int) -> Int {
                num += i
                return num
            }
            
            return plus
        }
        
        let fn = getFn()
        print(fn(1))
        print(fn(2))
        print(fn(3))
        print(fn(4))
    }
    
    func testSwiftArgDefaultValue(_ name: String = "Ben", age: Int = 13) {
        print("name: \(name) age: \(age)");
    }
}

@objc(BenTestModelA) class BenTestModelA : NSObject {
    @objc var adjusted: Bool = false
    @objc var name: String = "a"
    @objc var ageModel: BenTestInnerModel = BenTestInnerModel()
}

class BenTestModelB : NSObject {
    var adjusted: MutableProperty<Bool> = MutableProperty(false)
    var name: MutableProperty<String> = MutableProperty("b")
    var ageModel: BenTestInnerModel = BenTestInnerModel()
}

class BenTestInnerModel : NSObject {
    var age: MutableProperty<Int> = MutableProperty(0)
}


