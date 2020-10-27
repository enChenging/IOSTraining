//
//  UIStepper_UISegmentedControlViewController.m
//  UI
//
//  Created by release on 2019/11/8.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import "UIStepper_UISegmentedControlViewController.h"

@interface UIStepper_UISegmentedControlViewController (){
    UILabel* _cLabel;
    UIStepper* _stepper;
    UISegmentedControl* _segmentControl;
}
@end

@implementation UIStepper_UISegmentedControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

-(void)initView{
    
    _cLabel = [[UILabel alloc]initWithFrame:CGRectMake(140, 150, 100, 20)];
    _cLabel.textColor  = [UIColor blackColor];
    _cLabel.font = [UIFont systemFontOfSize:24];
    
    _stepper = [[UIStepper alloc]initWithFrame:CGRectMake(100, 200, 100, 100)];
    _stepper.maximumValue = 100;
    _stepper.minimumValue = 0;
    _stepper.value = 10;
    _stepper.stepValue = 1;
    _stepper.autorepeat = YES;//是否可以重复响应事件操作
    [_stepper addTarget:self action:@selector(pressStepper:) forControlEvents:UIControlEventValueChanged];
    
    _segmentControl = [[UISegmentedControl alloc]initWithFrame:CGRectMake(100, 300, 240, 50)];
    [_segmentControl insertSegmentWithTitle:@"5元" atIndex:0 animated:NO];
    [_segmentControl insertSegmentWithTitle:@"10" atIndex:1 animated:NO];
    [_segmentControl insertSegmentWithTitle:@"30" atIndex:2 animated:NO];
    _segmentControl.selectedSegmentIndex = 1;
    [_segmentControl addTarget:self action:@selector(pressSegmentControl:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:_cLabel];
    [self.view addSubview:_stepper];
    [self.view addSubview:_segmentControl];
}

-(void)pressStepper:(UIStepper*)stepper{
 
    _cLabel.text = [NSString stringWithFormat:@"%d",(int)stepper.value];
    YCLog(@"_stepper--%f",stepper.value);
}

-(void)pressSegmentControl:(UISegmentedControl*)segment{
 
    YCLog(@"_segmentControl--%ld",segment.selectedSegmentIndex);
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
