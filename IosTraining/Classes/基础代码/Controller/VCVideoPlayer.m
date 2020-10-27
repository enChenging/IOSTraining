//
//  VCVideoPlayer.m
//  UI
//
//  Created by release on 2019/11/18.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import "VCVideoPlayer.h"
#import <AVKit/AVKit.h>

@interface VCVideoPlayer ()
{
    AVPlayerViewController* _playController;
}

@end

@implementation VCVideoPlayer

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

-(void)initView{
    UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(150, 100, 120, 40)];
    [btn setTitle:@"播放" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor systemBlueColor]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)moviePlayer{
    
    NSString* strUrl = @"https://vdept.bdstatic.com/316a6a68645249776856344e75656752/31537a5962356c52/007e2ca3ddcb63f9b9f685e8e6e86e95a4838a0141b53504127f705f48e6b559424b52c32675cdea632ad7019d2965d7.mp4?auth_key=1594013622-0-0-50b990dc121943079c69eaf6f90605ae";
    
    NSURL* videoUrl = [NSURL URLWithString:strUrl];
    
    _playController = [[AVPlayerViewController alloc]init];
    _playController.player = [AVPlayer playerWithURL:videoUrl];
    _playController.view.frame = self.view.bounds;
    _playController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _playController.showsPlaybackControls = YES;//是否显示回放
    [self.view addSubview:_playController.view];
}

-(void)pressBtn:(UIButton*)btn{
    [self moviePlayer];
}

@end
