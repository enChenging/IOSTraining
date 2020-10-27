//
//  YCEditContactVC.m
//  UI
//
//  Created by release on 2020/8/16.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCEditContactVC.h"
#import "YCContactItem.h"

@interface YCEditContactVC ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextF;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation YCEditContactVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTextF.text = self.contactItem.name;
    self.phoneTextF.text = self.contactItem.phoneNum;
    [self initTitle];
}

-(void)initTitle{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑"
        style:UIBarButtonItemStyleDone target:self action:@selector(pressRight:)];
}

-(void)pressRight:(UIBarButtonItem *)sender{
    if ([sender.title isEqualToString:@"编辑"]) {
        sender.title = @"取消";
        self.nameTextF.enabled = YES;
        self.phoneTextF.enabled = YES;
        //第二个文本框弹出键盘
        [self.phoneTextF becomeFirstResponder];
        self.saveBtn.hidden = NO;
    }else{
        sender.title = @"编辑";
        self.nameTextF.enabled = NO;
        self.phoneTextF.enabled = NO;
        [self.view endEditing:YES];
        self.saveBtn.hidden = YES;
        self.nameTextF.text = self.contactItem.name;
        self.phoneTextF.text = self.contactItem.phoneNum;
        
    }
}

- (IBAction)saveBtnClick:(id)sender {
    self.contactItem.name = self.nameTextF.text;
    self.contactItem.phoneNum = self.phoneTextF.text;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"saveNotice" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
