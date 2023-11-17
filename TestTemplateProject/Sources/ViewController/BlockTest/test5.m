#include <stdio.h>
#import <Foundation/Foundation.h>

id getBlockArray() {
    int val = 12;
    NSArray *arr = [[NSArray alloc] initWithObjects:^{NSLog(@"block1 val = %d", val);},
                                                    ^{NSLog(@"block2 val = %d", val);},
                                                    nil];
    return arr;
}

typedef void (^MyBlock)(void);

int main(int argc, const char * argv[]) {
    id blkArray = getBlockArray();
    MyBlock block1 = blkArray[0];
    MyBlock block2 = blkArray[1]; // EXC_BAD_ACCESS, crash !!!
    
    // 实际情况不像帖子中说的那样会 crash
    // https://www.jianshu.com/p/357e250ca6c7
    // 竟然已经拷贝到堆中了

    block1();
    block2();

    return 0;
}




