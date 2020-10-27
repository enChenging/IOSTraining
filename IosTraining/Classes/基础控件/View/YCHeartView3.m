//
//  YCHeartView3.m
//  UI
//
//  Created by release on 2020/7/29.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCHeartView3.h"
#import "YCHeartModel.h"

@implementation YCHeartView3

+ (instancetype)heartView3{
    return  [[self alloc]init];;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor greenColor]];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
    return self;
}

#pragma mark 布局子控件
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    self.imageView.frame = CGRectMake(0, 0, width, width);
    self.titleLabel.frame = CGRectMake(0, width, width, height-width);
}

#pragma mark 设置子控件的数据
- (void)setHeartModel:(YCHeartModel *)heartModel{
    _heartModel = heartModel;
    
    
//    self.imageView.image = [UIImage imageNamed:heartModel.name];
//    self.titleLabel.text = heartModel.name;
    
    [self setImage:[UIImage imageNamed:heartModel.icon] forState:UIControlStateNormal];
    [self setTitle:heartModel.name forState:UIControlStateNormal];
}

@end
