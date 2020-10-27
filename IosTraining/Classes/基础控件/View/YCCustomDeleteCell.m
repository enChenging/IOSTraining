//
//  YCCustomDeleteCell.m
//  UI
//
//  Created by release on 2020/8/8.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCCustomDeleteCell.h"
#import "YCWine.h"

@interface YCCustomDeleteCell ()

@property(nonatomic,weak)UIImageView *checkedImageView;

@end
@implementation YCCustomDeleteCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //添加打勾控件
        UIImageView *chekcedImageView = [[UIImageView alloc]init];
        chekcedImageView.hidden = NO;
        chekcedImageView.image = [UIImage imageNamed:@"check"];
        [self.contentView addSubview:chekcedImageView];
        self.checkedImageView = chekcedImageView;
    }
    
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat WH = 24;
    CGFloat X = self.contentView.frame.size.width - WH - 10;
    CGFloat Y = (self.contentView.frame.size.height - WH)*0.5;
    self.checkedImageView.frame = CGRectMake(X, Y, WH, WH);
    
    CGRect frame = self.textLabel.frame;
    frame.size.width = self.contentView.frame.size.width - WH - 20 - self.textLabel.frame.origin.x;
    self.textLabel.frame = frame;
}
/**
 设置子控件的数据
 */
- (void)setWine:(YCWine *)wine{
    _wine = wine;
    self.textLabel.text = wine.name;
    self.imageView.image = [UIImage imageNamed:wine.image];
    self.detailTextLabel.text = [NSString stringWithFormat:@"¥%@",wine.money];

    if (wine.isChecked) {
        self.checkedImageView.hidden = NO;
    }else{
        self.checkedImageView.hidden = YES;
    }
}


@end
