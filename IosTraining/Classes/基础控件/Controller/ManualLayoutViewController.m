//
//  ManualLayoutViewController.m
//  UI
//
//  Created by release on 2019/11/12.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import "ManualLayoutViewController.h"
#import "SuperView.h"

@interface ManualLayoutViewController ()

@end

@implementation ManualLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initView];
}

-(void)initView{
   
    SuperView* sView = [[SuperView alloc]initWithFrame:CGRectMake(30, 30, 150, 260)];
    sView.backgroundColor = [UIColor greenColor];
    [sView setTag:1001];
    [self.view addSubview:sView];
    [sView createView];
    
    UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(320, 500, 60, 30)];
    [btn setTitle:@"放大" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor grayColor]];
    [btn addTarget:self action:@selector(pressesBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTag:101];
    [self.view addSubview:btn];
    
    UIButton* btn2 = [[UIButton alloc]initWithFrame:CGRectMake(320, 550, 60, 30)];
    [btn2 setTitle:@"缩小" forState:UIControlStateNormal];
    [btn2 setBackgroundColor:[UIColor grayColor]];
    [btn2 addTarget:self action:@selector(pressesBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTag:102];
    [self.view addSubview:btn2];
}


-(void)pressesBtn:(UIButton*)btn{
    if (btn.tag == 101) {
        YCLog(@"放大");
        SuperView* sView = [self.view viewWithTag:1001];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1];
        sView.frame = CGRectMake(0, 0, 300, 520);
        [UIView commitAnimations];
    }else if (btn.tag == 102){
        YCLog(@"缩小");
        SuperView* sView = [self.view viewWithTag:1001];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1];
        sView.frame = CGRectMake(30, 30, 150, 260);
        [UIView commitAnimations];

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
