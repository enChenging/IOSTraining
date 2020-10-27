//
//  UITouchViewController.m
//  UI
//
//  Created by release on 2019/11/11.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import "UITouchViewController.h"

@interface UITouchViewController ()
{
    UIImageView* _imageView;
    CGPoint _lastPoint;
}
@end

@implementation UITouchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

-(void)initView{
    _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"guide_1"]];
    _imageView.frame = CGRectMake(100, 100, 200, 340);
    [self.view addSubview:_imageView];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch*touch = [touches anyObject];
    if (touch.tapCount == 1) {
        YCLog(@"单次点击------");
    }else if (touch.tapCount == 2){
        YCLog(@"双次点击------");
    }
    YCLog(@"手指触碰瞬间");
    
    _lastPoint = [touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
   
    UITouch*touch = [touches anyObject];
    CGPoint pt= [touch locationInView:self.view];
    YCLog(@"x==%f   y==%f",pt.x,pt.y);
    
    float xOffset = pt.x - _lastPoint.x;
    float yOffset = pt.y - _lastPoint.y;
    
    _imageView.frame = CGRectMake(_imageView.frame.origin.x + xOffset,
                                         _imageView.frame.origin.y + yOffset,
                                         _imageView.frame.size.width,
                                         _imageView.frame.size.height);
    _lastPoint = pt;
//    YCLog(@"手指移动时调用");
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    YCLog(@"手指离开时调用");
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    YCLog(@"特殊情况，中断触屏事件时调用");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
