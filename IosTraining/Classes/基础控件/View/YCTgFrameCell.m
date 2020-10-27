//
//  YCTgFrameCell.m
//  UI
//
//  Created by release on 2020/8/6.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCTgFrameCell.h"
#import "YCTg.h"

@interface YCTgFrameCell ()

//图标
@property(nonatomic,weak)UIImageView *iconImageView;
//标题
@property(nonatomic,weak)UILabel *titleLabel;
//价格
@property(nonatomic,weak)UILabel *priceLabel;
//购买数量
@property(nonatomic,weak)UILabel *buyCountLabel;

@end

@implementation YCTgFrameCell

//添加所有子控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    //图标
    UIImageView *iconImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:iconImageView];
    self.iconImageView = iconImageView;
    
    //标题
    UILabel *titleLable = [[UILabel alloc]init];
    [self.contentView addSubview:titleLable];
    self.titleLabel = titleLable;
    
    //价格
    UILabel *priceLable = [[UILabel alloc]init];
    priceLable.textColor = [UIColor orangeColor];
    priceLable.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:priceLable];
    self.priceLabel = priceLable;
    
    //购买数
    UILabel *buyCountLabel = [[UILabel alloc]init];
    buyCountLabel.textAlignment = NSTextAlignmentRight;
    buyCountLabel.textColor = [UIColor lightGrayColor];
    buyCountLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:buyCountLabel];
    self.buyCountLabel = buyCountLabel;
    
}

//设置子控件的布局
- (void)layoutSubviews{
    [super layoutSubviews];
    
     CGFloat space = 10;
//    CGFloat contentViewW = self.contentView.frame.size.width;
//    CGFloat contentViewH = self.contentView.frame.size.height;
    CGFloat contentViewW = CGRectGetWidth(self.contentView.frame);
    CGFloat contentViewH = CGRectGetHeight(self.contentView.frame);
    
    //图标
    CGFloat iconX = space;
    CGFloat iconY = space;
    CGFloat iconW = 80;
    CGFloat iconH = contentViewH -2*space;
    self.iconImageView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    //标题
    CGFloat titleX = CGRectGetMaxX(self.iconImageView.frame)+space;
    CGFloat titleY = iconY;
    CGFloat titleW = contentViewW -titleX -space;
    CGFloat titleH = 20;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    //价格
    CGFloat priceW = 100;
    CGFloat priceH = 15;
    CGFloat priceX = titleX;
    CGFloat priceY = CGRectGetMaxY(self.iconImageView.frame)-priceH;
    self.priceLabel.frame = CGRectMake(priceX, priceY, priceW, priceH);
    
    //购买数量
    CGFloat buyW = 150;
    CGFloat buyH = 14;
    CGFloat buyX = contentViewW - buyW - space;
    CGFloat buyY = CGRectGetMaxY(self.iconImageView.frame) - buyH;
    self.buyCountLabel.frame = CGRectMake(buyX, buyY, buyW, buyH);
}

/**
 设置子控件的数据
 */
- (void)setTg:(YCTg *)tg{
    _tg = tg;
    self.iconImageView.image = [UIImage imageNamed:tg.icon];
    self.titleLabel.text = tg.title;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",tg.price];
    self.buyCountLabel.text = [NSString stringWithFormat:@"%@人已购买",tg.buyCount];
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
