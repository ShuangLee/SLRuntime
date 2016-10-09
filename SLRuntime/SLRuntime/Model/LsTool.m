//
//  LsTool.m
//  LearnRuntime
//
//  Created by 光头强 on 16/8/4.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "LsTool.h"
#import <objc/runtime.h>

//获取屏幕宽度的宏
#define ScreenWidth ([[UIScreen mainScreen] bounds].size.width)
static const void *kTextField = "textField";
@implementation LsTool
#pragma mark - 增加隐藏键盘按钮
+ (void)hideKeyboard:(UITextField *)textfield {
    //为键盘增加工具栏
    UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(2, 5, 80, 25);
    //将TextField绑定到button上
    objc_setAssociatedObject(btn, kTextField, textfield, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [btn addTarget:self action:@selector(dismissKeyBoard:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"收起键盘" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //[btn setBackgroundImage:[UIImage imageNamed:@"closed"] forState:UIControlStateNormal];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneBtn,nil];
    [topView setItems:buttonsArray];
    [textfield setInputAccessoryView:topView];
}

+ (void)dismissKeyBoard:(UIButton *)button{
    //获取button上对应的属性
    [objc_getAssociatedObject(button, kTextField) resignFirstResponder];
}
@end
