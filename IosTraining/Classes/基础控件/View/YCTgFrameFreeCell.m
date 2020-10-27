//
//  YCTgFrameFreeCell.m
//  UI
//
//  Created by release on 2020/8/6.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCTgFrameFreeCell.h"
#import "YCStatus.h"

#define YCTextFont [UIFont systemFontOfSize:14]
#define YCNameFont [UIFont systemFontOfSize:14]

@interface YCTgFrameFreeCell ()

@property(nonatomic,weak)UIImageView *iconImageView;

@property(nonatomic,weak)UILabel *nameLabel;

@property(nonatomic,weak)UIImageView *vipImageView;

@property(nonatomic,weak)UILabel *text_Label;

@property(nonatomic,weak)UIImageView *pictureImageView;

@end

@implementation YCTgFrameFreeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //图像
        UIImageView *iconImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:iconImageView];
        self.iconImageView = iconImageView;
        
        //配图
        UIImageView *pictureImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:pictureImageView];
        self.pictureImageView = pictureImageView;
        
        //vip
        UIImageView *vipImageView = [[UIImageView alloc]init];
        vipImageView.contentMode = UIViewContentModeCenter;
        vipImageView.image = [UIImage imageNamed:@"vip"];
        [self.contentView addSubview:vipImageView];
        self.vipImageView = vipImageView;
        
        //昵称
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel.font = YCNameFont;
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        //正文
        UILabel *text_Label = [[UILabel alloc]init];
        text_Label.font = YCTextFont;
        text_Label.numberOfLines = 0;
        [self.contentView addSubview:text_Label];
        self.text_Label = text_Label;
    }
    
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.iconImageView.frame = _status.iconFrame;
    self.nameLabel.frame = _status.nameFrame;
    self.vipImageView.frame = _status.vipFrame;
    self.text_Label.frame = _status.textFrame;
    self.pictureImageView.frame = _status.pictureFrame;
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
    }else{
        self.pictureImageView.hidden = YES;
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
