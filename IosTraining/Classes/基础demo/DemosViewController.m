//
//  PersonalViewController.m
//  UI
//
//  Created by release on 2019/11/13.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import "DemosViewController.h"
#import "UIViewTableViewCell.h"
#import "YCLoginVC.h"
#import "YCLuckyVC.h"
#import "YCImageFold.h"
#import "YCVolumeShakeVC.h"
#import "YCInvertedImageVC.h"
#import "YCParticleEffectVC.h"
#import "YCQQStickLayoutVC.h"
#import "YCMultiImageDownloadTVC.h"
#import "YCMIDSDWebImageTVC.h"
#import "YCHomeTVC.h"
#import "YCNeteaseNews2.h"
#import "YCCoustomCollectionVC.h"
#import "YCSinglePictureVC.h"
#import "YCMultiplePictureVC.h"


@interface DemosViewController ()

@property(nonatomic,strong)NSArray *array;
@end

@implementation DemosViewController

- (NSArray *)array{
    if (!_array) {
        _array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"demoList.plist" ofType:nil]];
    }
    return _array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - 数据源方法
/**
 返回多少条
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}


/**
 每条ui
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"demoListID";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//    }
//    cell.textLabel.text = self.array[indexPath.row];
    
    UIViewTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:ID];

       if (!cell) {
           cell = [[UIViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
       }
    cell.nameLable.text = self.array[indexPath.row];
    cell.FistImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"heart%zd",indexPath.row%11]];
    
    return cell;
}

typedef void (^CaseBlock)(void);
/**
 条目点击事件
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *title =  self.array[indexPath.row];
    
    NSDictionary *dict = @{
        @"通讯录xib":^(){
            [self pushStorybVC:@"AddressBook" withTitle:title];
        },
        @"转盘":^(){
            [self pushVC:[[YCLuckyVC alloc]initWithNibName:NSStringFromClass(YCLuckyVC.class) bundle:nil] withTitile:title];
        },
        @"图片折叠":^(){
            [self pushVC:[[YCImageFold alloc]initWithNibName:NSStringFromClass(YCImageFold.class) bundle:nil] withTitile:title];
        },
        @"音量震动条":^(){
            [self pushVC:[[YCVolumeShakeVC alloc]initWithNibName:NSStringFromClass(YCVolumeShakeVC.class) bundle:nil] withTitile:title];
        },
        @"倒影":^(){
            [self pushVC:[[YCInvertedImageVC alloc]initWithNibName:NSStringFromClass(YCInvertedImageVC.class) bundle:nil] withTitile:title];
        },
        @"粒子效果":^(){
            [self pushVC:[[YCParticleEffectVC alloc]initWithNibName:NSStringFromClass(YCParticleEffectVC.class) bundle:nil] withTitile:title];
        },
        @"QQ粘性布局":^(){
            [self pushVC:[[YCQQStickLayoutVC alloc]initWithNibName:NSStringFromClass(YCQQStickLayoutVC.class) bundle:nil] withTitile:title];
        },
        @"多图下载综合案例":^(){
            [self pushStorybVC:NSStringFromClass(YCMultiImageDownloadTVC.class) withTitle:title];
        },
        @"多图下载综合案例-SDWebImage":^(){
            [self pushStorybVC:NSStringFromClass(YCMIDSDWebImageTVC.class) withTitle:title];
        },
        @"父子控制器":^(){
            [self pushVC:[[YCHomeTVC alloc]init] withTitile:title];
        },
        @"网易新闻":^(){
            [self pushVC:[[YCNeteaseNews2 alloc]init] withTitile:title];
        },
        @"自定义流水布局":^(){
            [self pushVC:[[YCCoustomCollectionVC alloc]init] withTitile:title];
        },
        @"相片的选择-单张":^(){
            [self pushVC:[[YCSinglePictureVC alloc]init] withTitile:title];
        },
        @"相片的选择-多张":^(){
            [self pushVC:[[YCMultiplePictureVC alloc]init] withTitile:title];
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

@end
