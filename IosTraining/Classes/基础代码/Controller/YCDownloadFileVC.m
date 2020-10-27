//
//  YCDownloadFileVC.m
//  IosTraining
//
//  Created by release on 2020/10/11.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCDownloadFileVC.h"

@interface YCDownloadFileVC ()<NSURLConnectionDataDelegate>
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@property(nonatomic,assign)NSInteger totalSize;
@property(nonatomic,assign)NSInteger currentSize;
/**文件句柄*/
@property(nonatomic,strong)NSFileHandle *handle;
/**沙盒路径*/
@property(nonatomic,strong)NSString *fullPath;

@property(nonatomic,strong)NSURLConnection *connect;
@end

@implementation YCDownloadFileVC

- (void)viewDidLoad {
    [super viewDidLoad];

   
}
- (IBAction)startDownload:(id)sender {
     [self download];
}

- (IBAction)cancelDownload:(id)sender {
    [self.connect cancel];
}
- (IBAction)goDownload:(id)sender {
    [self download];
}


-(void)download{
    NSURL *url = [NSURL URLWithString:@"http://flv3.bn.netease.com/f183c2176b93b673efeafadcba3cc585a26021e4e0e911e239d66ab600ec390a26b32a25ad5a4d2d53a08ccb8075035660a23962d3c88a64ab58080b2bc591d8cb0645d96637fe0c2b3fafaf30c1def9b0da53837bf6d9940c9a609a74c0e99f9cd9c1f5fcd87f2d7a913970f12b1880b3cbe208bdb0ad06.mp4"];
    //创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //设置请求头信息，告诉服务器值请求一部分数据range
    /**
     bytes=0-100
     bytes=-100
     bytes=100-  请求100之后的所有数据
     */
    NSString *range = [NSString stringWithFormat:@"bytes=%zd-",self.currentSize];
    [request setValue:range forHTTPHeaderField:@"Range"];
    YCLog(@"range------%@",range);
    
    //发起请求
    NSURLConnection *connect = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    self.connect = connect;
}

#pragma mark NSURLConnectionDataDelegate
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
//    YCLog(@"didReceiveResponse");
    //1.得到文件的总大小(本次请求数据的总大小 ！= 文件总大小)
//    self.totalSize = response.expectedContentLength + self.currentSize;
    
    if (self.currentSize > 0) {
        return;
    }
    self.totalSize = response.expectedContentLength;
    
    //2.写到沙盒数据中
    self.fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"123.mp4"];
    //3.创建一个空的文件
    [[NSFileManager defaultManager]createFileAtPath:self.fullPath contents:nil attributes:nil];
    //4.创建文件句柄（指针）
    self.handle = [NSFileHandle fileHandleForWritingAtPath:self.fullPath];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
//     YCLog(@"didReceiveData");
    //1.移动文件句柄到数据的末尾
    [self.handle seekToEndOfFile];
    //2.写数据
    [self.handle writeData:data];
    //3.获取进度
    self.currentSize += data.length;
    
    //进度 = 已经下载/文件的总大小
    YCLog(@"%f",1.0 * self.currentSize/self.totalSize);
    self.progressView.progress = 1.0 * self.currentSize/self.totalSize;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    YCLog(@"didFailWithError--%@",error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
     YCLog(@"connectionDidFinishLoading");
    //关闭文件句柄
    [self.handle closeFile];
    self.handle = nil;
    
    YCLog(@"%@",self.fullPath);
}
@end
