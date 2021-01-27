//
//  VCPassByValue.m
//  UI
//
//  Created by release on 2019/11/14.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import "VCPassByValue.h"
#import "VCPassByValue2.h"

@interface VCPassByValue ()<VCPassByValue2Delegate>
{
    VCPassByValue2* _pbv2;
    UITextField* _textField01;
    UITextField* _textField02;
    UITextField* _textField03;
    UITextField* _textField04;
    UITextField* _textField05;
    UITextField* _textField06;
    UILabel* _label01;
    UILabel* _label02;
    UILabel* _label03;
    UILabel* _label04;
}

@end

//创建单例
static VCPassByValue* instance = nil;

@implementation VCPassByValue

@synthesize mlabel02 = _label02;
@synthesize mlabel03 = _label03;

//方式一：性能低
//+(instancetype)initInstance{
//    @synchronized (self) {//任意对象
//        if (instance == nil) {
//            instance = [[VCPassByValue alloc]init];
//        }
//    }
//    return instance;
//}

//方式二：性能高
+ (instancetype)initInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[VCPassByValue alloc]init];
    });
    
    return instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitle];
    [self initView];
}

-(void)initTitle{
    UIBarButtonItem* rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"下一页" style:UIBarButtonItemStyleDone target:self action:@selector(pressBtn)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

-(void)pressBack{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)initView{
    
    _textField01 = [[UITextField alloc]initWithFrame:CGRectMake(50, 30, 180, 40)];
    [_textField01 setPlaceholder:@"属性传值(常用)"];
    [_textField01 setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:_textField01];
    
    UIButton* btn01 = [[UIButton alloc]initWithFrame:CGRectMake(260, 30, 100, 40)];
    [btn01 setTitle:@"发送" forState:UIControlStateNormal];
    [btn01 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn01 setBackgroundColor:[UIColor brownColor]];
    [btn01 addTarget:self action:@selector(pressBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn01];
    
    
    _textField02 = [[UITextField alloc]initWithFrame:CGRectMake(50, 90, 180, 40)];
    [_textField02 setPlaceholder:@"方法传值"];
    [_textField02 setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:_textField02];
    
    UIButton* btn02 = [[UIButton alloc]initWithFrame:CGRectMake(260, 90, 100, 40)];
    [btn02 setTitle:@"发送" forState:UIControlStateNormal];
    [btn02 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn02 setBackgroundColor:[UIColor brownColor]];
    [btn02 addTarget:self action:@selector(pressBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn02];
    
    _textField03 = [[UITextField alloc]initWithFrame:CGRectMake(50, 150, 180, 40)];
    [_textField03 setPlaceholder:@"代理正向传值(常用)"];
    [_textField03 setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:_textField03];
    
    UIButton* btn03 = [[UIButton alloc]initWithFrame:CGRectMake(260, 150, 100, 40)];
    [btn03 setTitle:@"发送" forState:UIControlStateNormal];
    [btn03 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn03 setBackgroundColor:[UIColor brownColor]];
    [btn03 addTarget:self action:@selector(pressBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn03];
    
    
    _label01 = [[UILabel alloc]initWithFrame:CGRectMake(50, 200, 350, 40)];
    [_label01 setText:@"代理反向传值:"];
    [self.view addSubview:_label01];
    
    _label02 = [[UILabel alloc]initWithFrame:CGRectMake(50, 250, 350, 40)];
    [_label02 setText:@"block属性反向传值:"];
    [self.view addSubview:_label02];
    
    _label03 = [[UILabel alloc]initWithFrame:CGRectMake(50, 300, 350, 40)];
    [_label03 setText:@"block方法反向传值:"];
    [self.view addSubview:_label03];
    
    _label04 = [[UILabel alloc]initWithFrame:CGRectMake(50, 350, 350, 40)];
    [_label04 setText:@"KVO反向传值:"];
    [self.view addSubview:_label04];
    
    _textField04 = [[UITextField alloc]initWithFrame:CGRectMake(50, 410, 180, 40)];
    [_textField04 setPlaceholder:@"通知传值"];
    [_textField04 setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:_textField04];
    
    UIButton* btn04 = [[UIButton alloc]initWithFrame:CGRectMake(260, 410, 100, 40)];
    [btn04 setTitle:@"发送" forState:UIControlStateNormal];
    [btn04 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn04 setBackgroundColor:[UIColor brownColor]];
    [btn04 addTarget:self action:@selector(pressBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn04];
    
    _textField05 = [[UITextField alloc]initWithFrame:CGRectMake(50, 470, 180, 40)];
    [_textField05 setPlaceholder:@"单例传值"];
    [_textField05 setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:_textField05];
    
    UIButton* btn05 = [[UIButton alloc]initWithFrame:CGRectMake(260, 470, 100, 40)];
    [btn05 setTitle:@"发送" forState:UIControlStateNormal];
    [btn05 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn05 setBackgroundColor:[UIColor brownColor]];
    [btn05 addTarget:self action:@selector(pressBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn05];
    
    _textField06 = [[UITextField alloc]initWithFrame:CGRectMake(50, 530, 180, 40)];
    [_textField06 setPlaceholder:@"KVC传值"];
    [_textField06 setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:_textField06];
    
    UIButton* btn06 = [[UIButton alloc]initWithFrame:CGRectMake(260, 530, 100, 40)];
    [btn06 setTitle:@"发送" forState:UIControlStateNormal];
    [btn06 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn06 setBackgroundColor:[UIColor brownColor]];
    [btn06 addTarget:self action:@selector(pressBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn06];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [_textField01 resignFirstResponder];
    [_textField02 resignFirstResponder];
    [_textField03 resignFirstResponder];
    [_textField04 resignFirstResponder];
    [_textField05 resignFirstResponder];
    [_textField06 resignFirstResponder];
}

//代理反向传值
- (void)sendMessage:(NSString *)message{
    NSString* str01 = [NSString stringWithFormat:@"代理反向传值：%@",message];
    [_label01 setText:str01];
}

-(void)pressBtn{

    //方法传值
    //initWithNibName这个方法是 UIViewController 通过xib文件创建实例用的
    _pbv2 = [[VCPassByValue2 alloc]initWithNibName:_textField02.text bundle:nil];
    
    //属性传值(常用)
    _pbv2.propertyValue = _textField01.text;
    
    //正向代理传值(常用)
    self.pbv1delegate = (id)_pbv2;
    [_pbv1delegate sendTextContent:_textField03.text];//代理对象调用事件函数
    
    //代理反向传值
    _pbv2.pbv2delegate = self;
    
    //block属性反向传值
    __block VCPassByValue *strongBlock = self;
    _pbv2.receiveValue = ^(NSString * _Nonnull value) {
        __weak VCPassByValue *pbv = strongBlock;
        NSString* str02 = [NSString stringWithFormat:@"block属性反向传值：%@",value];
        [pbv.mlabel02 setText:str02];
    };
    
    //注册观察者  KVO反向传值  forKeyPath键值必须与下一界面的属性值名称相同
    [_pbv2 addObserver:self forKeyPath:@"data" options:NSKeyValueObservingOptionNew context:nil];
    
    //通知传值（常用）
    [[NSNotificationCenter defaultCenter]postNotificationName:@"send" object:_textField04.text userInfo:@{@"content":_textField04.text}];
    
    //单例传值
    [VCPassByValue initInstance].mName = _textField05.text;
    
    //kvc传值 mKvcText必须与下一界面的属性值名称相同
    [_pbv2 setValue:_textField06.text forKey:@"mKvcText"];
    
    _textField01.text = @"";
    _textField02.text = @"";
    _textField03.text = @"";
    _textField04.text = @"";
    _textField05.text = @"";
    _textField06.text = @"";
    [_textField01 resignFirstResponder];
    [_textField02 resignFirstResponder];
    [_textField03 resignFirstResponder];
    [_textField04 resignFirstResponder];
    [_textField05 resignFirstResponder];
    [_textField06 resignFirstResponder];
    
    [self.navigationController pushViewController:_pbv2 animated:NO];
    
}

//KVO回调
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"data"]) {
        NSString* str04 = [NSString stringWithFormat:@"KVO反向传值：%@",_pbv2.data];
        [_label04 setText:str04];
    }
}

//移除KVO
- (void)dealloc
{
    [_pbv2 removeObserver:self forKeyPath:@"data"];
}

//block方法反向传值
- (void)viewDidAppear:(BOOL)animated{
    [_pbv2 sendBlockMessage:@"第一页" andBlock:^(NSString * _Nonnull str) {
        NSString* str02 = [NSString stringWithFormat:@"block方法反向传值：%@",str];
        self.mlabel03.text = str02;
    }];
}

@end
