//
//  YCRuntimeVC.m
//  IosTraining
//
//  Created by release on 2020/10/15.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCRuntimeVC.h"
#import "Person.h"
#import <objc/message.h>
#import "NSObject+Property.h"
#import "NSDictionary+Property.h"
#import "YCStatusItem.h"
#import "NSObject+Model.h"
/*
   runtime:必须要导入头文件 <objc/message.h>
   任何方法调用本质:发送一个消息,用runtime发送消息.OC底层实现通过runtime实现

   验证:方法调用,是否真的是转换为消息机制

   runtime都有一个前缀,谁的事情使用谁

*/
@interface YCRuntimeVC ()

@end

@implementation YCRuntimeVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self test];
//    [self test2];
//    [self test3];
//    [self test4];
    [self test5];
}

#pragma mark----------消息机制--------------
// 类方法本质:类对象调用[NSObject class]
// id:谁发送消息
// SEL:发送什么消息
// ((NSObject *(*)(id, SEL))(void *)objc_msgSend)([NSObject class], @selector(alloc));
// xcode6之前,苹果运行使用objc_msgSend.而且有参数提示
// xcode6苹果不推荐我们使用runtime

// 解决消息机制方法提示步骤
// 查找build setting -> 搜索msg
// 最终生成消息机制,编译器做的事情
// 最终代码,需要把当前代码重新编译,用xcode编译器,clang
// clang -rewrite-objc main.m 查看最终生成代码

/*
    内容5大区
    1.栈 2.堆 3.静态区 4.常量区 5.方法区
    1.栈:不需要手动管理内存,自动管理
    2.堆,需要手动管理内存,自己去释放
 */

/*
    runtime:方法都是有前缀,谁的事情谁开头
 
    开发中使用场景:
    需要用到runtime,消息机制
    1.不得不用runtime消息机制,可以帮我调用私有方法.
 */
-(void)test{
    // TODO:讲解下什么时候runtime,
    //    Person *p = [Person alloc];
    Person *p = objc_msgSend(objc_getClass("Person"), sel_registerName("alloc"));
    //    p = [p init];
    
    p = objc_msgSend(p, sel_registerName("init"));
    
    // 调用eat
    [p eat];
    
    objc_msgSend(p, @selector(eat));
    //    objc_msgSend(p, @selector(run:),20);
    
    // 面试:
    // 方法调用流程
    // 怎么去调用eat方法 ,对象方法:类对象的方法列表 类方法:元类中方法列表
    // 1.通过isa去对应的类中查找
    // 2.注册方法编号
    // 3.根据方法编号去查找对应方法
    // 4.找到只是最终函数实现地址,根据地址去方法区调用对应函数
    
    //    id objc = [NSObject alloc];
    id objc = objc_msgSend([NSObject class], @selector(alloc));
    
    //    objc = [objc init];
    objc = objc_msgSend(objc, @selector(init));
}

#pragma mark----------交换方法--------------
/*
   Runtime(交换方法):只要想修改系统的方法实现
   
   需求:

   比如说有一个项目,已经开发了2年,忽然项目负责人添加一个功能,每次UIImage加载图片,告诉我是否加载成功

   // 给系统的imageNamed添加功能,只能使用runtime(交互方法)
   // 1.给系统的方法添加分类
   // 2.自己实现一个带有扩展功能的方法
   // 3.交互方法,只需要交互一次,

   // 1.自定义UIImage

   // 2.UIImage添加分类

   弊端:
       1.每次使用,都需要导入
       2.项目大了,没办法实现

*/
-(void)test2{
    // imageNamed => xmg_imageNamed 交互这两个方法实现
    UIImage *image = [UIImage imageNamed:@"guide1.png"];
}


#pragma mark----------动态添加方法-------------
/*
   Runtime(动态添加方法):OC都是懒加载机制,只要一个方法实现了,就会马上添加到方法列表中.
   app:免费版,收费版
   QQ,微博,直播等等应用,都有会员机制
   
   美团有个面试题?有没有使用过performSelector,什么时候使用?动态添加方法的时候使用过?怎么动态添加方法?用runtime?为什么要动态添加方法?
*/
-(void)test3{
    
    Person *p = [[Person alloc] init];
    
    //执行某个方法
//    [p performSelector:@selector(eat)];
    
    [p performSelector:@selector(goRun:) withObject:@10];
}

#pragma mark----------动态添加属性-------------
// 动态添加属性:什么时候需要动态添加属性

// 开发场景
// 给系统的类添加属性的时候,可以使用runtime动态添加属性方法

// 本质:动态添加属性,就是让某个属性与对象产生关联

// 需求:让一个NSObject类 保存一个字符串

// runtime一般都是针对系统的类
-(void)test4{
    NSObject *objc = [[NSObject alloc] init];
    
    objc.name = @"123";
    
    NSLog(@"%@",objc.name);
}


#pragma mark----------字典转模型KVC实现-------------
-(void)test5{
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"status.plist" ofType:nil];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    //设计模型，创建属性代码 ==> dict
//    YCLog(@"==%@",dict);
//    [dict createPropertyCode];
    
    //字典转模型：KVC,MJExtension
    YCStatusItem *item = [YCStatusItem modelWithDict:dict];
//    YCLog(@"===%@",item.user);
}

@end
