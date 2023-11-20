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
#import "Animal.h"
#import "Bird.h"
#import "Person.h"
#import "President.h"
#import "NSObject+Sark.h"

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

    // 知识点：换实现时候需要考虑，originSelector 继承链上没有，
    //        或者当前子类没有只有父类有的情况，exchange(impl1,impl2) 有空实现能交换成功，
    //        replace(method, impl) 时 impl 为空会无法 replace
//    Bird *bird = [[Bird alloc] init];
//    [bird speak];
//    //-[Bird run]: unrecognized selector sent to instance 0x600000011f40'
//    [bird run];
    
    // -[Animal custom_speak]: unrecognized selector sent to instance 0x60000002a610
//    FlyAnimal *ani = [[FlyAnimal alloc] init];
//    [ani speak];



    // 知识点：struct object + obj_msgSend + struct super + 函数调用压栈出栈过程
//    编译运行正常，输出ViewController中的self对象。 编译运行正常，调用了-speak方法，由于
//    id cls = [Sark class];
//    void *obj = &cls;
//    obj已经满足了构成一个objc对象的全部要求（首地址指向ClassObject），遂能够正常走消息机制；
//    由于这个人造的对象在栈上，而取self.name的操作本质上是self指针在内存向高位地址偏移
//    （32位下一个指针是4字节，64位下一个指针是8字节），
//     按viewDidLoad执行时各个变量入栈顺序从高到底为（self, _cmd, self.class, self, obj）
//    （前两个是方法隐含入参，随后两个为super调用的两个压栈参数(注意压栈的顺序)，
//     因为调用了 [super viewDidLoad] 其中第一个参数是结构体指针，需要在栈中先构造一个局部变量结构体
//     遂栈低地址的obj+4（64位上obj+8)取到了self。
    
    // 栈调试技巧
    // po $esi   打印寄存器中的值
    // po ((Sark *)0x16f5b7d20).name  地址中值强转
    
    // 打开下面一段代码，会崩溃（Father class 的 super 继承链中没有 speak 方法的实现）
//    id fatherCls = [Father class];
//    void *father = (void *)&fatherCls;
//    [(__bridge id)father speak];    // 会崩溃。。。
    
//    id cls = [Sark class];
//    void *obj = &cls;
//    NSLog(@"obj pointer = %p", obj);
//    [(__bridge id)obj speak];



    // 知识点：class_copyPropertyList 只打印该 class 上自己的属性，不打印父类的
//    NSArray *iVars = [President instanceVariables];
//    NSLog (@"iVars : %@", iVars);
//    
//    iVars = [Person instanceVariables];
//    NSLog (@"iVars : %@", iVars);



    // 知识点：[obj class] 与 object_getClass(obj) 的区别
    // [obj class] 实现源码：
    //+ (Class)class {
    //    return self;
    //}
    //
    //- (Class)class {
    //    return object_getClass(self);
    //}
    //
    //+ (Class)superclass {
    //    return self->superclass;
    //}
    //
    //- (Class)superclass {
    //    return [self class]->superclass;
    //}
    //
    // object_getClass(obj) 实现源码：
    //Class object_getClass(id obj)
    //{
    //    if (obj) return obj->getIsa();
    //    else return Nil;
    //}
    
//    Person *p = [[Person alloc] init];
//    p.name = @"张三";
//    NSLog(@"[p class] == [Person class] => %d", [p class] == [Person class]);
//    NSLog(@"[p class] == [[p class] class] => %d", [p class] == [[p class] class]);
//    NSLog(@"[p class] == [[[p class] class] class] => %d", [p class] == [[[p class] class] class]);
//    NSLog(@"[p class] == objc_getClass(p) => %d", [p class] == object_getClass(p));
//
//    NSLog(@"KVO之前%@ %@", [p class], object_getClass(p));
//    // isa swizzling + 重写 set 方法 实现 KVO
//    [p addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
//    // KVO 后，发现系统将 NSKVONotifying_Person 重写了 class 方法，直接返回的 KVO 之前的类对象。
//    // 所以才会出现下面的打印不一致的问题
//    Class cls = object_getClass(p);
//    [self printMethodList:cls];
//    NSLog(@"KVO之后%@ %@", [p class], object_getClass(p));
//    p.name = @"李四";
//
//    [p removeObserver:self forKeyPath:@"name"];
    
    
    
    // 知识点：objc_getClass("xxx") 获取指向类对象的 isa 指针
    //        objc_getMetaClass("xxx") 获取指向元类对象的 isa 指针
