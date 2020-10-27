//
//  YCDrawingBoardView.h
//  UI
//
//  Created by release on 2020/9/3.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YCDrawingBoardView : UIView
//清除
-(void)clear;
//撤销
-(void)undo;
//橡皮擦
-(void)erase;
//设置线的宽度
-(void)setLineWith:(CGFloat)lineWith;
//设置线的颜色
-(void)setLineColor:(UIColor *)color;
//要绘制的图片
@property(nonatomic,strong)UIImage *image;

@end

NS_ASSUME_NONNULL_END
