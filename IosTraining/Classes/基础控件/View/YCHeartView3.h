//
//  YCHeartView3.h
//  UI
//
//  Created by release on 2020/7/29.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class YCHeartModel;
@interface YCHeartView3 : UIButton

@property(nonatomic,strong)YCHeartModel *heartModel;

+(instancetype)heartView3;
@end

NS_ASSUME_NONNULL_END
