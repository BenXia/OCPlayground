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

// testPropertyOne
//@implementation Rectangle
//
//- (void)setName:(NSMutableString *)name {
//    _name = name;
//}
//
//@end


// testPropertyTwo
@implementation Rectangle

- (void)setName:(NSString *)name {
    _name = [name copy];
}

@end

@interface MemoryManageVC ()

@property (nonatomic, strong) Block block;
@property (nonatomic, strong) NSMutableArray *tempArray;

@property (nonatomic, strong) NSString *videoPath;

@property (nonatomic, strong) NSHashTable *hashTable;
@property (nonatomic, strong) NSMapTable  *mapTable;
@property (nonatomic, strong) NSPointerArray *pointerArray;
@property (nonatomic, strong) NSString *testStrongKey;
@property (nonatomic, strong) NSString *testWeakObj;

@end

@implementation MemoryManageVC

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [self testPropertyOne];
    
//    [self testPropertyTwo];
    
    [self testHashTableHashMapPointerArray];
    
//    [self testAutoVarARC];
    
//    [self testBlockMemoryManage];
    
//    [self testArgMemoryManage];
    
//    [self testNSEnumerator];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog (@"MemoryManageVC dealloc");
}

#pragma mark - Private methods

- (void)testPropertyOne {
    Rectangle *object = [[Rectangle alloc] init];
    NSMutableString *mStr = [NSMutableString stringWithFormat:@"Hello, world"];
    object.name = mStr;
    NSLog (@"mStr: %p object.name: %p", mStr, object.name);
}

- (void)testPropertyTwo {
    Rectangle *object = [[Rectangle alloc] init];
    NSString *mStr = [NSString stringWithFormat:@"Hello, world"];
    object.name = mStr;
    NSLog (@"mStr: %p object.name: %p", mStr, object.name);
}

- (void)testHashTableHashMapPointerArray {
//    先来看看NSPointerArray的特点有哪些
//
//    和传统的Array一样，可以有序的插入或移除
//    和传统的Array不一样的地方就是可以添加null作为内容，并且null参与count的计数
//    和传统的Array不一样，count可以set,多出来的元素null填充
//    可以用weak来修饰，存储weak指针
//    可以存储任何类型指针
//    实现了NSFastEnumeration，可以通过for..in来遍历

    
    self.hashTable = [NSHashTable weakObjectsHashTable];   //当用 weak 修饰时，对象被释放，则该对象移除
    self.mapTable = [NSMapTable strongToWeakObjectsMapTable];  //当用 weak 修饰 key 或 value 时，有一方被释放，则该键值对移除。
    self.pointerArray = [NSPointerArray weakObjectsPointerArray]; //当用 weak 修饰时，对象被释放，则该对象变为 NULL
    
    self.testStrongKey = [@"Strong key" mutableCopy];
    self.testWeakObj = [[@"Hello world" mutableCopy] copy];
    [self.hashTable addObject:self.testWeakObj];
    [self.mapTable setObject:self.testWeakObj forKey:self.testStrongKey];
    [self.pointerArray addPointer:(__bridge void *)self.testWeakObj];
    
    [(NSMutableString *)self.testStrongKey appendString:@" append after insert"];
    
    NSLog (@"self.hashTable: %@\nself.mapTable: %@\nself.pointerArray: %@", self.hashTable, self.mapTable, self.pointerArray);
//    NSLog (@"self.hashTable: %@\nself.mapTable: %@\nself.pointerArray: %@ %@", self.hashTable, self.mapTable, self.pointerArray, (__bridge id)[self.pointerArray pointerAtIndex:0]);
    
    self.testWeakObj = nil;
    
    NSLog (@"self.hashTable: %@\nself.mapTable: %@\nself.pointerArray: %@ %@", self.hashTable, self.mapTable, self.pointerArray, (__bridge id)[self.pointerArray pointerAtIndex:0]);
    
    
    
    
    
    
    
    NSHashTable *hashTable = [NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory];
    [hashTable addObject:@"hello"];
    {
        NSString *tmp = [NSString stringWithFormat:@"%@-%@", @"tmp", @"string"];
        [hashTable addObject:tmp];
    }
    [hashTable addObject:@10];
    [hashTable addObject:@"world"];
    [hashTable removeObject:@"world"];
    NSLog (@"Members: %@", [hashTable allObjects]);
    
    
    
    
    
    NSPointerArray *pointerArray = [[NSPointerArray alloc] initWithOptions:NSPointerFunctionsStrongMemory];
    pointerArray.count = 5;
    NSLog (@"pointerArray count: %tu\n%@\n", pointerArray.count, [pointerArray allObjects]);
    
    // 指定索引处的指针
    void *point = [pointerArray pointerAtIndex:0];//nil
    // 数组中添加指针对象
    [pointerArray addPointer:@"2"];//(2)
    // 移除指定索引处的元素
    [pointerArray removePointerAtIndex:0];//(2)
    // 指定索引出插入元素
    [pointerArray insertPointer:@"1" atIndex:0];//(1,2)
    // 替换指定索引处的对象
    [pointerArray replacePointerAtIndex:0 withPointer:@"2"];//(2,2)
    
    NSLog (@"\npointerArray at 0: %@\npointerArray at 1: %@\npointerArray at 5: %@\n",  (__bridge id)[pointerArray pointerAtIndex:0],
           (__bridge id)[pointerArray pointerAtIndex:1], (__bridge id)[pointerArray pointerAtIndex:5]);
    
    NSLog (@"\npointerArray count: %tu\n%@\n", pointerArray.count, [pointerArray allObjects]);
    
    // 删除数组中的nil值，NSPointerArray 可以存储 NULL，作为补充，它也提供了 compact 方法，用于剔除数组中为 NULL 的成员。但是 compact 函数有个已经报备的 bug：
//
//    NSPointerArray *array = [[NSPointerArray alloc] initWithOptions:NSPointerFunctionsWeakMemory];
//    array.count = 10;
//    [array addPointer:[NSObject new]];
//    // compact 调用之后，NULL 并未被剔除
//    [array compact];
//
//    出现这种 bug 的原因，和 compact 函数的实现机制有关，当我们主动给 NSPointerArray 添加 NULL 时，数组会标记有空元素插入，此时 compact 函数才会生效，也就是说，compact 函数会先判断是否有标记，之后才会剔除。所以，当直接 set count，或者成员已经释放，自动置空的情况出现时，就会出现这个 bug。解决也很简答：
//
//    // 在调用 compact 之前，手动添加一个 NULL，触发标记
//    [array addPointer:NULL];
//    [array compact];
    
    [pointerArray addPointer:NULL];
    [pointerArray compact];
    
    NSLog (@"\npointerArray at 0: %@\npointerArray at 1: %@\n",  (__bridge id)[pointerArray pointerAtIndex:0],
           (__bridge id)[pointerArray pointerAtIndex:1]);
    
    NSLog (@"\npointerArray count: %tu\n%@\n", pointerArray.count, [pointerArray allObjects]);
    
    // 获取数组的功能项
    NSPointerFunctions *functions = [pointerArray pointerFunctions];
    
    NSLog (@"pointerArray functions: %@\n", functions);
}

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
//  TestTemplateProject[18209:1891263] videoPath: eilotrm.ap1
//  TestTemplateProject[18209:1891263] pointer:0x0 - self:nil - superClass:nil
//  TestTemplateProject[18209:1891263] pointer:0x9488510100bef80d - self:NSTaggedPointerString - superClass:NSString
//  打开 scheme 设置中的 Zombie Object 没有出现 _NSZombie_NSTaggedPointerString 类名，说明传参数压栈默认都会 strong 强引用
}

