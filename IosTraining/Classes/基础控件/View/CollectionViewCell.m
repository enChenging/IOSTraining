//
//  CollectionViewCell.m
//  UI
//
//  Created by release on 2019/11/22.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 6;
        
        _titleLabel = [[UILabel alloc] init];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];
        
        _itemImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.itemImageView];
    }
    return self;
}
 
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.itemImageView.bounds = CGRectMake(0, 0, 50, 50);
    self.itemImageView.center = CGPointMake(self.bounds.size.width/2, 30);
    
    self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.itemImageView.frame) + 5, self.bounds.size.width, 30);
}
 
@end
