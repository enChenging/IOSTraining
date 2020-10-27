//
//  UIAlertViewController.m
//  UI
//
//  Created by release on 2019/11/11.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import "UIAlertViewController.h"

@interface UIAlertViewController ()<UIAlertViewDelegate>{
 
    UIButton* _alertBtn;
    UIAlertController* _alertController;
    UIAlertController* _alertController2;
    UIAlertController* _alertController3;
    UIActivityIndicatorView* _indicator;
}

@end

@implementation UIAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

-(void)initView{
    
    for (int i = 0; i<4; i++) {
        _alertBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100+100*i, 180, 40)];
        if (i == 0) {
            [_alertBtn setTitle:@"普通提示框" forState:UIControlStateNormal];
        }else if(i == 1){
            [_alertBtn setTitle:@"输入文本框" forState:UIControlStateNormal];
        }else if(i == 2){
            [_alertBtn setTitle:@"底部选择框" forState:UIControlStateNormal];
        }else if(i == 3){
            [_alertBtn setTitle:@"等待提示器" forState:UIControlStateNormal];
        }
        [_alertBtn setTag:(101+i)];
        [_alertBtn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_alertBtn setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
        [self.view addSubview:_alertBtn];
    }

    _indicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(kScreenWidth/2-50, kScreenHeight/2-50, 100, 100)];
       _indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
       _indicator.backgroundColor = [UIColor grayColor];
       [self.view addSubview:_indicator];
    
   
    
    //UIAlertController 弹窗
    _alertController = [UIAlertController alertControllerWithTitle:@"标题" message:@"内容" preferredStyle:UIAlertControllerStyleAlert];
    
    //确认按钮
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        for (UITextField* text in  self->_alertController2.textFields) {
            YCLog(@"action = %@",text.text);
        }
    }];
    
    //取消按钮
    UIAlertAction* cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
       
        for (UITextField* text in  self->_alertController2.textFields) {
                   YCLog(@"action = %@",text.text);
        }
    }];
    
    [_alertController addAction:confirm];
    [_alertController addAction:cancle];

    
    _alertController2 = [UIAlertController alertControllerWithTitle:@"标题" message:@"内容" preferredStyle:UIAlertControllerStyleAlert];

    //添加文本框
    [_alertController2 addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"用户名";
    }];
    
    [_alertController2 addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"密码";
        textField.secureTextEntry = YES;
    }];

    [_alertController2 addAction:confirm];
    [_alertController2 addAction:cancle];
    
    _alertController3 = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        YCLog(@"打开相机");
    }];

    UIAlertAction *picture = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        YCLog(@"打开相册");
    }];
    
    for (int i = 0; i < 10; i++) {
        UIAlertAction * _view = [UIAlertAction actionWithTitle:@"sss" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
        }];
        [_alertController3 addAction:_view];
    }
    
    [_alertController3 addAction:camera];
    [_alertController3 addAction:picture];
    [_alertController3 addAction:cancle];
    
}

-(void)pressBtn:(UIButton*)btn{
    
    switch (btn.tag) {
        case 101:
            [self presentViewController:_alertController animated:YES completion:nil];
            break;
        case 102:
            [self presentViewController:_alertController2 animated:YES completion:nil];
            break;
        case 103:
            [self presentViewController:_alertController3 animated:YES completion:nil];
            break;
        case 104:
            [_indicator startAnimating];
            break;
        default:
            break;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
 
    //不在作为第一响应者
    [_indicator stopAnimating];
}


@end
