//
//  YCStatus.h
//  UI
//
//  Created by release on 2020/8/7.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface YCStatus : NSObject

@property(nonatomic,copy)NSString *icon;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *text;

@property(nonatomic,copy)NSString *picture;

@property(nonatomic,assign,getter=isVip)Boolean vip;


@property(nonatomic,assign)CGRect iconFrame;

@property(nonatomic,assign)CGRect nameFrame;

@property(nonatomic,assign)CGRect vipFrame;

@property(nonatomic,assign)CGRect textFrame;

@property(nonatomic,assign)CGRect pictureFrame;

@property(nonatomic,assign)CGFloat cellHeight;

@end

NS_ASSUME_NONNULL_END
