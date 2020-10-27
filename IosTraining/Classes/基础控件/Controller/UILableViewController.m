//
//  UILableViewController.m
//  UI
//
//  Created by release on 2019/11/8.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import "UILableViewController.h"

@interface UILableViewController ()

@end

@implementation UILableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUILable];
}

-(void)createUILable{
    
    UILabel *cLable=[[UILabel alloc]init];
    
    cLable.text=@"Hello World,my name is yancheng,my age 28";
    cLable.textColor=[UIColor blackColor];
    cLable.font=[UIFont systemFontOfSize:26];
//    cLable.font = [UIFont boldSystemFontOfSize:26];
//    cLable.font = [UIFont italicSystemFontOfSize:26];
    cLable.numberOfLines=0;
    cLable.frame=CGRectMake(100, 100, 200, 100);
    cLable.backgroundColor=[UIColor whiteColor];
    
    cLable.shadowColor=[UIColor grayColor];
    cLable.shadowOffset=CGSizeMake(2, 5);
    cLable.textAlignment=NSTextAlignmentLeft;
    cLable.lineBreakMode = NSLineBreakByWordWrapping;
    
//    NSLineBreakByWordWrapping = 0,         // Wrap at word boundaries, default
//       NSLineBreakByCharWrapping,        // Wrap at character boundaries
//       NSLineBreakByClipping,        // Simply clip
//       NSLineBreakByTruncatingHead,    // Truncate at head of line: "...wxyz"
//       NSLineBreakByTruncatingTail,    // Truncate at tail of line: "abcd..."
//       NSLineBreakByTruncatingMiddle    // Truncate middle of line:  "ab...yz"
    
    [self.view addSubview:cLable];
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
