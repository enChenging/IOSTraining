//
//  YCBlueView.m
//  UI
//
//  Created by release on 2020/8/31.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCBlueView.h"

@interface YCBlueView()

@property(nonatomic,weak)IBOutlet UIButton *btn;

@end

@implementation YCBlueView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{

    //拿到后面的按钮
    //当点在按钮上的时候，才返回按钮，如果不在按钮上，保持系统默认做法
    
    //判断点在不在按钮身上
    //把当前的点转换到按钮身上的坐标系的点
    CGPoint btnP = [self convertPoint:point fromView:self.btn];
    if ([self.btn pointInside:btnP withEvent:event]) {
        return self.btn;
    }else{
        return [super hitTest:point withEvent:event];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"%s",__func__);
}
@end
