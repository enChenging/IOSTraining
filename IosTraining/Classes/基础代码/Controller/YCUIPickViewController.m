//
//  YCUIPickViewController.m
//  UI
//
//  Created by release on 2020/8/13.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCUIPickViewController.h"
#import "FlagTextF.h"

@interface YCUIPickViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *countryTextF;
@property (weak, nonatomic) IBOutlet UITextField *birdthDayTextF;
@property (weak, nonatomic) IBOutlet UITextField *cityTextF;

@end

@implementation YCUIPickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.countryTextF.delegate = self;
    self.birdthDayTextF.delegate = self;
    self.cityTextF.delegate = self;
}

/**
 是否允许开始编辑
 */
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

/**
 是否允许结束编辑
 */
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}

/**
 开始编辑时调用(文本框成为第一响应者时调用)
 */
- (void)textFieldDidBeginEditing:(FlagTextF *)textField{
    if (textField.text.length == 0) {
         [textField initWithText];
    }
}
/**
 结束编辑时调用
 */
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
}

/**
 是否允许文字改变（拦截用户输入）
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return NO;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.countryTextF.delegate = self;
}

@end
