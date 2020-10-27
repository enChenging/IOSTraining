//
//  YCNSURLSessionVC.m
//  IosTraining
//
//  Created by release on 2020/10/13.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCNSURLSessionVC.h"

@interface YCNSURLSessionVC ()<NSURLSessionDataDelegate>

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) NSURLConnection *connect;
@property (strong, nonatomic)  NSMutableData *data;

@end

@implementation YCNSURLSessionVC

- (NSMutableData *)data{
    if (!_data) {
        _data = [NSMutableData data];
    }
    return _data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)sendBtnClick:(id)sender {
   
//    [self get];
//    [self get2];
//    [self post];
    [self delegate];
}

-(void)get{
    
    NSString *strUrl = @"http://m2.qiushibaike.com/article/list/suggest?page=1";
    
    NSURL *url = [NSURL URLWithString:strUrl];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSString* str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.label setText:str];
        });
    }];
    
    [dataTask resume];
    
}

-(void)get2{
    
    NSString *strUrl = @"http://m2.qiushibaike.com/article/list/suggest?page=1";
    
    NSURL *url = [NSURL URLWithString:strUrl];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSString* str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.label setText:str];
        });
    }];
    
    [dataTask resume];
}

-(void)post{
    
    NSString *strUrl = @"http://112.6.33.87:8085/app/StbprpWaterReal/list-water";
    
    NSURL *url = [NSURL URLWithString:strUrl];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"POST";
    
    request.HTTPBody = [@"guanlisuoId=101" dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSString* str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.label setText:str];
        });
    }];
    
    [dataTask resume];
    
}

-(void)delegate{
    NSString *strUrl = @"http://m2.qiushibaike.com/article/list/suggest?page=1";
    
    NSURL *url = [NSURL URLWithString:strUrl];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];
    
    [dataTask resume];
}

#pragma mark---NSURLSessionDataDelegate
/**
 1.接收到服务器的响应。它默认会取消该请求
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{
    
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
    //拼接数据
    [self.data appendData:data];
}

/**
 3.请求结束或者失败的时候调用
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    //解析数据
    YCLog(@"%@",[NSThread currentThread]);
    NSString* str = [[NSString alloc]initWithData:self.data encoding:NSUTF8StringEncoding];
    [self.label setText:str];
}

/**
 发送请求是https才会调用该方法
 */
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
    
    
    if (![challenge.protectionSpace.authenticationMethod isEqualToString:@"NSURLAuthenticationMethodServerTrust"]) {
        return;
    }
    
    YCLog(@"%@",challenge.protectionSpace);
    //NSURLSessionAuthChallengeDisposition 如何处理证书
    /*
     NSURLSessionAuthChallengeUseCredential = 0, 使用该证书 安装该证书
     NSURLSessionAuthChallengePerformDefaultHandling = 1, 默认采用的方式,该证书被忽略
     NSURLSessionAuthChallengeCancelAuthenticationChallenge = 2, 取消请求,证书忽略
     NSURLSessionAuthChallengeRejectProtectionSpace = 3,          拒绝
     */
    NSURLCredential *credential = [[NSURLCredential alloc]initWithTrust:challenge.protectionSpace.serverTrust];
    
    //NSURLCredential 授权信息
    completionHandler(NSURLSessionAuthChallengeUseCredential,credential);
}
@end
