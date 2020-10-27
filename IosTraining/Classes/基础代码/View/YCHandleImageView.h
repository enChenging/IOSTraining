//
//  YCHandleImageView.h
//  UI
//
//  Created by release on 2020/9/5.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class YCHandleImageView;
@protocol handleImageViewDelegate <NSObject>

-(void)handleImageView:(YCHandleImageView *)handleImageView newImage:(UIImage *) newImage;

@end
@interface YCHandleImageView : UIView

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,weak)id<handleImageViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
