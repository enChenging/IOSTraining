//
//  YCFileMimeTypeVC.m
//  IosTraining
//
//  Created by release on 2020/10/12.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCFileMimeTypeVC.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface YCFileMimeTypeVC ()

@end

@implementation YCFileMimeTypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self getMimeType];
    
    NSString *mimeType = [self mimeTypeForFileAtPath:@"/Users/releasemr./Desktop/笔记.txt"];
    YCLog(@"%@",mimeType);
}

/**
 方法一：通过请求响应头获取
 */
-(void)getMimeType{
    //1.url
    NSURL *url = [NSURL URLWithString:@"https://img-blog.csdnimg.cn/20201009171721906.jpeg"];
    //2.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //3.发送异步请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
       //4.获得文件的类型
        YCLog(@"%@",response.MIMEType);
    }];
}

/**
 方法二：调用C语言的API获取
 */
-(NSString *)mimeTypeForFileAtPath:(NSString *)path{
    if (![[[NSFileManager alloc] init] fileExistsAtPath:path]) {
        return nil;
    }
    
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[path pathExtension], NULL);
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    CFRelease(UTI);
    if (!MIMEType) {
        return @"application/octet-stream";
    }
    return (__bridge NSString *)(MIMEType);
}

/**
 方法三：application/octet-stream 任意的二进制数据类型
 */

@end
