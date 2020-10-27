//
//  VCImageShow.m
//  UI
//
//  Created by release on 2019/11/13.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import "VCImageShow.h"
#import "VCImage.h"

@interface VCImageShow ()
{
    UIScrollView* _sv;
}

@end

@implementation VCImageShow

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

-(void)initView{
    
    //0, 0, 413, 736
    //    _sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 290*3)];
    _sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _sv.contentSize = CGSizeMake(kScreenWidth, 290*5+100);
    _sv.showsVerticalScrollIndicator = NO;
    _sv.scrollEnabled = YES;
    _sv.backgroundColor = [UIColor blueColor];
    _sv.userInteractionEnabled = YES;//开启交互
    [self.view addSubview:_sv];
    
    for (int i=0; i<9; i++) {
        NSString* _imageName = [NSString stringWithFormat:@"guide_%d",i+1];
        UIImageView* _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:_imageName]];
        _imageView.frame = CGRectMake((i%2)*kScreenWidth/2+5,(i/2)*300+10, kScreenWidth/2-10, 290);
        _imageView.userInteractionEnabled = YES;
        
        [_sv addSubview:_imageView];
        
        UITapGestureRecognizer* _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressTap:)];
        _tap.numberOfTapsRequired = 1;
        _tap.numberOfTouchesRequired = 1;
        [_imageView addGestureRecognizer:_tap];
        _imageView.tag = i+1;
    }
}

//方法一
//-(void)pressTap:(UITapGestureRecognizer*)tap{
//    UIImageView* _image = (UIImageView*)tap.view;
//    VCImage* vcImage = [[VCImage alloc]init];
//    vcImage.mImage = _image.image;
//
//    [self.navigationController pushViewController:vcImage animated:NO];
//}

//方法二
-(void)pressTap:(UITapGestureRecognizer*)tap{
    UIImageView* _image = (UIImageView*)tap.view;
    VCImage* vcImage = [[VCImage alloc]init];
    vcImage.mTag = _image.tag;
    
    [self.navigationController pushViewController:vcImage animated:NO];
}

@end
