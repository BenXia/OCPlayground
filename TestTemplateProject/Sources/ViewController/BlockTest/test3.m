#include <stdio.h>
#import <Foundation/Foundation.h>

@interface TestClass: NSObject

@end

@implementation TestClass

_Pragma("clang diagnostic push")
_Pragma("clang diagnostic ignored \"-Wreceiver-is-weak\"")
- (void)testWithWeakObj:(__weak NSObject*)object {
    NSObject *strongObject = object;

    NSLog (@"%@", strongObject);
}
_Pragma("clang diagnostic pop")

@end

int main() {
    typedef void (^blk_t)();

    blk_t blk;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    blk = [^(){
        [[[TestClass alloc] init] testWithWeakObj:array];
    } copy];

    blk();
}




