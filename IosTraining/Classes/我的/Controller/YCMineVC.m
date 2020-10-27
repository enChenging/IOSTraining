//
//  YCMineVC.m
//  UI
//
//  Created by release on 2020/9/17.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCMineVC.h"
#import "YCSettingTableVC.h"

@interface YCMineVC ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation YCMineVC
///
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    
    //1.设置button背景图片
    //拿到button的背景图片
    UIImage *image = self.loginBtn.currentBackgroundImage;
    //拉伸图片
    image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
    [self.loginBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    //2.设置导航左侧按钮
    UIButton *button = [[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:@"FBMM_Barbutton"] forState:UIControlStateNormal];
    [button setTitle:@"客服" forState:UIControlStateNormal];
    [button sizeToFit];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    //2.设置导航右侧按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Mylottery_config"] style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
}

-(void)rightClick{
    YCSettingTableVC *setting = [[YCSettingTableVC alloc]init];
    setting.title = @"设置";
    [self.navigationController pushViewController:setting animated:YES];
}

@end
