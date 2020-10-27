//
//  YCFreeCell.m
//  UI
//
//  Created by release on 2020/8/7.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCFreeCell.h"
#import "YCStatus.h"

@interface YCFreeCell ()

/** 图像 */
@property (nonatomic, weak)IBOutlet UIImageView *iconImageView;
/** 昵称 */
@property (nonatomic, weak)IBOutlet UILabel *nameLabel;
/** vip */
@property (nonatomic, weak)IBOutlet UIImageView *vipImageView;
/** 正文 */
@property (nonatomic, weak)IBOutlet UILabel *text_Label;
/** 配图 */
@property (nonatomic, weak)IBOutlet UIImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pitureHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pitureBottom;

@end

@implementation YCFreeCell


- (void)awakeFromNib {
    [super awakeFromNib];
    //手动设置文字的最大宽度（让label能够计算出自己最真实的尺寸）
    self.text_Label.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 20;
}

/**
 设置子控件的数据
 */
- (void)setStatus:(YCStatus *)status{
    _status = status;
    
    self.iconImageView.image = [UIImage imageNamed:status.icon];
    self.nameLabel.text = status.name;
    
    if (status.isVip) {
        self.nameLabel.textColor = [UIColor orangeColor];
        self.vipImageView.hidden = NO;
    }else{
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipImageView.hidden = YES;
    }
    
    self.text_Label.text = status.text;
    
    if (status.picture) {//有配图
        self.pictureImageView.hidden = NO;
        self.pictureImageView.image = [UIImage imageNamed:status.picture];
        self.pitureHeight.constant = 100;
        self.pitureBottom.constant = 10;
    }else{
        self.pictureImageView.hidden = YES;
        self.pitureHeight.constant = 0;
        self.pitureBottom.constant = 0;
    }
}

//- (CGFloat)cellHeight{
//    //强制刷新（label根据约束自动计算它的宽度和高度）
//    [self layoutIfNeeded];
//    
//    CGFloat cellHeight = 0;
//    if (self.status.picture) {
//        //有配图
//        cellHeight = CGRectGetMaxY(self.pictureImageView.frame) + 10;
//    }else{
//        //无配图
//        cellHeight = CGRectGetMaxY(self.text_Label.frame) + 10;
//    }
//    return cellHeight;
//}


@end
