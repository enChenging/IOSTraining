//
//  HomeViewController.m
//  UI
//
//  Created by release on 2019/11/13.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import "UseViewController.h"
#import "UIViewTableViewCell.h"
#import "VCImageShow.h"
#import "VCNSUserDefaults.h"
#import "VCPassByValue.h"
#import "VCNSThread.h"
#import "VCNSOperation.h"
#import "YCNSURLConnectionVC.h"
#import "YCNSURLSessionVC.h"
#import "VCParseJson.h"
#import "YCParseXmlVC.h"
#import "YCDownloadFileVC.h"
#import "YCDownloadFileIOVC.h"
#import "YCUploadFileVC.h"
#import "YCFileMimeTypeVC.h"
#import "YCZipVC.h"
#import "YCDownloadFileSessionVC.h"
#import "YCDownloadFileResumeVC.h"
#import "YCUploadSessionVC.h"
#import "VCAFNetwork.h"
#import "YCDownloadFileAfnVC.h"
#import "VCMusicPlayer.h"
#import "VCVideoPlayer.h"
#import "VCAnimation.h"
#import "VCNavigationAnimator.h"
#import "BlockViewController.h"
#import "YCDictionaryToModel.h"
#import "YCUIApplicationController.h"
#import "YCUIPickViewController.h"
#import "YCUserInfoVC.h"
#import "YCHitTestVC.h"
#import "YCHitTest2VC.h"
#import "DragerViewController.h"
#import "YCDrawLineVC.h"
#import "YCProgressVC.h"
#import "YCPieVC.h"
#import "YCSnowflakeVC.h"
#import "YCGraphicsContextVC.h"
#import "YCWaterMarkVC.h"
#import "YCImageCropVC.h"
#import "YCImageSwipeVC.h"
#import "YCDeblockVC.h"
#import "YCDrawingBoardVC.h"
#import "YCClockVC.h"
#import "YCgcdVC.h"
#import "YCEnumVC.h"
#import "YCNSRunLoopVC.h"
#import "YCNSRunLoopTrainVC.h"
#import "YCNewFeaturesVC.h"
#import "YCRuntimeVC.h"

@interface UseViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)NSArray* ceshiArray;

@end

@implementation UseViewController

/**
 懒加载
 */
- (NSArray *)ceshiArray{
    if (_ceshiArray == nil) {
        NSString *dataPath = [[NSBundle mainBundle]pathForResource:@"useUI.plist" ofType:nil];
        self.ceshiArray = [NSArray arrayWithContentsOfFile:dataPath];
    }
    return _ceshiArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    NSArray *ceshiArray = @[@"照片墙",@"NSUserDefaults",@"多界面传值",@"Json数据解析",@"NSURLConnect",@"NSThread",@"NSOperation",@"AFNetwork",@"音频播放",@"视频播放",@"动画",@"导航控制器动画",@"Block"];
    //    BOOL flag = [ceshiArray writeToFile:@"/Users/releasemr./Desktop/useUI.plist" atomically:YES];
    //    if (flag) {
    //        YCLog(@"写入成功");
    //    }
    YCLog(@"=== %@",self.ceshiArray);
    [self initView];
}


-(void)initView{
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 50, 0, 0);
    
    _tableView.scrollEnabled = YES;//石否可以有滚动效果
    _tableView.bounces = YES;//是否可以边缘弹动效果
    _tableView.alwaysBounceVertical = YES;
    _tableView.showsVerticalScrollIndicator = YES;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 80)];
    [self.view addSubview:_tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ceshiArray.count;
}

////设置数据视图的组数
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 2;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* indentify = @"cellr4rfrklfkre";
    UIViewTableViewCell* cell=[_tableView dequeueReusableCellWithIdentifier:indentify];
    
    if (!cell) {
        cell = [[UIViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentify];
    }
    
    cell.nameLable.text = self.ceshiArray[indexPath.row];
    cell.FistImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"heart%zd",indexPath.row%11]];
    
    return cell;
}

