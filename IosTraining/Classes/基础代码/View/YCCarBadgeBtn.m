//
//  YCCarBadgeBtn.m
//  UI
//
//  Created by release on 2020/8/31.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCCarBadgeBtn.h"

@implementation YCCarBadgeBtn

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    //判断当前点是不是在popBtn身上
    if (self.popBtn) {
        CGPoint popBtnP = [self convertPoint:point fromView:self.popBtn];
        if ([self.popBtn pointInside:popBtnP withEvent:event]) {
            return self.popBtn;
        }else{
            return [super hitTest:point withEvent:event];
        }
    }else{
        return [super hitTest:point withEvent:event];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    
    //获取当前手指的点，上一个手指的点
    CGPoint curP = [touch locationInView:self];
    CGPoint preP = [touch previousLocationInView:self];
    //计算偏移量
    CGFloat offsetX = curP.x - preP.x;
    CGFloat offsetY = curP.y - preP.y;

    //平移
    self.transform = CGAffineTransformTranslate(self.transform, offsetX, offsetY);
    
}

@end
