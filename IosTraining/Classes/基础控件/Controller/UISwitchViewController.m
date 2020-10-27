//
//  UISwitchViewController.m
//  UI
//
//  Created by release on 2019/11/8.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import "UISwitchViewController.h"

@interface UISwitchViewController ()
{
    UISwitch* _cSwitch;
}

@end

@implementation UISwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUISwitch];
}

-(void)createUISwitch{
 
    _cSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(100, 150, 100, 100)];
    [_cSwitch setOn:YES animated:YES];
    [_cSwitch setOnTintColor:[UIColor redColor]];//开启时颜色
    [_cSwitch setThumbTintColor:[UIColor greenColor]];//按钮颜色
    
    [_cSwitch addTarget:self action:@selector(pressSwitch:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_cSwitch];
}

-(void)pressSwitch:(UISwitch*)swit{
    
    if (swit.on == YES) {
        YCLog(@"打开开关");
    }else{
        YCLog(@"关闭开关");
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
