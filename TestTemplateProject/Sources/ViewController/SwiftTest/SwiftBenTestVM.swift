//
//  SwiftBenTestVM.swift
//  teacher
//
//  Created by Ben on 2019/6/24.
//

import UIKit

@objc(SwiftBenTestVM) class SwiftBenTestVM: NSObject {
    var qingqingWhateverId: String = ""
    
//    var detailResponse: ApiGPBApiTeacherArrangeCourseDetailResponse!

    @objc class func pushSwiftBenTestVC(qingqingWhateverId: String) {
        if qingqingWhateverId.isEmpty {
            return
        }
        
//        QQingUtils.showLoadingView()
        
        let vm = SwiftBenTestVM.init()
        vm.qingqingWhateverId = qingqingWhateverId
        
        vm.cmd_getWhateverDetail.execute(nil).onMainThread().subscribeNext({ (response) in
//            QQingUtils.hideLoadingView()
            
            let vc : SwiftBenTestVC = SwiftBenTestVC.init(vm: vm)
            vc.hidesBottomBarWhenPushed = true
            CommonUtils.topVisibleNavigationViewController()?.pushViewController(vc, animated: true)
        }, error: { (error) in
//            QQingUtils.hideLoadingView()
            
//            SwiftUtility.showToast(withAllError: error)
        })
    }
    
    private(set) lazy var cmd_getWhateverDetail : RACCommand<AnyObject, AnyObject> = {
        return RACCommand<AnyObject, AnyObject>.init(signal: { [weak self] (input) -> RACSignal<AnyObject> in
            guard let `self` = self else { return RACSignal.empty() }
            
            return self.sig_getWhateverDetail(self.qingqingWhateverId)
        });
    }()

    private func sig_getWhateverDetail(_ qingqingWhateverId: String) -> RACSignal<AnyObject> {
        return RACSignal.createSignal({
            //[weak self]
            (subscriber) -> RACDisposable? in
//            guard let `self` = self else {
//                subscriber.sendCompleted()
//                return nil
//            }
            
            subscriber.sendNext(nil)
            subscriber.sendCompleted()
            
//            let request = GPBSimpleStringRequest()
//            request.data_p = qingqingWhateverId;
//
//            SignalFromRequest.signalFromPBRequest(withApiPath: kTeacher_ArrangeCourseDetailURLString,
//                                                    pbMessage: request,
//                                                responseClass: ApiGPBApiTeacherArrangeCourseDetailResponse.self,
//                                                  errorDomain: kErrorDomainPB_GeneralRequest)?.onMainThread().subscribeNext({ [weak self] (response) in
//                                                    guard let `self` = self else {
//                                                        subscriber.sendCompleted();
//                                                        return
//                                                    }
//
//                                                    guard let response = response else {
//                                                        subscriber.sendCompleted()
//                                                        return
//                                                    }
//
//                                                    let dResponse : ApiGPBApiTeacherArrangeCourseDetailResponse = response as! ApiGPBApiTeacherArrangeCourseDetailResponse
//                                                    self.detailResponse = dResponse
//
//                                                    subscriber.sendNext(response)
//                                                    subscriber.sendCompleted()
//                                                }, error: { (error) in
//                                                    subscriber.sendError(error)
//                                              })
            
            return nil;
        })
    }
    
    private(set) lazy var cmd_testWhateverApi : RACCommand<AnyObject, AnyObject> = {
        return RACCommand<AnyObject, AnyObject>.init(signal: { [weak self] (input) -> RACSignal<AnyObject> in
            guard let `self` = self else { return RACSignal.empty() }
            
            return self.sig_testWhateverApi(input as! [String])
        });
    }()
    
    private func sig_testWhateverApi(_ whateverIdArray: [String]) -> RACSignal<AnyObject> {
        return RACSignal.createSignal({
            //[weak self]
            (subscriber) -> RACDisposable? in
//            guard let `self` = self else {
//                subscriber.sendCompleted()
//                return nil
//            }
            
            subscriber.sendNext(nil)
            subscriber.sendCompleted()
            
//            var toSubmitCourseInfoList: [ApiGPBApiTeacherConfirmArrangeCourseRequest_StudentArrangeCourseInfo] = []
//            for subGroupModel in studentArrangeGroupModelArray {
//                let subItem = ApiGPBApiTeacherConfirmArrangeCourseRequest_StudentArrangeCourseInfo.init()
//                subItem.qingqingStudentId = subGroupModel.studentQingQingUserIds[0]
//
//                var courseInfoItems: [ApiGPBApiTeacherConfirmArrangeCourseRequest_ArrangeCourseInfoItem] = []
//
//                let courseModelListNeedsTraverse = subGroupModel.inRangeCanAdjustCourseModelList + subGroupModel.inFutureCourseModelList
//                for subCourseModel in courseModelListNeedsTraverse {
//                    if subCourseModel.adjusted {
//                        let subCourseItem = ApiGPBApiTeacherConfirmArrangeCourseRequest_ArrangeCourseInfoItem.init()
//                        subCourseItem.qingqingGroupOrderCourseId = subCourseModel.qingqingGroupOrderCourseId
//                        subCourseItem.newTimeParam = subCourseModel.currentParam
//
//                        courseInfoItems.append(subCourseItem)
//                    }
//                }
//
//                subItem.arrangeCourseInfoItemsArray = NSMutableArray(array:courseInfoItems)
//
//                toSubmitCourseInfoList.append(subItem)
//            }
//
//            let request = ApiGPBApiTeacherConfirmArrangeCourseRequest()
//            request.qingqingTeacherArrangeCourseId = self.qingqingArrangeCourseId
//            request.studentArrangeCourseInfoItemsArray = NSMutableArray(array:toSubmitCourseInfoList)
//
//            SignalFromRequest.signalFromPBRequest(withApiPath: kTeacher_ArrangeConfirmURLString,
//                                                    pbMessage: request,
//                                                responseClass: GPBSimpleResponse.self,
//                                                  errorDomain: kErrorDomainPB_GeneralRequest)?.onMainThread().subscribeNext({ (response) in
//                                                        subscriber.sendNext(response)
//                                                        subscriber.sendCompleted()
//                                                    }, error: { (error) in
//                                                        subscriber.sendError(error)
//                                                  })

            return nil;
        })
    }
}




