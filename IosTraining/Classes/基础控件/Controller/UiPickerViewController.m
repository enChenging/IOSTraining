//
//  UiPickerViewController.m
//  UI
//
//  Created by release on 2019/11/14.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import "UiPickerViewController.h"

@interface UiPickerViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,weak)UILabel *footTitle;
@property(nonatomic,weak)UIPickerView *pickView;

@property(nonatomic,strong)NSArray *dataArray;
@end

@implementation UiPickerViewController

- (NSArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"foods.plist" ofType:nil]];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //边缘扩展布局
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initView];
}

-(void)initView{
 
    UIPickerView* pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(30, 100, 300, 200)];
    pickView.delegate = self;
    pickView.dataSource = self;
    self.pickView = pickView;
    [self.view addSubview:pickView];
    
    UILabel *footTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    footTitle.center = CGPointMake(kScreenWidth/2, 50);
    self.footTitle = footTitle;
    [self.view addSubview:footTitle];
    
    [self pickerView:pickView didSelectRow:0 inComponent:0];
}

//总共有多少列数据
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.dataArray.count;
}

//每一列有多少行数据
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSArray *array = self.dataArray[component];
    return array.count;
}

//每一列展示什么内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    //取出当前所在的列
    NSArray *array = self.dataArray[component];
    return array[row];
}

//设置每行元素的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}

//选中某一列的某一行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    //取出当前选中的数据
    self.footTitle.text = self.dataArray[component][row];
}

//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
//    
//    UIImageView* _view = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"heart%ld",row%11]]];
//    
//    _view.frame = CGRectMake(0, 0, 30, 30);
//    return _view;
//}


@end
