//
//  YCCollectVC.m
//  UI
//
//  Created by release on 2020/8/24.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCCollectVC.h"

@interface YCCollectVC ()

@end

@implementation YCCollectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBlueColor];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 80, 30)];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)btn{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"%s",__func__);
    }];
}
@end
