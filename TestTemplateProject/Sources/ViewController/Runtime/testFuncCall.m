//
//  testFuncCall.m
//  TestTemplateProject
//
//  Created by Ben on 2023/11/20.
//  Copyright © 2023年 iOSStudio. All rights reserved.
//

// 代码编译至汇编代码
// clang -S testFuncCall.m -o testFuncCall.s

int add(int a, int b) {
    return a + b;
}

int main() {
    int x = 10;
    int y = 20;
    int ret = add(x, y);

    return ret;
}




