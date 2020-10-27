//
//  VCAFNetwork.m
//  UI
//
//  Created by release on 2019/11/18.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import "VCAFNetwork.h"
#import <AFNetworking.h>

@interface VCAFNetwork ()

@property (weak, nonatomic) IBOutlet UILabel *labelV;
@property(nonatomic,strong)AFHTTPSessionManager *manager;

@end

@implementation VCAFNetwork

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self AFNet];
}


-(void)AFNet{
    //1.获得一个网络状态监测管理者
    AFNetworkReachabilityManager *mg = [AFNetworkReachabilityManager sharedManager];
    //2.监听状态的改变
    [mg setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                YCLog(@"蜂窝网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                YCLog(@"wifi");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                YCLog(@"无网络");
                break;
            case AFNetworkReachabilityStatusUnknown:
                YCLog(@"未知");
                break;
            default:
                break;
        }
    }];
    //3.开始监听
    [mg startMonitoring];
    
    
    //创建http网络连接对象
    self.manager = [AFHTTPSessionManager manager];
    //设置请求体数据为json
    [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    //[manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    //设置证书处理方式
    self.manager.securityPolicy.allowInvalidCertificates = YES;
    self.manager.securityPolicy.validatesDomainName = NO;
    
    //返回格式为json
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //如果返回的是xml数据，那么应该修改AFN的解决方案
    //self.manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    //如果返回的数据及不是xml也不是json那么应该修改解析方案为
//    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //可接收的文本格式类型
    self.manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
}

/**
 get请求
 */
- (IBAction)getClick:(id)sender {
    [self.manager GET:@"http://m2.qiushibaike.com/article/list/suggest?page=1" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        YCLog(@"成功---%@",[NSThread currentThread]);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            [self.labelV setText:[self convertToJsonData:responseObject]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        YCLog(@"失败");
    }];
}

/**
 post请求
 */
- (IBAction)postClick:(id)sender {
    
    NSDictionary* _parameters = @{
        @"username":@"陈延成"
    };
    
    [self.manager POST:@"http://api.erp.ctrl.com.cn/app/user/selectUser" parameters:_parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        YCLog(@"成功---%@",[NSThread currentThread]);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            [self.labelV setText:[self convertToJsonData:responseObject]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        YCLog(@"失败");
    }];
}


-(NSString *)convertToJsonData:(NSDictionary *)dict{

    NSError *error;

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];

    NSString *jsonString;

    if (!jsonData) {

        YCLog(@"%@",error);

    }else{

        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];

    }

    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];

    NSRange range = {0,jsonString.length};

    //去掉字符串中的空格

    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];

    NSRange range2 = {0,mutStr.length};

    //去掉字符串中的换行符

    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];

    return mutStr;

}


@end
