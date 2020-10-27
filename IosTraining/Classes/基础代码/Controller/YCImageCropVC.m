//
//  YCImageCropVC.m
//  UI
//
//  Created by release on 2020/9/2.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCImageCropVC.h"

@interface YCImageCropVC ()

@property(nonatomic,assign)CGPoint startP;
@property(nonatomic,weak)UIView *coverV;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end

@implementation YCImageCropVC

- (UIView *)coverV{
    if (!_coverV) {
        UIView *coverV = [[UIView alloc]init];
        coverV.backgroundColor = [UIColor blackColor];
        coverV.alpha = 0.7;
        _coverV = coverV;
        [self.view addSubview:coverV];
    }
    
    return _coverV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageV.userInteractionEnabled = YES;
}

/**
 通过手势选定区域进行裁剪
 */
- (IBAction)pan:(UIPanGestureRecognizer *)pan {
    
    CGPoint curP = [pan locationInView:self.imageV];
    //判断手势的状态
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.startP = curP;
    }else if (pan.state == UIGestureRecognizerStateChanged) {
        CGFloat x = self.startP.x;
        CGFloat y = self.startP.y;
        CGFloat w = curP.x - self.startP.x;
        CGFloat h = curP.y - self.startP.y;
        CGRect rect = CGRectMake(x, y, w, h);
        
        self.coverV.frame = rect;
    }else if (pan.state == UIGestureRecognizerStateEnded){
        //YES 为不透明背景。NO为透明
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0);
        UIBezierPath *clipPath = [UIBezierPath bezierPathWithRect:self.coverV.frame];
        [clipPath addClip];
        
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        //把imageV上面的东西绘制到上下文中
        [self.imageV.layer renderInContext:ctx];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [self.coverV removeFromSuperview];
        
        self.imageV.image = newImage;
    }
    
}

@end
