//
//  YCHitTest2VC.m
//  UI
//
//  Created by release on 2020/8/31.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCHitTest2VC.h"
#import "YCCarBadgeBtn.h"

@interface YCHitTest2VC ()

@end

@implementation YCHitTest2VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)btnDialogClick:(YCCarBadgeBtn *)sender {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"m_3_100"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"m_8_100"] forState:UIControlStateHighlighted];
    btn.frame = CGRectMake(100, -50, 100, 80);
    
    sender.popBtn = btn;
    [sender addSubview:btn];
}


@end
