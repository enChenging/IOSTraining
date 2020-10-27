//
//  YCDownloadFileResumeVC.m
//  IosTraining
//
//  Created by release on 2020/10/13.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCDownloadFileResumeVC.h"
#define FileName @"11.gif"

@interface YCDownloadFileResumeVC ()<NSURLSessionDataDelegate>

@property(nonatomic,strong)NSURLSessionDataTask *dataTask;
@property(nonatomic,strong)NSURLSession *session;
@property(nonatomic,strong)NSFileHandle *handle;
@property(nonatomic,strong)NSString *fullPath;
@property(nonatomic,assign)NSInteger totalSize;
@property(nonatomic,assign)NSInteger currentSize;
@property (weak, nonatomic) IBOutlet UIProgressView *progressV;

@end

@implementation YCDownloadFileResumeVC

- (NSString *)fullPath{
    if (!_fullPath) {
        _fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:FileName];
    }
    
    return _fullPath;
}

- (NSURLSession *)session{
    
    if (!_session) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (NSURLSessionDataTask *)dataTask{
    if (!_dataTask) {
        NSString *strUrl = @"https://img-blog.csdnimg.cn/20190803161250581.gif";
        
        NSURL *url = [NSURL URLWithString:strUrl];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        //设置请求头信息，告诉服务器请求哪一部分数据
        self.currentSize = [self getFileSize];
        NSString *range = [NSString stringWithFormat:@"bytes=%zd-",self.currentSize];
        [request setValue:range forHTTPHeaderField:@"Range"];
        
        _dataTask = [self.session dataTaskWithRequest:request];
    }
    
    return _dataTask;
}

-(NSInteger)getFileSize{
    
    //获取指定文件路径对应文件的数据大小
    NSDictionary *fileInfoDict = [[NSFileManager defaultManager]attributesOfItemAtPath:self.fullPath error:nil];
//    YCLog(@"%@",fileInfoDict);
    
    NSInteger currentsize = [fileInfoDict[@"NSFileSize"]integerValue];
    return currentsize;
}

- (IBAction)startClick:(id)sender {
    YCLog(@"--------开始--------------");
    [self.dataTask resume];
}

- (IBAction)pauseClick:(id)sender {
    YCLog(@"--------暂停--------------");
    [self.dataTask suspend];
}

- (IBAction)cancelClick:(id)sender {
    YCLog(@"--------取消--------------");
    [self.dataTask cancel];
}

- (IBAction)goOnCLick:(id)sender {
    YCLog(@"--------恢复下载--------------");
    [self.dataTask resume];
}

#pragma mark---NSURLSessionDataDelegate
/**
 1.接收到服务器的响应。它默认会取消该请求
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{
    
    //获得文件的总大小
    self.totalSize = response.expectedContentLength + self.currentSize;
    
    if (self.currentSize == 0) {
        //创建空的文件
        [[NSFileManager defaultManager]createFileAtPath:self.fullPath contents:nil attributes:nil];
    }
    
    //创建文件句柄
    self.handle = [NSFileHandle fileHandleForWritingAtPath:self.fullPath];
    
    //移动指针
    [self.handle seekToEndOfFile];
    
    /**
    NSURLSessionResponseCancel = 0,                                       取消，默认
    NSURLSessionResponseAllow = 1,                                          接收
    NSURLSessionResponseBecomeDownload = 2,                     安成下载任务
    NSURLSessionResponseBecomeStream                                变成流
     */
    completionHandler(NSURLSessionResponseAllow);//回调传给系统
}

/**
 2.接收到服务器返回的数据。调用多次
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    
    //写入数据到文件
    [self.handle writeData:data];
    
    //计算文件的下载进度
    self.currentSize += data.length;
    
    YCLog(@"%f",1.0 * self.currentSize/self.totalSize);
    self.progressV.progress = 1.0 * self.currentSize/self.totalSize;
    
}

/**
 3.请求结束或者失败的时候调用
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
   
    YCLog(@"%@",self.fullPath);
    
    //关闭文件句柄
    [self.handle closeFile];
    self.handle = nil;
}

- (void)dealloc
{
    //清理工作
    [self.session invalidateAndCancel];
}
@end
