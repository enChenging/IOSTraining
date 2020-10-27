//
//  YCDownloadFileAfnVC.m
//  IosTraining
//
//  Created by release on 2020/10/14.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCDownloadFileAfnVC.h"
#import <AFNetworking.h>

@interface YCDownloadFileAfnVC ()

@end

@implementation YCDownloadFileAfnVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self download];
}

-(void)download{
    //1.创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURL *url = [NSURL URLWithString:@"https://img-blog.csdnimg.cn/20190803161250581.gif"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //2.下载文件
    NSURLSessionDownloadTask *download = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        //监听下载进度
        YCLog(@"%f", 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:response.suggestedFilename];
        
        YCLog(@"%@",fullPath);
        return [NSURL fileURLWithPath:fullPath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        YCLog(@"%@",filePath);
    }];
    
    //3.执行task
    [download resume];
}

@end
