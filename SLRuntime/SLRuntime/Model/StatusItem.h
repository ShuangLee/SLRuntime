//
//  StatusItem.h
//  SLRuntime
//
//  Created by 光头强 on 16/10/8.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;
// 设计模型有哪些属性 => 字典
// KVC:模型中属性必须与字典中key一一对应
@interface StatusItem : NSObject

@property (nonatomic, strong) NSString *source;

@property (nonatomic, assign) NSInteger reposts_count;

@property (nonatomic, strong) NSArray *pic_urls;

@property (nonatomic, strong) NSString *created_at;

@property (nonatomic, assign) NSInteger attitudes_count;

@property (nonatomic, strong) NSString *idstr;

@property (nonatomic, strong) NSString *text;

@property (nonatomic, assign) NSInteger comments_count;

@property (nonatomic, strong) User *user;

+ (instancetype)itemWithDict:(NSDictionary *)dict;
@end
