//
//  VCPassByValue.h
//  UI
//
//  Created by release on 2019/11/14.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//定义代理协议
@protocol VCPassByValueDelegate <NSObject>
//定义一个协议函数
-(void)sendTextContent:(NSString*)content;

//block正向传值
typedef void (^Block)(NSString *value);

@end

@interface VCPassByValue : UIViewController

//定义一个代理对象 来实现协议函数，达到代理对象改变本身属性的目的
//代理对象一定要实现代理协议
@property(nonatomic,strong)id<VCPassByValueDelegate> pbv1delegate;

@property(nonatomic,strong)UILabel* mlabel02;

@property(nonatomic,strong)UILabel* mlabel03;

@property(nonatomic,copy)NSString* mName;
//block正向传值
@property(nonatomic,copy)Block valueBlock;
/**
 ①instancetype可以返回和方法所在类相同类型的对象，id只能返回未知类型的对象
 ②instancetype只能作为返回值，不能像id那样作为参数
 
 前置加号（+）的方法为类方法，这类方法是可以直接用类名来调用的，它的作用主要是创建一个实例。有人把它称为创建实例的工厂方法。
 前置减号（-）的方法为实例方法，必须使用类的实例才可以调用的。
 */
+(instancetype)initInstance;//共享单例方法

@end

NS_ASSUME_NONNULL_END
