//
//  VCMusicPlayer.m
//  UI
//
//  Created by release on 2019/11/18.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import "VCMusicPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface VCMusicPlayer ()<AVAudioPlayerDelegate>
{
    NSArray* _titleArray;
    UIProgressView* _progressView;
    UISlider* _slide;
    UISwitch* _swit;
    AVAudioPlayer* _player;
    NSTimer* _timer;
}

@end

@implementation VCMusicPlayer

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self createPlayer];
}

-(void)initView{
    _titleArray = [NSArray arrayWithObjects:@"播放按钮",@"暂停按钮",@"停止按钮", nil];
    for (int i=0; i<_titleArray.count; i++) {
        UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(150, (1+i)*80+20, 120, 40)];
        [btn setTitle:_titleArray[i] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor systemBlueColor]];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTag:101+i];
        [self.view addSubview:btn];
    }
    
    _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(50, 360, 300, 20)];
    _progressView.progress = 0;
    
    _slide = [[UISlider alloc]initWithFrame:CGRectMake(50, 460, 300, 20)];
    _slide.maximumValue = 100;
    _slide.minimumValue = 0;
    [_slide addTarget:self action:@selector(volumeChange:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:_progressView];
    [self.view addSubview:_slide];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
}


-(void)createPlayer{
    
//    //获取本地资源
//    NSString* str = [[NSBundle mainBundle]pathForResource:@"花火" ofType:@"mp3"];
//    //将字符串转化为url
//    NSURL*urlMusic = [NSURL fileURLWithPath:str];
    NSURL *urlMusic = [[NSBundle mainBundle]URLForResource:@"花火.mp3" withExtension:nil];
    //创建音频播放器对象
    _player = [[AVAudioPlayer alloc]initWithContentsOfURL:urlMusic error:nil];
    
    [_player prepareToPlay];
    [_player setNumberOfLoops:1];
    [_player setVolume:0.5];
    [_player setDelegate:self];
}

-(void)pressBtn:(UIButton*)btn{
 
    switch (btn.tag) {
        case 101:{
            [_player play];
        }
            break;
        case 102:{
            [_player pause];
        }
            break;
        case 103:{
            [_player stop];
            [_player setCurrentTime:0];
        }
            break;
        default:
            break;
    }
}


-(void)volumeChange:(UISlider*)slide{
    [_player setVolume:slide.value/100];
}

-(void)updateProgress{
    _progressView.progress = _player.currentTime/_player.duration;
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    
    [_timer invalidate];
}

- (void)viewDidDisappear:(BOOL)animated{
    [_player stop];
}

@end
