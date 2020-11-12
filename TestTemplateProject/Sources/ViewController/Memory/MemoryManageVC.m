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
    NSLog(@"self:%s - superClass:%s", class_getName(cls), class_getName(superCls));
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
    self.videoPath = [NSString stringWithFormat:@"Abcdef-%d", 1];

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


