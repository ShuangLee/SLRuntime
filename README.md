# SLRuntime

### 一、runtime简介
*	RunTime简称运行时。OC就是`运行时机制`，也就是在运行时候的一些机制，其中最主要的是消息机制。
*	对于C语言，`函数的调用在编译的时候会决定调用哪个函数`。
*	对于OC的函数，属于`动态调用过程`，在编译的时候并不能决定真正调用哪个函数，只有在真正运行的时候才会根据函数的名称找到对应的函数来调用。
*	事实证明：
	*	在编译阶段，OC可以`调用任何函数`，即使这个函数并未实现，只要声明过就不会报错。
	*	在编译阶段，C语言调用`未实现的函数`就会报错。
	
### 二、runtime作用
####1.发送消息
*	方法调用的本质，就是让对象发送消息。
*	objc_msgSend,只有对象才能发送消息，因此以objc开头.
*	使用`消息机制`前提，必须导入#import <objc/message.h>
*	消息机制简单使用
*	clang -rewrite-objc main.m 查看最终生成代码

```
 	// 创建person对象
    Person *p = [[Person alloc] init];
    
    // 调用对象方法
    [p eat];
    
    // 本质：让对象发送消息
    objc_msgSend(p, @selector(eat));

    // 调用类方法的方式：两种
    // 第一种通过类名调用
    [Person eat];
    // 第二种通过类对象调用
    [[Person class] eat];
    
    // 用类名调用类方法，底层会自动把类名转换成类对象调用
    // 本质：让类对象发送消息
    objc_msgSend([Person class], @selector(eat));

```

####2.交换方法
*	开发使用场景:系统自带的方法功能不够，给系统自带的方法扩展一些功能，并且保持原有的功能。
*	方式一:继承系统的类，重写方法.
*	方式二:使用runtime,交换方法.

####3.动态添加方法
* 开发使用场景：如果一个类方法非常多，加载类到内存的时候也比较耗费资源，需要给每个方法生成映射表，可以使用动态给某个类，添加方法解决。
* 经典面试题：有没有使用performSelector，其实主要想问你有没有动态添加过方法。
* 简单使用

####4.给分类添加属性
* 原理：给一个类声明属性，其实本质就是给这个类添加关联，并不是直接把这个值的内存空间添加到类存空间。

####5.字典转模型
* 设计模型：字典转模型的第一步
	* 模型属性，通常需要跟字典中的key一一对应
	* 问题：一个一个的生成模型属性，很慢？
	* 需求：能不能自动根据一个字典，生成对应的属性。
	* 解决：提供一个分类，专门根据字典生成对应的属性字符串。
	
* 字典转模型的方式一：KVC

```
@implementation Status


+ (instancetype)statusWithDict:(NSDictionary *)dict
{
    Status *status = [[self alloc] init];
    
    [status setValuesForKeysWithDictionary:dict];
    
    return status;
    
}

@end

```


*	KVC字典转模型弊端：必须保证，模型中的属性和字典中的key一一对应。
	*	如果不一致，就会调用`[<Status 0x7fa74b545d60> setValue:forUndefinedKey:]`
报`key`找不到的错。	
	*  分析:模型中的属性和字典的key不一一对应，系统就会调用`setValue:forUndefinedKey:`报错。
	*  解决:重写对象的`setValue:forUndefinedKey:`,把系统的方法覆盖，
就能继续使用KVC，字典转模型了。

```
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

```

* 字典转模型的方式二：Runtime
	* 思路：利用运行时，遍历模型中所有属性，根据模型的属性名，去字典中查找key，取出对应的值，给模型的属性赋值。
	* 步骤：提供一个NSObject分类，专门字典转模型，以后所有模型都可以通过这个分类转。 
 