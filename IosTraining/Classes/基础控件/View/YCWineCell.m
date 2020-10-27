//
//  YCWineCell.m
//  UI
//
//  Created by release on 2020/8/8.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCWineCell.h"
#import "YCWine.h"

@interface YCWineCell ()

@end
@implementation YCWineCell

/**
 设置子控件的数据
 */
- (void)setWine:(YCWine *)wine{
    _wine = wine;
    self.textLabel.text = wine.name;
    self.imageView.image = [UIImage imageNamed:wine.image];
    self.detailTextLabel.text = [NSString stringWithFormat:@"¥%@",wine.money];
}



@end
