//
//  YCTgCodeCell.m
//  UI
//
//  Created by release on 2020/8/6.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCTgCodeCell.h"
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import "Masonry.h"
#import "YCTg.h"

@interface YCTgCodeCell ()

//图标
@property(nonatomic,weak)UIImageView *iconImageView;
//标题
@property(nonatomic,weak)UILabel *titleLabel;
//价格
@property(nonatomic,weak)UILabel *priceLabel;
//购买数量
@property(nonatomic,weak)UILabel *buyCountLabel;

@end
@implementation YCTgCodeCell

//添加所有子控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    CGFloat space = 10;
    //图标
    UIImageView *iconImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:iconImageView];
    self.iconImageView = iconImageView;
    [iconImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(space);
        make.bottom.equalTo(self.contentView).offset(-space);
        make.width.equalTo(80);
    }];
    
    //标题
    UILabel *titleLable = [[UILabel alloc]init];
    [self.contentView addSubview:titleLable];
    self.titleLabel = titleLable;
    [titleLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconImageView.top);
        make.left.equalTo(iconImageView.right).offset(space);
        make.right.equalTo(self.contentView).offset(-space);
        make.height.equalTo(30);
    }];
    
    //价格
    UILabel *priceLable = [[UILabel alloc]init];
    priceLable.textColor = [UIColor orangeColor];
    priceLable.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:priceLable];
    self.priceLabel = priceLable;
    [priceLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLable.left);
        make.bottom.equalTo(iconImageView.bottom);
        make.size.equalTo(CGSizeMake(100, 15));
    }];
    
    //购买数
    UILabel *buyCountLabel = [[UILabel alloc]init];
    buyCountLabel.textAlignment = NSTextAlignmentRight;
    buyCountLabel.textColor = [UIColor lightGrayColor];
    buyCountLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:buyCountLabel];
    self.buyCountLabel = buyCountLabel;
    [buyCountLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(iconImageView.bottom);
        make.right.equalTo(titleLable.right);
        make.height.equalTo(CGSizeMake(150, 14));
    }];
    
    //分割线
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.equalTo(1);
    }];
    
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
