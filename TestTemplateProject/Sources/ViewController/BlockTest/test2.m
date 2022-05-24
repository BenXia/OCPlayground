#include <stdio.h>
#import <Foundation/Foundation.h>

int main() {
    typedef void (^blk_t)(id obj);

    blk_t blk;
    {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        blk = ^(id obj){
            [array addObject:obj];
            NSLog(@"array count = %ld", [array count]);
        };
    }

    blk([[NSObject alloc] init]);
}