- (void)testNSEnumerator {
//    // NSEnumerator
//    // 返回枚举的集合中的下一个对象。
//    - (nullable ObjectType)nextObject;
//    // 未列举的对象数组。
//    @property (readonly, copy) NSArray<ObjectType> *allObjects;
    
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5", nil];

    // 获取数组的枚举器
    NSEnumerator *enumerator = [array objectEnumerator];

    // 获取枚举器中所有的元素
    NSArray *arr = [enumerator allObjects];
    
//    [array removeObjectAtIndex:1];
    
    NSLog(@"arr = %@\n",arr);

    // 创建一个新的枚举器，遍历枚举器的元素
    enumerator = [array objectEnumerator];
    for (NSString *obj in enumerator) {
        NSLog(@"==%@",obj);
        
//        // 通过下面这个删除，可以大概看到 NSArray 的 NSEnumerator 实现（里面维护了一个 _currentIndex）
//        [array removeObjectAtIndex:0];
    }

    // 创建一个新的枚举器，遍历枚举器的元素
    enumerator = [array objectEnumerator];
    NSString *object;
    while (object = [enumerator nextObject]) {
        NSLog(@"开始打印：%@\n",object);
        
//        // 通过下面这个删除，可以大概看到 NSArray 的 NSEnumerator 实现（里面维护了一个 _currentIndex）
//        [array removeObjectAtIndex:0];
    }

    // 创建一个新的枚举器，遍历枚举器的元素
    enumerator = [array objectEnumerator];
    for (NSUInteger i = 0; i < array.count; i++) {
        NSLog(@"%@",enumerator.nextObject);
        
        // 通过下面这个删除，可以大概看到 NSArray 的 NSEnumerator 实现（里面维护了一个 _currentIndex）
        [array removeObjectAtIndex:0];
    }


//    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"obj0",@"key0",@"obj1",@"key1",@"obj2",@"key2",@"obj3",@"key3",@"obj4",@"key4", nil];
//    // 获取字典值的枚举器
//    NSEnumerator *objEnumerator = [dict objectEnumerator];
//    // 获取字典键的枚举器
//    NSEnumerator *keyEnumerator = [dict keyEnumerator];
}

@end




