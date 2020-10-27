//
//  YCWheelBtn.m
//  UI
//
//  Created by release on 2020/9/14.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCWheelBtn.h"

@implementation YCWheelBtn

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    CGRect rect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height * 0.5);

    if (CGRectContainsPoint(rect, point)) {
        //在指定的范围内
        return [super hitTest:point withEvent:event];
    }else{
        return nil;
    }
}

/**
 返回当前按钮当中图片的位置尺寸
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat w = 40;
    CGFloat h = 48;
    CGFloat x = (contentRect.size.width - w) * 0.5;
    CGFloat y = 20;
    return CGRectMake(x, y, w, h);
}
/**
 取消高亮状态下做的事件
 */
- (void)setHighlighted:(BOOL)highlighted{
    
}

@end
