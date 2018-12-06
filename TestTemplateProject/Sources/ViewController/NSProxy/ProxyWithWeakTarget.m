//
//  ProxyWithWeakTarget.m
//  TestTemplateProject
//
//  Created by Ben on 12/6/18.
//  Copyright (c) 2018 Ben. All rights reserved.
//

#import "ProxyWithWeakTarget.h"

@implementation ProxyWithWeakTarget

//NSProxy 比NSObject 更加轻量级,继承了NSObject协议
/**
 NSProxy 是一个抽象基类，它为一些表现的像是其它对象替身或者并不存在的对象定义API。一般的，发送给代理的消息被转发给一个真实的对象或者代理本身引起加载(或者将本身转换成)一个真实的对象。NSProxy的基类可以被用来透明的转发消息或者耗费巨大的对象的lazy 初始化。
 
 NSProxy实现了包括NSObject协议在内基类所需的基础方法，但是作为一个抽象的基类并没有提供初始化的方法。它接收到任何自己没有定义的方法他都会产生一个异常，所以一个实际的子类必须提供一个初始化方法或者创建方法，并且重载forwardInvocation:方法和methodSignatureForSelector:方法来处理自己没有实现的消息。一个子类的forwardInvocation:实现应该采取所有措施来处理invocation,比如转发网络消息，或者加载一个真实的对象，并把invocation转发给他。methodSignatureForSelector:需要为给定消息提供参数类型信息，子类的实现应该有能力决定他应该转发消息的参数类型，并构造相对应的NSMethodSignature对象。详细信息可以查看NSDistantObject, NSInvocation, and NSMethodSignature的类型说明。
 */

// 方法签名
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}

// 消息转发
- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}

@end
