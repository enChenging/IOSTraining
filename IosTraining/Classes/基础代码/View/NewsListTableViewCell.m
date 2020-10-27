//
//  NewsListTableViewCell.m
//  UI
//
//  Created by release on 2019/11/16.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import "NewsListTableViewCell.h"

@implementation NewsListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        [self createUI];
    }
    
    return self;
}

- (void)createUI{
    _mImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 120, 80)];
    [self.contentView addSubview:_mImageView];
    
    _mTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(140, 10, 260, 60)];
    _mTitleLable.textAlignment = NSTextAlignmentCenter;
    _mTitleLable.numberOfLines = 0;
    _mTitleLable.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_mTitleLable];
    
    _mCtimeLable = [[UILabel alloc] initWithFrame:CGRectMake(140, 70, 260, 20)];
    _mCtimeLable.textAlignment = NSTextAlignmentCenter;
    _mCtimeLable.textAlignment = NSTextAlignmentRight;
    _mCtimeLable.font = [UIFont systemFontOfSize:15];
    _mCtimeLable.textColor = [UIColor grayColor];
    [self.contentView addSubview:_mCtimeLable];
    
}

@end
