//  BlockViewController.m
//  UI
//
//  Created by release on 2019/11/25.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import "BlockViewController.h"

@interface BlockViewController ()

@end

@implementation BlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initBlock];
    [self initView];
}
-(void)initBlock{
    
    self.blockOne = ^{
           YCLog(@"blockOne无参数，无返回值");
       };
       
    self.blockTow = ^(int value) {
        YCLog(@"blockTow有参数===%d，无返回值",value);
    };
    
    self.blockThree = ^NSString * _Nullable{
        YCLog(@"blockThree无参数，有返回值");
        return @"100";
    };
    
    self.blockFour = ^NSString * _Nullable(int value) {
        YCLog(@"blockFour有参数===%d，有返回值",value);
        return @"200";
    };
    
   
}

-(void)initView{

    self.blockOne();
    self.blockTow(1);
    NSString* value = self.blockThree();
    NSString* value2 = self.blockFour(2);
    YCLog(@"blockThree返回值===%@",value);
    YCLog(@"blockFour返回值===%@",value2);
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
