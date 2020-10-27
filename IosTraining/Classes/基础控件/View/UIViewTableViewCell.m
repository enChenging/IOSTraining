//
//  TestTableViewCell.m
//  UI
//
//  Created by release on 2019/11/7.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import "UIViewTableViewCell.h"

@implementation UIViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    _FistImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];    
    [self.contentView addSubview:_FistImage];
    
    _nameLable = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 260, 50)];
    _nameLable.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_nameLable];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
