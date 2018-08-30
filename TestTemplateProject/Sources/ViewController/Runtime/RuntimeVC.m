//
//  RuntimeVC.m
//  TestTemplateProject
//
//  Created by Ben on 2017/8/20.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "RuntimeVC.h"
#import "NSObject+DLIntrospection.h"
#import <objc/runtime.h>
#import "Person.h"
#import "President.h"

@interface Sark : NSObject

@property (nonatomic, copy) NSString *name;

@end

@implementation Sark

- (void)speak {
    NSLog(@"%p", self);
    NSLog(@"%p", ((__bridge void *)self + 8));
    NSLog(@"my name's %@", self.name);
    NSLog(@"my name is %p", &_name);
    NSLog(@"my name is %@", *(&_name));
}

@end

@interface Father : NSObject
@end

@implementation Father
@end


@interface RuntimeVC ()

@end

@implementation RuntimeVC

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    编译运行正常，输出ViewController中的self对象。 编译运行正常，调用了-speak方法，由于
//    id cls = [Sark class];
//    void *obj = &cls;
//    obj已经满足了构成一个objc对象的全部要求（首地址指向ClassObject），遂能够正常走消息机制；
//    由于这个人造的对象在栈上，而取self.name的操作本质上是self指针在内存向高位地址偏移（32位下一个指针是4字节，64位下一个指针是8字节），按viewDidLoad执行时各个变量入栈顺序从高到底为（self, _cmd, self.class, self, obj）（前两个是方法隐含入参，随后两个为super调用的两个压栈参数(注意压栈的顺序)），遂栈低地址的obj+4（64位上obj+8)取到了self。
    
    // 栈调试技巧
    // po $esi   打印寄存器中的值
    // po ((Sark *)0x16f5b7d20).name  地址中值强转
    
    // 打开下面一段代码，会崩溃
//    id fatherCls = [Father class];
//    void *father;
//    father = (void *)&fatherCls;
//    [(__bridge id)father speak];    // 会崩溃。。。
    
    id cls = [Sark class];
    void *obj = &cls;
    NSLog(@"obj pointer = %p", obj);
    [(__bridge id)obj speak];

//    NSArray *iVars = [Sark instanceVariables];
//    NSLog (@"iVars : %@", iVars);
    
    // 添加 property 配合关联属性（）
//    Person* p = [[Person alloc] init];   // 换成子类 President 再看看（子类只打印自己的属性，不打印父类的）
//    p.cjmAge = 20;
//    p.cjmName = @"Jiaming Chen";

//    unsigned int propertyCount = 0;
//    objc_property_t *propertyList = class_copyPropertyList([p class], &propertyCount);
//    for (int i = 0; i < propertyCount; i++) {
//        const char* name = property_getName(propertyList[i]);
//        const char* attributes = property_getAttributes(propertyList[i]);
//        NSLog(@"%s %s", name, attributes);
//    }
//    objc_property_attribute_t attributes = {
//        "T@\"NSString\",C,N,V_studentIdentifier",
//        "",
//    };
//    class_addProperty([p class], "studentIdentifier", &attributes, 1);
//    objc_property_t property = class_getProperty([p class], "studentIdentifier");
//    NSLog(@"%s %s", property_getName(property), property_getAttributes(property));
//
//    propertyList = class_copyPropertyList([p class], &propertyCount);
//    for (int i = 0; i < propertyCount; i++) {
//        const char* name = property_getName(propertyList[i]);
//        const char* attributes = property_getAttributes(propertyList[i]);
//        NSLog(@"%s %s", name, attributes);
//    }
    
//    NSLog (@"p.age: %ld", p.cjmAge);
//    NSLog (@"p.studentIdentifier: %@", p.studentIdentifier);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


