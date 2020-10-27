//
//  YCUploadFileAfnVC.m
//  IosTraining
//
//  Created by release on 2020/10/14.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCUploadFileAfnVC.h"
#import <AFNetworking.h>
#define Kboundary @"----WebKitFormBoundaryjv0UfA04ED44AhWx"
#define KNewLine [@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]

@interface YCUploadFileAfnVC ()

@end

@implementation YCUploadFileAfnVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


-(void)upload{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/upload"];
    
    [manager POST:@"http://120.25.226.186:32812/upload" parameters:nil headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        UIImage *image = [UIImage imageNamed:@"duide1"];
        NSData *imageData = UIImagePNGRepresentation(image);
        
//        [formData appendPartWithFileData:imageData name:@"file" fileName:@"123.png" mimeType:@"image/png"];
//        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"/Users/releasemr./Documents/图片素材/图片/礼物.png"] name:@"file" fileName:@"234.png" mimeType:@"image/png" error:nil];
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"/Users/releasemr./Documents/图片素材/图片/礼物.png"] name:@"file" error:nil];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
         YCLog(@"%f", 1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        YCLog(@"上传成功---%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        YCLog(@"上传失败---%@",error);
    }];
}

@end
