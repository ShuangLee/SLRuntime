//
//  Person.h
//  LearnRuntime
//
//  Created by 光头强 on 16/7/13.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <Foundation/Foundation.h>
/*可以利用遍历类的属性，来快速的进行归档操作。
将从网络上下载的json数据进行字典转模型。*/
@interface Person : NSObject <NSCoding>
/**  名字 */
@property (nonatomic, copy) NSString *name;
/** 年龄 */
@property (nonatomic, assign) int age;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
