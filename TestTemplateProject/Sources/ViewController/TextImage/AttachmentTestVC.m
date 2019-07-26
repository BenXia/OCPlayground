//
//  AttachmentTestVC.m
//  TestTemplateProject
//
//  Created by Ben on 2019/7/26.
//  Copyright © 2019 iOSStudio. All rights reserved.
//

#import "AttachmentTestVC.h"

@interface AttachmentTestVC ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation AttachmentTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self themeTitleLabel:@"暂无待沟通老师" tipIconName:@"blank_icon_contacts"];
}

- (void)themeTitleLabel:(NSString *)title tipIconName:(NSString *)tipIconName {
    if (tipIconName.length > 0) {
        //1.创建一个可变属性字符串
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:title];
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, title.length)];
        [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, title.length)];
        //2.创建图片附件
        NSTextAttachment *attach = [[NSTextAttachment alloc]init];
        attach.image = [UIImage imageNamed:tipIconName];
        attach.bounds = CGRectMake(0, -5, 20, 20);
        //3.创建属性字符串 通过图片附件
        NSAttributedString *attrStr = [NSAttributedString attributedStringWithAttachment:attach];
        //4.把NSAttributedString添加到NSMutableAttributedString里面
        [string appendAttributedString:attrStr];
        //5.赋值给UIlabel
        self.titleLabel.attributedText = string;
    } else {
        self.titleLabel.text = title;
    }
}

@end


