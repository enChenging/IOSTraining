//
//  VCImage.m
//  UI
//
//  Created by release on 2019/11/13.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import "VCImage.h"

@interface VCImage ()

@end

@implementation VCImage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

-(void)initView{
    
    _mImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    //方法一
//    _mImageView.image = _mImage;
    //方法二
    _mImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"guide_%d",(int)_mTag]];
    [self.view addSubview:_mImageView];
}

@end
