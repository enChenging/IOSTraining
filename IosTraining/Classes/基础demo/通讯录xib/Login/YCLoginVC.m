//
//  YCLoginVC.m
//  UI
//
//  Created by release on 2020/8/16.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCLoginVC.h"
#import "MBProgressHUD+XMG.h"
#import "YCContactVC.h"

@interface YCLoginVC ()

@property (weak, nonatomic) IBOutlet UITextField *accontTextF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UISwitch *remberSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSwitch;

@end

@implementation YCLoginVC



- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.accontTextF addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.pwdTextF addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    
    //程序一进来就判断一下文本框内容有没有值
    [self textChange];
}

-(void)textChange{
    self.loginBtn.enabled = self.accontTextF.text.length && self.pwdTextF.text.length;
}

/**
 performSegueWithIdentifier:底层实现
 1.根据Identifier标示到StoryBoard中去寻找有没有这个segue线，如果有就会帮你创建UIStoryBoardSegue对象
 2.设置UIStoryBoardSegue的来源控制器seg.sourceViewController = self;
 3.创建Segue对象的目标控制器，并且给seg对象的目标控制器属性赋值
 4.通知来源控制器，segue线准备好了，会调用来源控制器的prepareForSegue方法
 5.执行[segue perform]方法，perform方法当中，拿到来源控制器的导航控制器，调用push方法，跳转到目标控制器
 [segue.sourceViewController.navigationController pushViewControlller:segue.destinationViewController animated:YES];
 */
- (IBAction)login:(UIButton *)sender {
//    YCLog(@"%s",__func__);
    [MBProgressHUD showMessage:@"正在登录..."];
    //模拟网络延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //隐藏HUD
        [MBProgressHUD hideHUD];
        //判断用户命密码
        if ([self.accontTextF.text isEqualToString:@"cyc"
             ] && [self.pwdTextF.text isEqualToString:@"123"]) {
            //跳转到下一页
            //根据一个标示，手动执行指定的Segue
            [self performSegueWithIdentifier:@"login2Contact" sender:nil];
            //隐藏键盘
            [self.view endEditing:YES];
        }else{
            [MBProgressHUD showError:@"用户名或密码错误"];
        }
        
    });
    
}

#pragma mark - Navigation
/**
 segue线准备时会调用这个方法
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue destinationViewController] isKindOfClass:[YCContactVC class]]) {
        // 获取目标控制
        YCContactVC *contact = [segue destinationViewController];
        //给目标控制器赋值
        contact.account = self.accontTextF.text;
        //    contact.title = [NSString stringWithFormat:@"%@的通讯录",self.accontTextF.text];
    }
    
}


-(IBAction)remberSwitchChange:(UISwitch *)sender{
//    YCLog(@"%s",__func__);
    if (sender.on == NO) {
        [self.autoLoginSwitch setOn:NO animated:YES];
    }
}

-(IBAction)autoLoginChange:(UISwitch *)sender{
//    YCLog(@"%s",__func__);
    if (sender.on == YES) {
        [self.remberSwitch setOn:YES animated:YES];
    }
}


@end
