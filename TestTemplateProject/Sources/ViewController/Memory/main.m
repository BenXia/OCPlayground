#import <Foundation/Foundation.h>

//clang -rewrite-objc main.m
//clang -fmodules main.m -o main
int main(int argc, char *argv[]) {
    @autoreleasepool {
        NSMutableArray *array = [NSMutableArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil];

        NSEnumerator *enumerator = [array objectEnumerator];

        // 通过快速迭代语法实现效果和下面的 [NSEnumerator nextObject] 实现结果是一样的
        // 说明 [NSEnumerator nextObject] 其中使用了 NSFastEnumerator 的实现
        for (NSString *obj in enumerator) {
            NSLog(@"==%@", obj);

            [array removeObjectAtIndex:1];
        }

        //NSString *obj;
        //while (obj = [enumerator nextObject]) {
        //    NSLog(@"==%@", obj);

        //    [array removeObjectAtIndex:0];
        //}


        //for (NSUInteger i = 0; i < array.count; i++) {
        //    NSLog(@"==%@", enumerator.nextObject);

        //    [array removeObjectAtIndex:2];
        //}

        return 0;
    }
}





