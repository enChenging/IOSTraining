//
//  YCLuckyVC.m
//  UI
//
//  Created by release on 2020/9/12.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCLuckyVC.h"
#import "YCWheelView.h"

@interface YCLuckyVC ()

@property(nonatomic,weak)YCWheelView *wheelV;

@end

@implementation YCLuckyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YCWheelView *wheelV = [YCWheelView wheelView];
    wheelV.center = self.view.center;
    self.wheelV = wheelV;
    [self.view addSubview:wheelV];
    
}

- (IBAction)startRotation:(id)sender {
    [self.wheelV startRotation];
}
- (IBAction)stop:(id)sender {
    [self.wheelV stopRatation];
}


@end
