//
//  SLOtherViewController.m
//  SLRuntime
//
//  Created by 光头强 on 16/10/9.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "SLOtherViewController.h"
#import "LsTool.h"
#import "Person.h"
#import "Person+Extension.h"
#import <objc/runtime.h> //包含对类、成员变量、属性、方法的操作
#import <objc/message.h> //包含消息机制

/*
 class_copyIvarList（）返回一个指向类的成员变量数组的指针
 class_copyPropertyList（）返回一个指向类的属性数组的指针
 注意：根据Apple官方runtime.h文档所示，上面两个方法返回的指针，在使用完毕之后必须free()。
 */

@interface SLOtherViewController ()
/** 数组 */
@property (nonatomic, strong) NSMutableArray *datas;
@end

@implementation SLOtherViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, 200, 30)];
    field.borderStyle = UITextBorderStyleRoundedRect;
    [LsTool hideKeyboard:field];
    [self.view addSubview:field];
    
    [self getIvarList];

    [self getPropertyList];
    
    //    [self testExchangeMethod];
    //
    //    [self testPerson];
    
    //读取归档数据
    //[self readAchiver];
    
    //动态修改属性值
    [self changeProperty];

}

/** 利用runtime遍历一个类的全部成员变量
 1.导入头文件<objc/runtime.h>     */
- (void)getIvarList {
    unsigned int outCount = 0;
    //Ivar:表示成员变量类型
    //获得一个指向该类成员变量的指针
    Ivar *ivars = class_copyIvarList([Person class], &outCount);
    for (int i = 0; i < outCount; i++) {
        //获得Ivar
        Ivar ivar = ivars[i];
        //根据ivar获得其成员变量的名称--->C语言的字符串
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        NSLog(@"成员变量：%d---%@",i,key);
    }
    
    free(ivars);
}

/** 利用runtime遍历一个类的全部属性 */
- (void)getPropertyList {
    unsigned int outCount = 0;
    //获得一个指向该类所有属性的指针
    objc_property_t *propertys = class_copyPropertyList([Person class], &outCount);
    for (int i = 0; i < outCount; i++) {
        //获得Ivar
        objc_property_t property = propertys[i];
        //根据objc_property_t获得其属性的名称--->C语言的字符串
        const char *name = property_getName(property);
        NSString *key = [NSString stringWithUTF8String:name];
        NSLog(@"属性：%d---%@",i,key);
    }
    
    free(propertys);
}

/**
 *  1.测试交换方法
 */
- (void)testExchangeMethod {
    self.datas = [NSMutableArray array];
    [self.datas addObject:@"Lee"];
    [self.datas addObject:@"Shawn"];
    [self.datas addObject:@"GTQ"];
    
    // 由于利用runtime对NSMutableArray类进行了扩展，此时不会崩溃。
    [self.datas addObject:nil];
}

/**
 *  测试Person类
 */
- (void)testPerson {
    Person *p = [[Person alloc] initWithDict:@{@"name":@"逗比",@"age":@24}];
    //2.获取文件路径
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [documentsPath stringByAppendingPathComponent:@"person.xxx"];
    NSLog(@"path=%@",path);
    
    //3.将自定义对象保存到文件
    [NSKeyedArchiver archiveRootObject:p toFile:path];
}

/**
 *  读取Person归档数据
 */
- (void)readAchiver {
    //1.获取文件路径
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documentsPath stringByAppendingPathComponent:@"person.xxx"];
    //2.从文件中读取对象
    Person *p = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"name=%@,age=%d",p.name,p.age);
}

/**
 *  2.动态变量控制
 */
- (void)changeProperty {
    Person *p = [[Person alloc] initWithDict:@{@"name":@"逗比",@"age":@24}];
    unsigned int count = 0;
    Ivar *ivar = class_copyIvarList([Person class], &count);
    for (int i = 0; i<count; i++) {
        Ivar var = ivar[i];
        
        //遍历属性找到对应name字段
        const char *varName = ivar_getName(var);
        NSString *name = [NSString stringWithUTF8String:varName];
        
        if ([name isEqualToString:@"_name"]) {
            //修改对应的字段值
            object_setIvar(p, var, @"光头强");
            break;
        }
    }
    NSLog(@"%@",p.name);
}

@end
