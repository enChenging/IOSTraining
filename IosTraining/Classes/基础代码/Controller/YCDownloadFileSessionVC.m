//
//  YCDownloadFileSessionVC.m
//  IosTraining
//
//  Created by release on 2020/10/13.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCDownloadFileSessionVC.h"

@interface YCDownloadFileSessionVC ()<NSURLSessionDownloadDelegate>

@property(nonatomic,strong)NSURLSessionDownloadTask *downTask;
@property(nonatomic,strong)NSURLSession *session;
@property(nonatomic,strong)NSData *resumeData;
@property (weak, nonatomic) IBOutlet UIProgressView *progressV;

@end

@implementation YCDownloadFileSessionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self download];
//    [self download2];
}


- (IBAction)statClickBtn:(id)sender {
    YCLog(@"--------开始--------------");
    
    NSString *strUrl = @"https://img-blog.csdnimg.cn/20190803161250581.gif";
    
    NSURL *url = [NSURL URLWithString:strUrl];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDownloadTask *downTask = [self.session downloadTaskWithRequest:request];
    [downTask resume];
    
    self.downTask = downTask;
}
/**
 暂停是可以恢复的
 */
- (IBAction)suspendClickBtn:(id)sender {
    YCLog(@"--------暂停--------------");
    
    [self.downTask suspend];
}

/**
 cancel:取消是不能恢复的
 cancelByProducingResumeData： 是可以恢复的
 */
- (IBAction)cancelClickBtn:(id)sender {
     YCLog(@"--------取消--------------");
    
//    [self.downTask cancel];
    
    //恢复下载的数据！= 文件数据
    [self.downTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        self.resumeData = resumeData;
    }];
}

- (IBAction)goOnClickBtn:(id)sender {
     YCLog(@"--------恢复下载--------------");
   
    if (self.resumeData) {
        self.downTask = [self.session downloadTaskWithResumeData:self.resumeData];
    }
    
    [self.downTask resume];
}

/**
 优点：无需担心内存
 缺点：无法监听文件下载速度
 */
-(void)download{
    NSString *strUrl = @"https://img-blog.csdnimg.cn/20201009171721906.jpeg";
    
    NSURL *url = [NSURL URLWithString:strUrl];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDownloadTask *downTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        //拼接文件路径
        NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:response.suggestedFilename];
        
        //剪切文件
        [[NSFileManager defaultManager]moveItemAtURL:location toURL:[NSURL fileURLWithPath:fullPath] error:nil];
        YCLog(@"%@",fullPath);
    }];
    
    [downTask resume];
}

-(void)download2{
    NSString *strUrl = @"https://img-blog.csdnimg.cn/20190803161250581.gif";
    
    NSURL *url = [NSURL URLWithString:strUrl];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDownloadTask *downTask = [session downloadTaskWithRequest:request];
    [downTask resume];
}

#pragma mark-----NSURLSessionDownloadDelegate
/**
 写数据
 参数一：session                                    会话对象
 参数二：downloadTask                         下载任务
 参数三：bytesWritten                            本次写入数据的大小
 参数四：totalBytesWritten                     下载数据的总大小
 参数五：totalBytesExpectedToWrite      文件的总大小
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    
    //获得文件的下载速度
    YCLog(@"%f",1.0 * totalBytesWritten/totalBytesExpectedToWrite);
    self.progressV.progress = 1.0 * totalBytesWritten/totalBytesExpectedToWrite;
}

/**
 当回复下载的时候调用该方法
 参数：fileOffset                  从什么地方下载
 参数：expectedTotalBytes  文件的总大小
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes{
    YCLog(@"%s",__func__);
}

/**
 当下载完成的时候调用
 参数：location  文件的临时存储路径
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    
    //拼接文件路径
    NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    
    //剪切文件
    [[NSFileManager defaultManager]moveItemAtURL:location toURL:[NSURL fileURLWithPath:fullPath] error:nil];
    YCLog(@"%@",fullPath);
}

/**
 请求结束
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    YCLog(@"didCompleteWithError");
}
@end
