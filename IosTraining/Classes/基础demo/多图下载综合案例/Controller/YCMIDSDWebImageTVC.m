//
//  YCMIDSDWebImageTVC.m
//  IosTraining
//
//  Created by release on 2020/9/30.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCMIDSDWebImageTVC.h"
#import "YCAPP.h"
#import <SDWebImage.h>

@interface YCMIDSDWebImageTVC ()
/** tableView的数据源 */
@property (nonatomic, strong) NSArray *apps;

@end

@implementation YCMIDSDWebImageTVC

#pragma mark lazy loading
-(NSArray *)apps
{
    if (_apps == nil) {
        //字典数组
        NSArray *arrayM = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"apps.plist" ofType:nil]];
        //字典数组---->模型数组
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dict in arrayM) {
            [arrM addObject:[YCAPP appWithDict:dict]];
        }
        _apps = arrM;
    }
    return _apps;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.apps.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"app2";
    
    //1.创建cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    //2.设置cell的数据
    //2.1 拿到该行cell对应的数据
    YCAPP *appM = self.apps[indexPath.row];
    
    //2.2 设置标题
    cell.textLabel.text = appM.name;
    
    //2.3 设置子标题
    cell.detailTextLabel.text = appM.download;
    
    //2.4 设置图标
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:appM.icon] placeholderImage:[UIImage imageNamed:@"placeholder_square"]];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:appM.icon] placeholderImage:[UIImage imageNamed:@"placeholder_square"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        YCLog(@"%f",1.0 * receivedSize/expectedSize);
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        YCLog(@"%zd",cacheType);
    }];
    return cell;
}

@end
