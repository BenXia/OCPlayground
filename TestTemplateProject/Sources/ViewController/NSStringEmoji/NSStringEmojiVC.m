//
//  NSStringEmojiVC.m
//  TestTemplateProject
//
//  Created by Ben on 2017/6/12.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "NSStringEmojiVC.h"

@interface NSStringEmojiVC ()

@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation NSStringEmojiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // NSString 的很多操作语义上是按照 utf16 码元编码后对码元的操作
    NSString *strContainEmoji = @"dog🐶";
    self.textLabel.text = strContainEmoji;
    NSLog(@"strContainEmoji len: %lu, : %@", strContainEmoji.length, strContainEmoji);
    
    NSUInteger strLen = [strContainEmoji length];
    NSString *strRemoveLast = [strContainEmoji substringToIndex:strLen - 1];
    NSLog(@"strRemoveLast len: %lu : %@", strRemoveLast.length, strRemoveLast);
    
    // 正确的删除方式应该是下面这样：
    NSRange range = [strContainEmoji rangeOfComposedCharacterSequenceAtIndex:strContainEmoji.length-1];
    NSString *strRemoveEmoji = [strContainEmoji substringToIndex:range.location];
    NSLog(@"emoji location:%lu len: %lu", range.location, range.length);
    NSLog(@"strRemoveEmoji len: %lu : %@", strRemoveEmoji.length, strRemoveEmoji);
    
    
    // 下面是一个含有组合形式的 emoji 表情符号的例子
    // 查看表情编码地址：https://apps.timwhitlock.info/unicode/inspect
    //NSString *compoundEmojiStr = @"👩‍👩‍👦‍👦";
    NSString *compoundEmojiStr = @"a中👩‍👩‍👦‍👦";  // 改成 "a中👩‍👩‍👦‍👦" 再试试
    NSData *compoundEmojiUTF8Data = [compoundEmojiStr dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"compoundEmojiStr len: %lu", compoundEmojiStr.length);
    NSLog(@"compoundEmojiUTF8Data len: %lu", compoundEmojiUTF8Data.length);
    
    NSRange emojiRange = [compoundEmojiStr rangeOfComposedCharacterSequenceAtIndex:compoundEmojiStr.length-1];
    NSString *strAfterRemoveEmoji = [compoundEmojiStr substringToIndex:emojiRange.location];
    NSLog(@"emoji location:%lu len: %lu", emojiRange.location, emojiRange.length);
    NSLog(@"strAfterRemoveEmoji len: %lu : %@", strAfterRemoveEmoji.length, strAfterRemoveEmoji);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
  // 使用 property 才能使用这种点语法
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end




