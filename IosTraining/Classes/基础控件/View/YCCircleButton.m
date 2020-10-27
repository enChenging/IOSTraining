//
//  YCCircleButton.m
//  UI
//
//  Created by release on 2020/8/10.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCCircleButton.h"

@implementation YCCircleButton

- (void)awakeFromNib{
    [super awakeFromNib];
    //设置边框宽度
    self.layer.borderWidth = 1.0;
    //设置边框颜色
    self.layer.borderColor = [UIColor redColor].CGColor;
    //设置圆角半径
    self.layer.cornerRadius = self.frame.size.width * 0.5;
}

@end
