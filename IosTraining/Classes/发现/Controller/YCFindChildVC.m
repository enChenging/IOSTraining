//
//  YCFindChildVC.m
//  UI
//
//  Created by release on 2020/9/18.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCFindChildVC.h"
#import "YCTitleViewButton.h"

@interface YCFindChildVC ()

@end

@implementation YCFindChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.设置titleView
    UIButton *btn = [[YCTitleViewButton alloc]init];
    [btn setImage:[UIImage imageNamed:@"YellowDownArrow"] forState:UIControlStateNormal];
    [btn setTitle:@"全部采种" forState:UIControlStateNormal];
    [btn sizeToFit];
    
    self.navigationItem.titleView = btn;
    
   
}




@end
