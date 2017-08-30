//
//  JSONToModelVC.m
//  TestTemplateProject
//
//  Created by Ben on 2017/8/27.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "JSONToModelVC.h"
#import "ModelForJSONModel.h"
#import "ModelForMantle.h"
#import "ModelForYYModel.h"
#import "ModelForMJExtension.h"


/**
 *
 * 注意其中对[NSNull null]、嵌套Model、NSArray中为Model、字段需要换转处理、可选字段支持、未知字段(向后兼容）、编解码等支持情况
 *
 */


@interface JSONToModelVC ()

@property (nonatomic, copy) id JSONDict;

@property (nonatomic, strong) UserForMantle *userForMantle;

@end

@implementation JSONToModelVC

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 对应模型的特点: 1、有NSNull对象, 2、模型里面嵌套模型, 3、模型里面有数组，数组里面有模型.
    self.JSONDict = [self getJSONObject];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)testJSONModelUsage:(UIButton *)sender {
    // JSON->Model
    UserForJSONModel *user = [[UserForJSONModel alloc] initWithDictionary:self.JSONDict error:nil];
    // Model->JSON
    NSDictionary *dict = [user toDictionary];
}

- (IBAction)testMantleUsage:(id)sender {
    // 注意: Mantle不会自动转类型，如：String->Int, 一旦类型不匹配，直接crash
    // Json->Model
    // 该方法会调用key-key map方法。
    self.userForMantle = [MTLJSONAdapter modelOfClass:[UserForMantle class] fromJSONDictionary:self.JSONDict error:nil];
    // 这种方式只是简单的使用KVC进行赋值。不会调用key-key map方法, 要求属性和JSON字典中的key名称相同，否则就crash
    //    self.userForMantle = [UserForMantle modelWithDictionary:self.JSONDict error:&error];
    
    // Model -> JSON
    // 一旦有属性为nil, Mantle会转换成NSNull对象放到JSON字典中，这里有一个坑，使用NSUserDefault存储这样的JSON字典时，程序crash，原因是不可以包含NSNull对象。
    NSDictionary *jsonDict = [MTLJSONAdapter JSONDictionaryFromModel:self.userForMantle error:nil];
    
    NSLog (@"jsonDict:\n%@", jsonDict);
}

- (IBAction)testYYModelUsage:(id)sender {
    
}

- (IBAction)testMJExtensionUsage:(id)sender {
    
    
}

#pragma mark - Utility methods

