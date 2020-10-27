//
//  YCWheelView.h
//  UI
//
//  Created by release on 2020/9/12.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YCWheelView : UIView

+(instancetype)wheelView;

//开始
-(void)startRotation;

//停止
-(void)stopRatation;

@end

NS_ASSUME_NONNULL_END
