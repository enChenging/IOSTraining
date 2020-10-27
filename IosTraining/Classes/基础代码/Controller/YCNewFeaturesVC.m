//
//  YCNewFeaturesVC.m
//  IosTraining
//
//  Created by release on 2020/10/15.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCNewFeaturesVC.h"
#import "IOS.h"
#import "Java.h"
#import "Language.h"
#import "Person.h"
#import "SubPerson.h"

@interface YCNewFeaturesVC ()

@end

@implementation YCNewFeaturesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark-------------------关键字---------------------------
/*
 怎么去研究新特性? 1.使用新的xcode创建项目,用旧的xcode去打开
 Xcode12 2020 iOS14
 Xcode11 2019 iOS13
 Xcode10 2018 iOS12
 Xcode9 2017 iOS11
 Xcode8 2016 iOS10
 Xcode7 2015 iOS9
 Xcode6 2014 iOS8
 Xcode5 2013 iOS7
 Xcode4 2012 iOS6
 
 1.出了哪些新特性 iOS9:关键字:可以用于属性,方法返回值和参数中
 关键字作用:提示作用,告诉开发者属性信息
 关键字目的:迎合swift,swift是个强语言,swift必须要指定一个对象是否为空
 关键字好处:提高代码规划,减少沟通成本
 关键字仅仅是提供警告,并不会报编译错误
 null_resettable
 
 */

/*
    nullable:1.怎么使用(语法) 2.什么时候使用(作用)
    nullable作用:可能为空
 
    nullable 语法1
    @property (nonatomic, strong, nullable) NSString *name;
 
    nullable 语法2 * 关键字 变量名
    @property (nonatomic, strong) NSString * _Nullable name;
 
    nullable 语法3
    @property (nonatomic, strong) NSString * __nullable name;
 
 */

/*
 nonnull:1.怎么使用(语法) 2.什么时候使用(作用)
 nonnull作用:不能为空
 
 nonnull 语法1
 @property (nonatomic, strong, nullable) NSString *name;
 
 nonnull 语法2 * 关键字 变量名
 @property (nonatomic, strong) NSString * _Nonnull name;
 
 nonnull 语法3
 @property (nonatomic, strong) NSString * __nonnull name;
 
 */

/*
 
 null_resettable:1.怎么使用(语法) 2.什么时候使用(作用)
 
 null_resettable:必须要处理为空情况,重写get方法
 
 null_resettable作用:get方法不能返回nil,set可以传入为空
 
 null_resettable 语法1
 @property (nonatomic, strong, null_resettable) NSString *name;
 
 */

/*
    _Null_unspecified:不确定是否为空
 */

/*
    关键字注意点
    在NS_ASSUME_NONNULL_BEGIN和NS_ASSUME_NONNULL_END之间默认是nonnull
    
    关键字不能用于基本数据类型(int,float),nil只用于对象
 
 
 */

#pragma mark-------------------泛型---------------------------
/*
   泛型:限制类型
   为什么要推出泛型?迎合swift

   泛型作用:1.限制类型 2.提高代码规划,减少沟通成本,一看就知道集合中是什么东西
   泛型定义用法:类型<限制类型>
   泛型声明:在声明类的时候,在类的后面<泛型名称>
   泛型仅仅是报警告
   泛型好处:1.从数组中取出来,可以使用点语法
           2.给数组添加元素,有提示
   
   泛型在开发中使用场景:1.用于限制集合类型

   id是不能使用点语法

   为什么集合可以使用泛型?使用泛型,必须要先声明泛型? => 如何声明泛型

   自定义泛型?
   什么时候使用泛型?在声明类的时候,不确定某些属性或者方法类型,在使用这个类的时候才确定,就可以采用泛型

   自定义Person,会一些编程语言(iOS,Java),在声明Person,不确定这个人会什么,在使用Person才知道这个Person会什么语言
   如果没有定义泛型.默认就是id
 
   用于父子类型转换
   泛型:__covariant:协变, 子类转父类

       __contravariant:逆变 父类转子类
 
   泛型注意点:在数组中,一般用可变数组添加方法,泛型才会生效,如果使用不可变数组,添加元素,泛型没有效果
*/

-(void)fanXing{
    Java *java = [[Java alloc]init];
    IOS *ios = [[IOS alloc]init];
    
    //ios
    Person<IOS *> *p = [[Person alloc]init];
    p.language = ios;
    
    //java
    Person<Java *> *p1 = [[Person alloc]init];
    p1.language = java;
}

#pragma mark-------------------协变,逆变---------------------------
/**
 __covariant:协变, 子类转父类
 */
- (void)covariant
{
    IOS *ios = [[IOS alloc] init];
    
    // iOS
    Person<IOS *> *p = [[Person alloc] init];
    p.language = ios;
    
    // Language
    Person<Language *> *p1;
    p1 = p;

}

/**
 __contravariant:逆变 父类转子类
 */
-(void)contravariant{
    
    Language *language = [[Language alloc] init];
    
    Person<Language *> *p = [[Person alloc] init];
    p.language = language;
    
    // iOS
    Person<IOS *> *p1 = [[Person alloc] init];
    p1 = p;
}

#pragma mark-------------------__kindof---------------------------
/*
   kindof:相当于

   __kindof:表示当前类或者它的子类'

   类设计历史

   id:可以调用任何对象方法,不能进行编译检查
*/


@end