typedef void (^CaseBlock)(void);

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *title =  self.ceshiArray[indexPath.row];
    NSDictionary *dict = @{
        @"照片墙":^(){
            [self pushVC:[[VCImageShow alloc]init] withTitile:title];
        },
        @"数据存储的常用方式":^(){
            [self pushVC:[[VCNSUserDefaults alloc]initWithNibName:NSStringFromClass(VCNSUserDefaults.class) bundle:nil] withTitile:title];
        },
        @"字典转模型":^(){
            [self pushVC:[[YCDictionaryToModel alloc]init] withTitile:title];
        },
        @"多界面传值":^(){
            [self pushVC:[[VCPassByValue alloc]init] withTitile:title];
        },
        @"NSThread":^(){
            [self pushVC:[[VCNSThread alloc]init] withTitile:title];
        },
        @"GCD":^(){
            [self pushVC:[[YCgcdVC alloc]init] withTitile:title];
        },
        @"NSOperation":^(){
            [self pushVC:[[VCNSOperation alloc]init] withTitile:title];
        },
        @"NSURLConnection":^(){
            [self pushVC:[[YCNSURLConnectionVC alloc]init] withTitile:title];
        },
        @"Json数据解析":^(){
            [self pushVC:[[VCParseJson alloc]init] withTitile:title];
        },
        @"xml数据解析":^(){
            [self pushVC:[[YCParseXmlVC alloc]init] withTitile:title];
        },
        @"文件断点下载":^(){
            [self pushVC:[[YCDownloadFileVC alloc]init] withTitile:title];
        },
        @"输出流文件断点下载":^(){
            [self pushVC:[[YCDownloadFileIOVC alloc]init] withTitile:title];
        },
        @"文件上传":^(){
            [self pushVC:[[YCUploadFileVC alloc]init] withTitile:title];
        },
        @"获取文件的MIMEType":^(){
            [self pushVC:[[YCFileMimeTypeVC alloc]init] withTitile:title];
        },
        @"文件的压缩和解压缩":^(){
            [self pushVC:[[YCZipVC alloc]init] withTitile:title];
        },
        @"NSURLSession":^(){
            [self pushVC:[[YCNSURLSessionVC alloc]init] withTitile:title];
        },
        @"文件下载（URLSession）":^(){
            [self pushVC:[[YCDownloadFileSessionVC alloc]init] withTitile:title];
        },
        @"文件断点下载（URLSession）":^(){
            [self pushVC:[[YCDownloadFileResumeVC alloc]init] withTitile:title];
        },
        @"文件上传（URLSession）":^(){
            [self pushVC:[[YCUploadSessionVC alloc]init] withTitile:title];
        },
        @"AFNetwork":^(){
            [self pushVC:[[VCAFNetwork alloc]init] withTitile:title];
        },
        @"文件下载（AFNetwork）":^(){
            [self pushVC:[[YCDownloadFileAfnVC alloc]init] withTitile:title];
        },
        @"文件上传（AFNetwork）":^(){
            [self pushVC:[[VCAFNetwork alloc]init] withTitile:title];
        },
        @"序列化（AFNetwork）":^(){
            [self pushVC:[[VCAFNetwork alloc]init] withTitile:title];
        },
        @"加密":^(){
            [self pushVC:[[VCAFNetwork alloc]init] withTitile:title];
        },
        @"音频播放":^(){
            [self pushVC:[[VCMusicPlayer alloc]init] withTitile:title];
        },
        @"视频播放":^(){
            [self pushVC:[[VCVideoPlayer alloc]init] withTitile:title];
        },
        @"动画":^(){
            [self pushVC:[[VCAnimation alloc]init] withTitile:title];
        },
        @"导航控制器动画":^(){
            [self pushVC:[[VCNavigationAnimator alloc]init] withTitile:title];
        },
        @"Block":^(){
            [self pushVC:[[BlockViewController alloc]init] withTitile:title];
        },
        @"UIApplication":^(){
            [self pushVC:[[YCUIApplicationController alloc]initWithNibName:@"UIApplicationView" bundle:nil] withTitile:title];
        },
        @"PickView":^(){
            [self pushVC:[[YCUIPickViewController alloc]initWithNibName:@"UIPickView" bundle:nil] withTitile:title];
        },
        @"个人详情":^(){
            [self pushStorybVC:NSStringFromClass(YCUserInfoVC.class) withTitle:title];
        },
        @"hitTest练习1":^(){
            [self pushVC:[[YCHitTestVC alloc]initWithNibName:NSStringFromClass(YCHitTestVC.class) bundle:nil] withTitile:title];
        },
        @"hitTest练习2":^(){
            [self pushVC:[[YCHitTest2VC alloc]initWithNibName:NSStringFromClass(YCHitTest2VC.class) bundle:nil] withTitile:title];
        },
        @"抽屉效果":^(){
            [self pushVC:[[DragerViewController alloc]init] withTitile:title];
        },
        @"基本线条绘制":^(){
            [self pushVC:[[YCDrawLineVC alloc]initWithNibName:NSStringFromClass(YCDrawLineVC.class) bundle:nil] withTitile:title];
        },
        @"下载进度条":^(){
            [self pushVC:[[YCProgressVC alloc]initWithNibName:NSStringFromClass(YCProgressVC.class) bundle:nil] withTitile:title];
        },
        @"饼图":^(){
            [self pushVC:[[YCPieVC alloc]initWithNibName:NSStringFromClass(YCPieVC.class) bundle:nil] withTitile:title];
        },
        @"雪花":^(){
            [self pushVC:[[YCSnowflakeVC alloc]initWithNibName:NSStringFromClass(YCSnowflakeVC.class) bundle:nil] withTitile:title];
        },
        @"图形上下文(栈+矩阵)":^(){
            [self pushVC:[[YCGraphicsContextVC alloc]initWithNibName:NSStringFromClass(YCGraphicsContextVC.class) bundle:nil] withTitile:title];
        },
        @"图片加水印/圆形裁剪/截屏":^(){
            [self pushVC:[[YCWaterMarkVC alloc]initWithNibName:NSStringFromClass(YCWaterMarkVC.class) bundle:nil] withTitile:title];
        },
        @"图片裁剪":^(){
            [self pushVC:[[YCImageCropVC alloc]initWithNibName:NSStringFromClass(YCImageCropVC.class) bundle:nil] withTitile:title];
        },
        @"图片擦除":^(){
            [self pushVC:[[YCImageSwipeVC alloc]initWithNibName:NSStringFromClass(YCImageSwipeVC.class) bundle:nil] withTitile:title];
        },
        @"手势解锁":^(){
            [self pushVC:[[YCDeblockVC alloc]initWithNibName:NSStringFromClass(YCDeblockVC.class) bundle:nil] withTitile:title];
        },
        @"画板":^(){
            [self pushVC:[[YCDrawingBoardVC alloc]initWithNibName:NSStringFromClass(YCDrawingBoardVC.class) bundle:nil] withTitile:title];
        },
        @"时钟":^(){
            [self pushVC:[[YCClockVC alloc]initWithNibName:NSStringFromClass(YCClockVC.class) bundle:nil] withTitile:title];
        },
        @"位移枚举":^(){
             [self pushVC:[[YCEnumVC alloc]init] withTitile:title];
        },
        @"NSRunLoop":^(){
            [self pushVC:[[YCNSRunLoopVC alloc]init] withTitile:title];
        },
        @"RunLoop应用":^(){
            [self pushVC:[[YCNSRunLoopTrainVC alloc]init] withTitile:title];
        },
        @"ios9新特性":^(){
            [self pushVC:[[YCNewFeaturesVC alloc]init] withTitile:title];
        },
        @"Runtime":^(){
            [self pushVC:[[YCRuntimeVC alloc]init] withTitile:title];
        },
    };
    
    CaseBlock c = (CaseBlock)dict[title];
    if (c) {
        c();
    }

}

-(void)pushVC:(UIViewController *)vc withTitile:(NSString *)title {
    vc.title = title;
    vc.modalPresentationStyle=UIModalPresentationFullScreen;
    [self.navigationController pushViewController:vc animated:NO];
}

-(void)pushStorybVC:(NSString *)name withTitle:(NSString *)title{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:name bundle:nil];
    UIViewController *vc = [sb instantiateInitialViewController];
    vc.title = title;
    [self.navigationController pushViewController:vc animated:NO];
}

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}

@end
