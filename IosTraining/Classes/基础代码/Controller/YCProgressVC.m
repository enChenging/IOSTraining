//
//  YCProgressVC.m
//  UI
//
//  Created by release on 2020/9/1.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCProgressVC.h"
#import "YCProgressView.h"

@interface YCProgressVC ()
@property (weak, nonatomic) IBOutlet UILabel *valueTitle;
@property (weak, nonatomic) IBOutlet YCProgressView *progressView;

@end

@implementation YCProgressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)valueChange:(UISlider *)sender {
    
    self.valueTitle.text = [NSString stringWithFormat:@"%.2f%%",sender.value * 100];
    self.progressView.progressValue = sender.value;
}




@end
