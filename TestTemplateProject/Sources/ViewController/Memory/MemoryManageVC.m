//
//  MemoryManageVC.m
//  TestTemplateProject
//
//  Created by Ben on 2017/10/23.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "MemoryManageVC.h"

void printClassInfo(id obj)
{
    Class cls = object_getClass(obj);
    Class superCls = class_getSuperclass(cls);
    NSLog(@"pointer:%p - self:%s - superClass:%s", obj, class_getName(cls), class_getName(superCls));
}

@interface MemoryManageVC ()

@property (nonatomic, strong) Block block;
@property (nonatomic, strong) NSMutableArray *tempArray;

@property (nonatomic, strong) NSString *videoPath;

@end

@implementation MemoryManageVC

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [self testAutoVarARC];
    
//    [self testBlockMemoryManage];
    
    [self testArgMemoryManage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog (@"MemoryManageVC dealloc");
}

#pragma mark - Private methods

- (void)testAutoVarARC {
    NSObject *a = [[NSObject alloc] init];
    NSLog(@"在lldb输入:po %p", a);
    a = nil;
    
    NSLog(@"此行设置断点");
}

- (void)testBlockMemoryManage {
    //@weakify(self)
    __weak MemoryManageVC* self_weak_ = self;
    self.block = ^{
        //@strongify(self)
        __strong MemoryManageVC* self = self_weak_;
        NSLog (@"self.tempArray: %@", self.tempArray);
        
        //@weakify(self)                             //这句可加可不加
//        __weak MemoryManageVC* self_weak_ = self;  //这句可加可不加
        self.block = ^{
            //@strongify(self)
            __strong MemoryManageVC *self = self_weak_;
            NSLog (@"self.tempArray: %@", self.tempArray);
        };
    };
    
    self.block();
}

- (void)testArgMemoryManage {
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

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.videoPath = nil;
    });

    [self testArgMemoryMethod:self.videoPath];
}

- (void)testArgMemoryMethod:(NSString *)videoPath {
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:10]];
    
    NSLog (@"self.videoPath: %@", self.videoPath);
    NSLog (@"videoPath: %@", videoPath);
    
    printClassInfo(self.videoPath);
    printClassInfo(videoPath);
    
//  TestTemplateProject[18209:1891263] self.videoPath: (null)
//  TestTemplateProject[18209:1891263] self.videoPath: Abcdef-1
//  TestTemplateProject[18209:1891263] self:nil - superClass:nil
//  TestTemplateProject[18209:1891263] self:NSTaggedPointerString - superClass:NSString
//  打开 scheme 设置中的 Zombie Object 没有出现 _NSZombie_NSTaggedPointerString 类名，出名传参数压栈默认都会 strong 强引用
}

@end


