//
//  YCEncryptionVC.m
//  IosTraining
//
//  Created by release on 2020/10/14.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCEncryptionVC.h"
#import "NSString+Hash.h"

@interface YCEncryptionVC ()

@end

@implementation YCEncryptionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


-(NSString *)base64EncodeString:(NSString *)string{
    
    //1.线转换为二进制数据
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    //2.对二进制数据进行base64编码，完成之后返回字符串
    return [data base64EncodedStringWithOptions:0];
}

-(NSString *)base64DecodeString:(NSString *)string{
    
    //1.转换为二进制数据
    NSData *data = [[NSData alloc]initWithBase64EncodedString:string options:0];
    //2.把二进制数据在转换为字符串
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}
@end
