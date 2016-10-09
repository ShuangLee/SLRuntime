//
//  LsTool.h
//  LearnRuntime
//
//  Created by 光头强 on 16/8/4.
//  Copyright © 2016年 Ls. All rights reserved.
//  定义一个工具类来隐藏键盘
/*
 * runtime实际的应用，给键盘添加一个缩回的按钮，以UITextField为例，原理如下：
 给键盘添加ToolBar， ToolBar上有一个具有缩回功能的button
 将UITextField绑定到这个button上
 添加缩回的方法，在方法中通过button获取这个UITextField，调用这个UITextField的
 resignFirstResponder方法即可
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LsTool : NSObject
#pragma mark - 增加隐藏键盘按钮
+ (void)hideKeyboard:(UITextField *)textfield;
@end
