//
//  YCHandleImageView.m
//  UI
//
//  Created by release on 2020/9/5.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCHandleImageView.h"

@interface YCHandleImageView()<UIGestureRecognizerDelegate>

@property(nonatomic,weak)UIImageView *imageV;

@end

@implementation YCHandleImageView


- (UIImageView *)imageV{
    if (!_imageV) {
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.frame = self.bounds;
        imageV.userInteractionEnabled = YES;
        [self addSubview:imageV];
        _imageV = imageV;
        [self addGes];
    }
    
    return _imageV;
}

- (void)setImage:(UIImage *)image{
    _image = image;
    self.imageV.image = image;
}

-(void)addGes{
    //平移手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [_imageV addGestureRecognizer:pan];
    
    //长按手势
    UILongPressGestureRecognizer *longP = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longP:)];
    [_imageV addGestureRecognizer:longP];
    
    //创建捏合手势
    UIPinchGestureRecognizer *pinchGes = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchGes:)];
    [_imageV addGestureRecognizer:pinchGes];
    
    //创建旋转手势
    UIRotationGestureRecognizer *rotationGes = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotationGes:)];
    [_imageV addGestureRecognizer:rotationGes];
    rotationGes.delegate = self;
    
}


-(void)pan:(UIPanGestureRecognizer *)pan{
    CGPoint transP = [pan translationInView:pan.view];
    pan.view.transform = CGAffineTransformTranslate(pan.view.transform, transP.x, transP.y);
    //复位
    [pan setTranslation:CGPointZero inView:pan.view];
}

-(void)longP:(UILongPressGestureRecognizer *)longP{
    if (longP.state == UIGestureRecognizerStateBegan) {
        //先让图片闪一下，把图片绘制到画板当中
        [UIView animateWithDuration:0.5 animations:^{
            self.imageV.alpha = 0;
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                 self.imageV.alpha = 1;
            }completion:^(BOOL finished) {
                //把图片绘制到画板当中
                UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
                CGContextRef ctx = UIGraphicsGetCurrentContext();
                [self.layer renderInContext:ctx];
                UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                
                //调用代理方法
                if ([self.delegate respondsToSelector:@selector(handleImageView:newImage:)]) {
                    [self.delegate handleImageView:self newImage:newImage];
                }
                [self removeFromSuperview];
                
            }];
        }];
    }
}

//捏合手势
-(void)pinchGes:(UIPinchGestureRecognizer*)pinch{
    UIImageView* imageView = (UIImageView*)pinch.view;
    imageView.transform = CGAffineTransformScale(imageView.transform, pinch.scale, pinch.scale);
    pinch.scale = 1;
}

//创建旋转手势
-(void)rotationGes:(UIRotationGestureRecognizer*)rotation{
    UIImageView* imageView = (UIImageView*)rotation.view;
    imageView.transform = CGAffineTransformRotate(imageView.transform, rotation.rotation);
    rotation.rotation = 0;
}

@end
