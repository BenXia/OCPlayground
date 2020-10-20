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
        
        self.testOptionalType()
        
//        self.testReactiveSwiftBasic()
//
//        self.testReactiveObjCBasic()
//
//        self.testSwiftBlock()
    }
    
    func testOptionalType() {
        let dic: Dictionary = [ "1": 2, "3": 3, "4": 5 ]
        let t1 = dic.valuesForKeys(["1", "4"]).last
        let t2 = dic.valuesForKeys(["3", "9"]).last
        let t3 = dic.valuesForKeys([]).last

        print("t1: \(String(describing: t1!!))")
        print("t2: \(String(describing: t2!))")
        print("t3: \(String(describing: t3))")

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
        let model: SwiftBenTestModel = SwiftBenTestModel.init()
        model.qingqingWhateverId = "11818212";
        model.adjusted = false
        model.startTime = 1563765226000
        model.endTime = 1563765226000

        let view: SwiftBenTestView = SwiftBenTestView.init(frame: CGRect(x: (SwiftUtility.kScreenWidth_ - SwiftBenTestView.kTestViewWidth) / 2, y: 100, width: SwiftBenTestView.kTestViewWidth, height:SwiftBenTestView.kTestViewHeight))
        view.refreshUI(model: model)

        self.view.addSubview(view)


//        let kvoModel: BenTestModelOCA = BenTestModelOCA.init()
//        kvoModel.reactive.producer(forKeyPath: "isSelected").startWithValues { (value) in
//            if value != nil {
//                print(value!)
//            }
//            //print(kvoModel.isSelected)
//        }
//
//        kvoModel.isSelected = false
//        kvoModel.isSelected = true


        // 注意，如果此处的 BenTestModelA 是 OC 代码中定义的类，则使用下面语法是没有问题的
        //let model2: BenTestModelA = BenTestModelA.init()
        let model2: BenTestModelOCA = BenTestModelOCA.init()
        model2.reactive.producer(forKeyPath: "adjusted").startWithResult { (result) in
            switch result {
                case .success(let object):
                    print("A name: \(object as! String)")
                case .failure:
                    print("Error")
            }
        }
        model2.reactive.producer(forKeyPath: "name").startWithResult { (result) in
            switch result {
                case .success(let object):
                    print("A name: \(object as! String)")
                case .failure:
                    print("Error")
            }
        }
        //model2.reactive.producer(forKeyPath: "ageModel.age").startWithValues { (value) in
        //    print("A ageModel age: \(value ?? "")")
        //}

        model2.adjusted = false
        model2.adjusted = true
        model2.name = "bbb"
        model2.name = "ccc"
        //model2.ageModel.age.value = 20


        let model3: BenTestModelB = BenTestModelB.init()
        model3.adjusted.producer.startWithValues { (value) in
            print("B ajusted: \(value)")
        }
        model3.name.producer.startWithValues { (value) in
            print("B name: \(value)")
        }
        model3.ageModel.age.producer.startWithValues { (value) in
            print("B ageModel age: \(value)")
        }

        model3.adjusted.value = false
        model3.adjusted.value = true
        model3.name.value = "BBB"
        model3.name.value = "CCC"
        model3.ageModel.age.value = 20

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