//    Class pointerToClass = objc_getClass("Person");
//    Class pointerToMetaClass = objc_getMetaClass("Person");
//    
//    NSLog(@"pointerToClass:     %p %@", pointerToClass, NSStringFromClass(pointerToClass));
//    NSLog(@"pointerToMetaClass: %p %@", pointerToMetaClass, NSStringFromClass(pointerToMetaClass));
//    [self printMethodList:pointerToClass];
//    [self printMethodList:pointerToMetaClass];
    
    
    
    // 知识点：struct objc_super info = {
    //            .receiver = self,
    //            .super_class = class_getSuperclass(currentClass)
    //        };
    //        [super xxx]; 会被转化为 obj_msgSendSuper(struct objc_super * superInfo = &info, SEL sel) 的调用
    //
    //        obj_msgSendSuper 的实现中通过传入的 superInfo->super_class 去这个类对象及其 super 类对象链中查找 sel 实现
    //        并在找到后调用 obj_msgSend(superInfo->receiver, sel) 执行
    //        在找到的 super selector 方法执行时候的 self 依然为具体实例对象的指针（即上面的 superInfo->receiver）
    //        可以通过打符号断点 obj_msgSendSuper2 验证上述过程
    //        至于super调用的方法中又有super调用时候，怎么拿到 currentClass，暂时没有弄太情况
    //       （可能是通过线程寄存器或者隐藏在调用 obj_msgSend 之前压栈字段获取到）
    //
    // 知识点：class: 任何一个类调用class方法：目的是获取方法调用者的类型
    //        superclass: 任何一个类调用superclass方法：目的是获取方法调用者的父类
    //        super: 不是指针，编译器指示符，表示去调用父类的方法，本质还是当前对象去调用父类方法
    //        ⚠️注意⚠️：super不是父类对象，仅仅是一个指向父类方法标志
    
//    Person* p = [[President alloc] init];
//    p.name = @"张三";
//    p.age = 20;
//    [p test];
    
    
    
    // 知识点：runtime 的整个类、原类的图中的 isa、super_class 指向关系
    //+ (Class)class {
    //    return self;
    //}
    //
    //- (Class)class {
    //    return object_getClass(self);
    //}
    //
    //Class object_getClass(id obj) {
    //    if (obj) return obj->getIsa();
    //    else return Nil;
    //}
    //
    //inline Class objc_object::getIsa() {
    //    if (isTaggedPointer()) {
    //        uintptr_t slot = ((uintptr_t)this >> TAG_SLOT_SHIFT) & TAG_SLOT_MASK;
    //        return objc_tag_classes[slot];
    //    }
    //    return ISA();
    //}
    //
    //inline Class objc_object::ISA() {
    //    assert(!isTaggedPointer());
    //    return (Class)(isa.bits & ISA_MASK);
    //}
    //
    //- (BOOL)isKindOfClass:(Class)cls {
    //    for (Class tcls = object_getClass((id)self); tcls; tcls = tcls->superclass) {
    //        if (tcls == cls) return YES;
    //    }
    //    return NO;
    //}
    //
    // - (BOOL)isKindOfClass:(Class)cls {
    //    for (Class tcls = [self class]; tcls; tcls = tcls->superclass) {
    //        if (tcls == cls) return YES;
    //    }
    //    return NO;
    // }
    //
    //- (BOOL)isMemberOfClass:(Class)cls {
    //    return object_getClass((id)self) == cls;
    //}
    //
    //- (BOOL)isMemberOfClass:(Class)cls {
    //    return [self class] == cls;
    //}
    BOOL res1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];
    BOOL res2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];
    BOOL res3 = [(id)[Sark class] isKindOfClass:[Sark class]];
    BOOL res4 = [(id)[Sark class] isMemberOfClass:[Sark class]];

    NSLog(@"%d %d %d %d", res1, res2, res3, res4);
    
    BOOL res5 = [(id)[NSObject class] isMemberOfClass:objc_getMetaClass("NSObject")];
    BOOL res6 = [[NSObject new] isMemberOfClass:[NSObject class]];
    
    NSLog(@"%d %d", res5, res6);
    
    
    // 知识点： +(xxx)xxx 与 -(xxx)xxx 方法只是分别被放在原类和类的对象的 method_list 中
    //        消息转发机制根据调用类方法和实例方法
    //        从 self->isa (类方法调用时候 self 为类对象，实例方法调用时候 self 为实例对象) 的对象及向上的 super 类对象链中递归查找 method_list 中有没有 selector 实现
    [NSObject foo];
    [[NSObject new] foo];
    

    
    // 知识点：给已经存在的类动态添加 property 和存储变量是不允许的，调用 valueForKey: 时候会崩溃
//    Person* p = [[President alloc] init];
//
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
//
//
//    class_addProperty([p class], "studentIdentifier", &attributes, 1);
////    objc_property_t property = class_getProperty([p class], "studentIdentifier");
////    NSLog(@"%s %s", property_getName(property), property_getAttributes(property));
//
//    propertyList = class_copyPropertyList([p class], &propertyCount);
//    for (int i = 0; i < propertyCount; i++) {
//        const char* name = property_getName(propertyList[i]);
//        const char* attributes = property_getAttributes(propertyList[i]);
//        NSLog(@"%s %s", name, attributes);
//    }
//    
//    NSLog (@"p.age: %ld", p.age);
//    NSLog (@"p.studentIdentifier: %@", [p valueForKey:@"studentIdentifier"]);
}

- (void)printMethodList:(Class)cls {
    unsigned int outCount;
    Method* methods = class_copyMethodList(cls, &outCount);
    
    NSLog(@"printMethodList: %p", cls);
    for (int i = 0; i < outCount ; i++) {
        SEL name = method_getName(methods[i]);
        NSString *strName = [NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
        NSLog(@"selName : %@", strName);
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSLog(@"%@.%@ value changed to %@", object, keyPath, change[NSKeyValueChangeNewKey]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end




