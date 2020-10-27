//
//  YCPopMenuView.m
//  UI
//
//  Created by release on 2020/9/17.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#define YCKeyWindow [UIApplication sharedApplication].keyWindow
#import "YCPopMenuView.h"

@implementation YCPopMenuView

+ (instancetype)showInPoint:(CGPoint)point{
    YCPopMenuView *popView = [[NSBundle mainBundle] loadNibNamed:@"YCPopMenuView" owner:nil options:nil][0];
    popView.center = point;
    popView.backgroundColor = [UIColor redColor];
    [YCKeyWindow addSubview:popView];
    
    //超出父控件剪切
//    popView.layer.masksToBounds = YES;
//    popView.clipsToBounds = YES;
    return popView;
}
- (IBAction)close:(id)sender {
    //通知外界，点击了关闭按钮
    if ([self.delegate respondsToSelector:@selector(popMenuDidCloseBtn:)]) {
        [self.delegate popMenuDidCloseBtn:self];
    }
}

//-(void)hideInCenter{
//    //点击x号按钮，popMenu 慢慢缩小，边平移
//        //缩小到一定尺寸移除蒙版
//        [UIView animateWithDuration:0.5 animations:^{
//    //        self.frame = CGRectMake(0, 0, 0, 0);
//            self.center = CGPointMake(44, 44);
//            self.transform = CGAffineTransformMakeScale(0.01, 0.01);
//        }completion:^(BOOL finished) {
//            //1.移除自己
//            [self removeFromSuperview];
//
//            //2.移除蒙版
//            //block 可以保存一段代码，在需要的时候调用
//
//        }];
//}

- (void)hideInCenter:(CGPoint)center completion:(MyBlock)completion{
    //点击x号按钮，popMenu 慢慢缩小，边平移
           //缩小到一定尺寸移除蒙版
           [UIView animateWithDuration:0.5 animations:^{
       //        self.frame = CGRectMake(0, 0, 0, 0);
               self.center = center;
               self.transform = CGAffineTransformMakeScale(0.01, 0.01);
           }completion:^(BOOL finished) {
               //1.移除自己
               [self removeFromSuperview];
               
               //2.移除蒙版
               //block 可以保存一段代码，在需要的时候调用
               if (completion) {
                   //移除蒙版
                   completion();
               }
           }];
}

@end
