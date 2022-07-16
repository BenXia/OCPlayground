//
//  TaggedPointerTestVC.m
//  TestTemplateProject
//
//  Created by Ben on 2022/5/13.
//  Copyright © 2022 iOSStudio. All rights reserved.
//

#import "TaggedPointerTestVC.h"

static void printClassInfo(id obj)
{
    Class cls = object_getClass(obj);
    Class superCls = class_getSuperclass(cls);
    NSLog(@"pointer:%p - self:%s - superClass:%s", obj, class_getName(cls), class_getName(superCls));
}

@interface TaggedPointerTestVC ()

@property (nonatomic, strong) NSString *videoPath;

@end

@implementation TaggedPointerTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self testTaggedPointerString];
    
//    [self testTaggedPointerString2];
    
    [self testMultiThreadSafeRelease];
}

- (void)testTaggedPointerString {
    //分析Tagged Pointer之前，我们需要先关闭Tagged Pointer的数据混淆，以方便我们调试程序。通过设置环境变量OBJC_DISABLE_TAG_OBFUSCATION为YES。
    //还可以通过OBJC_DISABLE_TAGGED_POINTERS设置为YES关闭Tagged Pointer。
    //6位编码表：eilotrm.apdnsIc ufkMShjTRxgC4013bDNvwyUL2O856P-B79AFKEWV_zGJ/HYX
    //5位编码表：eilotrm.apdnsIc ufkMShjTRxgC4013
//    self.videoPath = [NSString stringWithFormat:@"%@", @"中"];  // 1个字节的 unicode码字符不能使用 tagged pointer
//    self.videoPath = [NSString stringWithFormat:@"中%d", 1];  // 2个字节的 unicode码字符不能使用 tagged pointer
//    self.videoPath = [NSString stringWithFormat:@"中国%d", 1];  // 3个字节的 unicode码字符不能使用 tagged pointer
//    self.videoPath = [NSString stringWithFormat:@";;;;;;%d", 1];  // 7个字节的 ASCII码字符（8位ASCII编码，不是7位的）
//    self.videoPath = [NSString stringWithFormat:@";;;;;;;%d", 1]; // 8个字节的 ASCII码字符（8位ASCII编码，不是7位的）已经不能使用 tagged pointer
//    self.videoPath = [NSString stringWithFormat:@"Abcdefg-%d", 1];   // 6位编码 9 * 6 + 2 + 4 + 4 = 64
//    self.videoPath = [NSString stringWithFormat:@"Abcdefg;%d", 1];   // 6位编码不行，其中；不在64个允许编码字符中，不能使用 tagged pointer
    self.videoPath = [NSString stringWithFormat:@"eilotrm.ap%d", 1];  // 5位编码 11 * 5 + 1 + 4 + 4 = 64
//    self.videoPath = [NSString stringWithFormat:@"eilotrm.apd%d", 1];    // 5位编码不行，超过11位了，不能使用 tagged pointer
//    self.videoPath = [NSString stringWithFormat:@"eilotrm.a-%d", 1];   // 5位编码不行，其中-不在32个允许编码字符中，不能使用 tagged pointer
    
    printClassInfo(self.videoPath);
}

- (void)testTaggedPointerString2 {
    NSMutableString *mutable = [NSMutableString string];
    NSString *immutable;
    char c = 'a';
    do {
        [mutable appendFormat: @"%c", c++];
        immutable = [mutable copy];
        NSLog(@"%p %@ %@", immutable, immutable, object_getClass(immutable));
    } while(((uintptr_t)immutable & 0x8000000000000000) == 0x8000000000000000);
}

- (void)testMultiThreadSafeRelease {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    for (int i = 0; i < 1000; i++) {
        dispatch_async(queue, ^{
            self.videoPath = [NSString stringWithFormat:@"abcdefghij"];  // 不是 TaggedPointerString
        });
    }
    
    /**
     我们异步并发执行setter方法，可能就会有多条线程同时执行[_name release]，连续release两次就会造成对象的过度释放，导致Crash。

     解决办法：

     1.使用atomic属性关键字修饰 videoPath property
     2.在不同线程中操作 self.videoPath = xxx; 前后加锁解锁
     */
}

@end