- (id)getJSONObject {
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *filePath = [mainBundle pathForResource:@"test" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSError *error;
    id content = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    return content;
}

@end


// MJExtension 一些异常处理
//这个的使用方式就不介绍了，GitHub上写的非常详细。这里主要说说我在用的项目中时遇到问题及解决方式。情况大致是这样的: 最开始项目中的模型统统继承自BaseModel类，解析方式都是自己挨个手动解析。还自定义了一些譬如时间戳转自定义日期类型的方法。在换到MJExtension时，没法对我们的自定义解析方式进行兼容，全部重写肯定是不现实的，只能做兼容。最后通过阅读MJExtension的源码，找到了一个突破口。在BaseModel里面对MJExtension里面的一个方法使用Method Swizzling进行替换。大致代码如下:

///// json->模型，转换完成之后调用, 以便进行自定义配置。
//- (void)mc_keyValuesDidFinishConvertingToObjectWithData:(id)data;
//
////这样在使用MJExtension将模型解析完成之后再调用mc_keyValuesDidFinishConvertingToObjectWithData: 将原始数据传递过去进行自定义配置。就可以很好的与老工程兼容了。
//@implementation ModelForMJExtension
//
///* 替换方法: - (instancetype)setKeyValues:(id)keyValues context:(NSManagedObjectContext *)context error:(NSError **)error; */
//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Class class = [self class];
//        
//        SEL originalSelector = @selector(setKeyValues:context:error:);
//        SEL swizzledSelector = @selector(mc_setKeyValues:context:error:);
//        Method originalMethod = class_getInstanceMethod(class, originalSelector);
//        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
//        
//        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
//        if (success) {
//            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
//        } else {
//            method_exchangeImplementations(originalMethod, swizzledMethod);
//        }
//    });
//}
//
////- (instancetype)mc_setKeyValues:(id)keyValues context:(NSManagedObjectContext *)context error:(NSError **)error {
////    MCDataModel *model = [self mc_setKeyValues:keyValues context:context error:error];
////    if ([self respondsToSelector:@selector(mc_keyValuesDidFinishConvertingToObjectWithData:)]) {
////        [self mc_keyValuesDidFinishConvertingToObjectWithData:keyValues];
////    }
////    return model;
////}
//
//@end




//Mantle,JSONModel,MJExtension防崩溃比较:
//对于这样一条数据:
//
//{
//    "firstName": "张",
//    "lastName": "三",
//    "age": 23,
//    "height": 172.3,
//    "weight": 51.2,
//    "sex": true
//}
//客户端属性声明为:
//@property (nonatomic, copy) NSString *age;
//
//Mantle的模型赋值:
//
//if (![obj validateValue:&validatedValue forKey:key error:error]) return NO;
//if (forceUpdate || value != validatedValue)
//{
//    [obj setValue:validatedValue forKey:key];
//}
//return YES;
//它是使用了KVC的- (BOOL)validateValue:(inout id __nullable * __nonnull)ioValue
//forKey:(NSString *)inKey error:(out NSError **)outError;方法来验证要赋的值的类型是否和key的类型是否匹配.该方法默认会调用a
//validator method whose name matches the pattern -validate<Key>:error:.因此我们还需要在模型里面写一个这样的方法:
//
//-(BOOL)validateAge:(id *)ioValue error:(NSError * __autoreleasing *)outError
//{
//    if ([*ioValue isKindOfClass:[NSNumber class]])
//    {
//        return YES;
//    }
//    return NO;
//}
//如果没写默认返回YES.Mantle貌似并没有帮我们做这么一步,所以如果你自己没写的话,那么上述验证的方法会返回YES.好的程序不应该总是期望服务器端永远都返回正确的东西,然而我们又无法知道服务器哪些字段会返回和我们不一致的类型.难道每一个属性都要写一个-validate<Key>:error:来判断?个人认为在这一点上Mantle做的很鸡肋.如果你没写-validate<Key>:error:而碰巧服务器端返回一个数字类型,那么你的程序很有可能会崩溃.
//
//对于JSONModel的模型赋值:
//
////check for custom transformer
//BOOL foundCustomTransformer = NO;
//if ([valueTransformer respondsToSelector:selector]) {
//    foundCustomTransformer = YES;
//} else {
//    //try for hidden custom transformer
//    selectorName = [NSString stringWithFormat:@"__%@",selectorName];
//    selector = NSSelectorFromString(selectorName);
//    if ([valueTransformer respondsToSelector:selector]) {
//        foundCustomTransformer = YES;
//    }
//}
//
////check if there's a transformer with that name
//if (foundCustomTransformer) {
//    
//    //it's OK, believe me...
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
//    //transform the value
//    jsonValue = [valueTransformer performSelector:selector withObject:jsonValue];
//#pragma clang diagnostic pop
//    
//    if (![jsonValue isEqual:[self valueForKey:property.name]]) {
//        [self setValue:jsonValue forKey: property.name];
//    }
//    
//} else {
//    
//    // it's not a JSON data type, and there's no transformer for it
//    // if property type is not supported - that's a programmer mistake -> exception
//    @throw [NSException exceptionWithName:@"Type not allowed"
//                                   reason:[NSString stringWithFormat:@"%@ type not supported for %@.%@", property.type, [self class], property.name]
//                                 userInfo:nil];
//    return NO;
//}
//可以看到它有做一个转换,对于一般的服务端数字,客户端NSString,或服务器端字符,客户端NSNumber,这样比较简单的转换,JSONModel已经帮我们实现好了,但是如果服务器端返回一个数组,但是客户端是NSString,那么这需要我们自己按照它的格式去写一个转换的方法,如果没写的话,JSONModel会抛出一个异常.然而通常我们需要服务器端传错了,我们客户端应该不崩溃,而是将对应的字段赋值为nil.
//
//对于MJExtension的模型赋值:
//由于MJ的考虑的情况比较全面,代码较多,有兴趣的可以自己去看,这里只截取最后一部分:
//
//// value和property类型不匹配
//if (propertyClass && ![value isKindOfClass:propertyClass])
//{
//    value = nil;
//}
//可以看到如果类型不匹配那么对应的属性将被赋值为nil.而这些不需要我们写任何代码,可以的.最为厉害的就是当服务器传字符,客户端为NSUInteger类型时,Mantle,JSONModel都会崩溃,而MJ不会崩溃,且正确转换.
//综上防崩溃最强的当属MJExtension,如果服务器端开发人员很菜的话强烈推荐使用MJExtension.







