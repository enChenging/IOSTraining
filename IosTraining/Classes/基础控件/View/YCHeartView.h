//
//  YCHeartView.h
//  UI
//
//  Created by release on 2020/7/11.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YCHeartModel;//仅仅引用，不会发生交叉编译
@interface YCHeartView : UIView

//心模型
@property(nonatomic,strong)YCHeartModel *heartModel;

//构造方法
-(instancetype)initWithHartModel:(YCHeartModel *)heartModel;
+(instancetype)HeartViewWithHartModel:(YCHeartModel *)heartModel;

@end

NS_ASSUME_NONNULL_END
