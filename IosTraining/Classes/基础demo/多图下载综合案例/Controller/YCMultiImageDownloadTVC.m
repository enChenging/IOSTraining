//
//  YCMultiImageDownloadTVC.m
//  UI
//
//  Created by release on 2020/9/26.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCMultiImageDownloadTVC.h"
#import "YCAPP.h"

@interface YCMultiImageDownloadTVC ()
/** tableView的数据源 */
@property (nonatomic, strong) NSArray *apps;
/**内存缓存*/
@property(nonatomic,strong)NSMutableDictionary *images;
/**队列*/
@property(nonatomic,strong)NSOperationQueue *queue;
/**操作缓存*/
@property(nonatomic,strong)NSMutableDictionary *operations;

@end

@implementation YCMultiImageDownloadTVC

#pragma mark lazy loading

-(NSOperationQueue *)queue{
    if (!_queue) {
        _queue = [[NSOperationQueue alloc]init];
        //设置最大并发数
        _queue.maxConcurrentOperationCount = 5;
    }
    return _queue;
}

- (NSMutableDictionary *)images{
    if (!_images) {
        _images = [NSMutableDictionary dictionary];
    }
    return _images;
}

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

- (NSMutableDictionary *)operations{
    if (_operations) {
        _operations = [NSMutableDictionary dictionary];
    }
    return _operations;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark UITableViewDatasource
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
    static NSString *ID = @"app";
    
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
    //先去看看内存缓存中该图片是否已经存在，如果存在就直接拿来用，否则去检查磁盘缓存
    //如果有磁盘缓存，那么保存一份到内存，设置图片，否则就直接下载
    UIImage *image = [self.images objectForKey:appM.icon];
    if (image) {
        cell.imageView.image = image;
        YCLog(@"%zd处的图片使用了内存缓存中的图片",indexPath.row);
    }else{
        //保存图片到沙盒缓存
        NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        //获得图片的名称，不能包含/
        NSString *fileName = [appM.icon lastPathComponent];
//        YCLog(@"fileName == %@",fileName);
        //拼接图片的全路径
        NSString *fullPath = [caches stringByAppendingPathComponent:fileName];
//        YCLog(@"fullPath == %@",fullPath);
        //检查磁盘缓存
        NSData *imageData = [NSData dataWithContentsOfFile:fullPath];
        //废除
//        imageData = nil;
        if (imageData) {
            UIImage *image = [UIImage imageWithData:imageData];
            cell.imageView.image = image;
            YCLog(@"%zd处的图片使用了磁盘缓存中的图片",indexPath.row);
            //把图片保存到内存缓存
            [self.images setObject:image forKey:appM.icon];
        }else{
            //检查该图片是否正在下载，如果是那么什么都不做，否则再添加下载任务
            NSBlockOperation *download = [self.operations objectForKey:appM.icon];
            if (download) {
                
            }else{
                //先清空cell原来图片
                cell.imageView.image = [UIImage imageNamed:@"placeholder_square"];
                download = [NSBlockOperation blockOperationWithBlock:^{
                    NSURL *url = [NSURL URLWithString:appM.icon];
                    NSData *imageData = [NSData dataWithContentsOfURL:url];
                    UIImage *image = [UIImage imageWithData:imageData];
                    YCLog(@"%zd--------下载----------",indexPath.row);
                    //容错处理
                    if (image == nil) {
                        [self.operations removeObjectForKey:appM.icon];
                        return;
                    }
                    //演示网速慢的情况
                    //                    [NSThread sleepForTimeInterval:3.0];
                    //把图片保存到内存缓存
                    [self.images setObject:image forKey:appM.icon];
                    //线程间通信
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        //刷新一行
                        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationLeft)];
                    }];
                    
                    //写数据到沙盒
                    [imageData writeToFile:fullPath atomically:YES];
                    
                    //移除图片的下载操作
                    [self.operations removeObjectForKey:appM.icon];
                }];
                
                //添加操作到操作缓存中
                [self.operations setObject:download forKey:appM.icon];
                
                //添加操作到队列中
                [self.queue addOperation:download];
            }
        }
    }
    
    return cell;
}
/**
 沙盒路径
 Documents: 会备份，苹果官方不允许
 Libray
 Preferences:偏好设置。保存账号
 caches:缓存文件
 tmp:临时路径（随时会被删除）
 */
- (void)didReceiveMemoryWarning{
    [self.images removeAllObjects];
    
    //取消队列中的所有操作
    [self.queue cancelAllOperations];
}
@end
