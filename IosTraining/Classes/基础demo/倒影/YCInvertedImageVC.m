//
//  YCInvertedImageVC.m
//  UI
//
//  Created by release on 2020/9/15.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCInvertedImageVC.h"

@interface YCInvertedImageVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end

@implementation YCInvertedImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CAReplicatorLayer *repL = (CAReplicatorLayer *)self.view.layer;
    repL.instanceCount = 2;
    //绕着复制层的锚点进行旋转
    repL.instanceTransform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    
    //阴影
    repL.instanceRedOffset -= 0.1;
    repL.instanceGreenOffset -= 0.1;
    repL.instanceBlueOffset -= 0.1;
    repL.instanceAlphaOffset -= 0.1;
}



@end
