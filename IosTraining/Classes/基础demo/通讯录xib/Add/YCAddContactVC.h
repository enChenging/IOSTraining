//
//  YCAddContactVC.h
//  UI
//
//  Created by release on 2020/8/16.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class YCContactVC,YCContactItem;
@protocol YCAddContactVCDelegate <NSObject>

-(void)addViewController:(YCContactVC *)addViewController contact:(YCContactItem *)contactItem;

@end

@interface YCAddContactVC : UIViewController

@property(nonatomic,weak)id<YCAddContactVCDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
