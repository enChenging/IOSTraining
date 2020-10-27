//
//  YCAddContactVC.m
//  UI
//
//  Created by release on 2020/8/16.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCAddContactVC.h"
#import "YCContactItem.h"

@interface YCAddContactVC ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextF;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end

@implementation YCAddContactVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加联系人";
    
    [self.nameTextF addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.phoneTextF addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
}

-(void)textChange{
    self.addBtn.enabled = self.nameTextF.text.length && self.phoneTextF.text.length;
}

- (IBAction)addClick:(id)sender {
    
    //通知代理
    if ([self.delegate respondsToSelector:@selector(addViewController:contact:)]) {
        YCContactItem *contactItem = [YCContactItem itemWithName:self.nameTextF.text phoneNum:self.phoneTextF.text ];
        [self.delegate addViewController:self contact:contactItem];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
