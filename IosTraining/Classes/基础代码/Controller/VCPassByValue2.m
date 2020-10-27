//
//  VCPassByValue2.m
//  UI
//
//  Created by release on 2019/11/14.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import "VCPassByValue2.h"
#import "VCPassByValue.h"

@interface VCPassByValue2 ()<VCPassByValueDelegate>
{
    UITextField* _textField01;
    UITextField* _textField02;
    UITextField* _textField03;
    UITextField* _textField04;
    UITextField* _textField05;
}
@end

@implementation VCPassByValue2

@synthesize mlabel04 = _label04;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTitle];
    [self initView];
}

-(void)initTitle{
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

-(void)pressBack{
    [self.navigationController popViewControllerAnimated:NO];
}

//代理正向传值
- (void)sendTextContent:(NSString *)content{
    UILabel* _label03 = [[UILabel alloc]initWithFrame:CGRectMake(50, 130, 350, 40)];
    NSString* str03 = [NSString stringWithFormat:@"代理正向传值：%@", content];
    [_label03 setText:str03];
    [self.view addSubview:_label03];
}

-(void)initView{
    
    [self dismissViewControllerAnimated:YES completion: nil];
    UILabel* _label01 = [[UILabel alloc]initWithFrame:CGRectMake(50, 30, 350, 40)];
    NSString* str01 = [NSString stringWithFormat:@"属性值：%@",_propertyValue];
    [_label01 setText:str01];
    [self.view addSubview:_label01];

    UILabel* _label02 = [[UILabel alloc]initWithFrame:CGRectMake(50, 80, 350, 40)];
    NSString* str02 = [NSString stringWithFormat:@"方法值：%@",_methodValue];
    [_label02 setText:str02];
    [self.view addSubview:_label02];

    UIButton* btn01 = [[UIButton alloc]initWithFrame:CGRectMake(260, 190, 100, 40)];
    [btn01 setTitle:@"发送" forState:UIControlStateNormal];
    [btn01 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn01 setBackgroundColor:[UIColor brownColor]];
    [btn01 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn01];
    
    _textField01 = [[UITextField alloc]initWithFrame:CGRectMake(50, 190, 180, 40)];
    [_textField01 setPlaceholder:@"代理反向传值"];
    [_textField01 setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:_textField01];

    UIButton* btn02 = [[UIButton alloc]initWithFrame:CGRectMake(260, 250, 100, 40)];
    [btn02 setTitle:@"发送" forState:UIControlStateNormal];
    [btn02 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn02 setBackgroundColor:[UIColor brownColor]];
    [btn02 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn02];
    
    _textField02 = [[UITextField alloc]initWithFrame:CGRectMake(50, 250, 180, 40)];
    [_textField02 setPlaceholder:@"block属性反向传值"];
    [_textField02 setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:_textField02];
    
    UIButton* btn03 = [[UIButton alloc]initWithFrame:CGRectMake(260, 310, 100, 40)];
    [btn03 setTitle:@"发送" forState:UIControlStateNormal];
    [btn03 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn03 setBackgroundColor:[UIColor brownColor]];
    [btn03 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn03];
    
    _textField03 = [[UITextField alloc]initWithFrame:CGRectMake(50, 310, 180, 40)];
    [_textField03 setPlaceholder:@"block方法反向传值"];
    [_textField03 setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:_textField03];
    
    UIButton* btn04 = [[UIButton alloc]initWithFrame:CGRectMake(260, 370, 100, 40)];
    [btn04 setTitle:@"发送" forState:UIControlStateNormal];
    [btn04 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn04 setBackgroundColor:[UIColor brownColor]];
    [btn04 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn04];
    
    _textField04 = [[UITextField alloc]initWithFrame:CGRectMake(50, 370, 180, 40)];
    [_textField04 setPlaceholder:@"KVO反向传值"];
    [_textField04 setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:_textField04];
    
    //通知接收值
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNoti:) name:@"send" object:nil];
    _label04 = [[UILabel alloc]initWithFrame:CGRectMake(50, 420, 350, 40)];
    [self.view addSubview:_label04];
    
    //单例接收值
    UILabel* _label05 = [[UILabel alloc]initWithFrame:CGRectMake(50, 470, 350, 40)];
    NSString* str05 = [NSString stringWithFormat:@"单例传值：%@",[VCPassByValue initInstance].mName];
    [_label05 setText:str05];
    [self.view addSubview:_label05];
    
    //kvc接收值
    UILabel* _label06 = [[UILabel alloc]initWithFrame:CGRectMake(50, 520, 350, 40)];
    NSString* str06 = [NSString stringWithFormat:@"KVC传值：%@",self.mKvcText];
    [_label06 setText:str06];
    
    [self.view addSubview:_label06];
}

//方法传值
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    _methodValue = nibNameOrNil;
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [_textField01 resignFirstResponder];
    [_textField02 resignFirstResponder];
    [_textField03 resignFirstResponder];
    [_textField04 resignFirstResponder];

}

//block方法反向传值
-(void)sendBlockMessage:(NSString *)msg andBlock:(VCPassByValueBlock)block{
    block(_textField03.text);
    _textField03.text = @"";
}

-(void)pressBtn:(UIButton*)btn{
 
    [_pbv2delegate sendMessage:_textField01.text];//代理反向传值
    self.receiveValue(_textField02.text);//block属性反向传值
    self.data = _textField04.text;//KVO反向传值
    
    _textField01.text = @"";
    _textField02.text = @"";
    _textField04.text = @"";
    [_textField01 resignFirstResponder];
    [_textField02 resignFirstResponder];
    [_textField03 resignFirstResponder];
    [_textField04 resignFirstResponder];
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

//通知接收值
-(void)receiveNoti:(NSNotification *)noti{
    YCLog(@"object=====%@",noti.object);
    YCLog(@"userInfo=====%@",noti.userInfo);
    NSString* str04 = [NSString stringWithFormat:@"通知传值：%@",noti.object];
    [_label04 setText:str04];
}

@end
