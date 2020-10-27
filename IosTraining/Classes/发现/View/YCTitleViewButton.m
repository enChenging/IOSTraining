//
//  YCTitleViewButton.m
//  UI
//
//  Created by release on 2020/9/18.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCTitleViewButton.h"

@implementation YCTitleViewButton



- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.imageView.x < self.titleLabel.x) {
        //调整子控件位置
        //调整lable
        self.titleLabel.x = self.imageView.x;
        //调整imageView
        self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
    }
    
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state{
    [super setImage:image forState:state];
    
    [self sizeToFit];
}

@end
