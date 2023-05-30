#include <stdio.h>

// 测试 forwarding->val

//struct BlockVar {
//    void *__isa;
//    __Block_byref_val_0 *__forwarding;
//};

int main() {
    __block int val = 0;
    
    void (^blk)(void) = [^{++val;} copy];
    ++val;
    
    blk();
    
    blk = NULL;
    // 内存调试，发现 __block 栈中变量 __forwarding 还是指向堆中，说明一旦复制到堆中，栈中对堆中的引用计数将加1
    
    ++val;

    return 0;
}




