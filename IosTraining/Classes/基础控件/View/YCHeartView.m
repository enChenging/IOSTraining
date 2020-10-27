//
//  YCHeartView.m
//  UI
//
//  Created by release on 2020/7/11.
//  Copyright © 2020 Mr. release. All rights reserved.
//


#import "YCHeartView.h"
#import "YCHeartModel.h"

@interface YCHeartView()

@property(nonatomic,weak)UIImageView *iconView;
@property(nonatomic,weak)UILabel *titleLabel;

@end
@implementation YCHeartView

//-(instancetype)init{
//    if (self = [super init]) {
//        [self setUp];
//    }
//    return self;
//}

/**
 注意：创建对象用init: 方法 或initWithFrame:方法都会调用initWithFrame:
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

-(instancetype)initWithHartModel:(YCHeartModel *)heartModel{
 
    if (self = [super init]) {
        [self setUp];
        self.heartModel = heartModel;//self 包含set get
    }
    return self;
}

+ (instancetype)HeartViewWithHartModel:(YCHeartModel *)heartModel{
    
    return [[self alloc]initWithHartModel:heartModel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    self.iconView.frame = CGRectMake(0, 0, width, width);
    self.titleLabel.frame = CGRectMake(0, width, width, height-width);
}

-(void)setUp{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.backgroundColor = [UIColor magentaColor];
    [self addSubview:imageView];
    _iconView = imageView;

    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor redColor];
    label.textColor = [UIColor whiteColor];
    [self addSubview:label];
    _titleLabel = label;
}


/**
 set方法：只要外边传数据就会调用
 作用：设置数据
 */
- (void)setHeartModel:(YCHeartModel *)heartModel{
    _heartModel = heartModel;//注意不能用 self.heartModel,发生set get 死循环
    
    //设置数据
    self.iconView.image = [UIImage imageNamed:heartModel.icon];
    self.titleLabel.text = heartModel.name;
}

@end
