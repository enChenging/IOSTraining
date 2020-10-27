//
//  YCHeartView2.h
//  UI
//
//  Created by release on 2020/7/29.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCHeartModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YCHeartView2 : UIView

@property(nonatomic,strong)YCHeartModel *heartModel;

/**
 快速构造方法
 */
+(instancetype)HeartView2;

@end

NS_ASSUME_NONNULL_END
