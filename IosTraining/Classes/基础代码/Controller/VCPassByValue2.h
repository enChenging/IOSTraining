//
//  VCPassByValue2.h
//  UI
//
//  Created by release on 2019/11/14.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//block属性反向传值
typedef void(^ReceiveValueBlock)(NSString* value);
//block方法反向传值
typedef void(^VCPassByValueBlock)(NSString* str);
//代理反向传值
@protocol VCPassByValue2Delegate <NSObject>

-(void)sendMessage:(NSString*)message;

@end

@interface VCPassByValue2 : UIViewController

@property(nonatomic,strong)NSString* propertyValue;

@property(nonatomic,strong)NSString* methodValue;
//代理反向传值
@property(nonatomic,strong)id<VCPassByValue2Delegate>pbv2delegate;
//block属性反向传值
@property(nonatomic,copy)ReceiveValueBlock receiveValue;
//block方法反向传值
-(void)sendBlockMessage:(NSString*)msg andBlock:(VCPassByValueBlock)block;

@property(nonatomic,strong)UILabel* mlabel04;

@property(nonatomic,strong)NSString* data;

@property(nonatomic,strong)NSString* mKvcText;

@end

NS_ASSUME_NONNULL_END
