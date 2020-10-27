//
//  YCNSURLConnectionVC.m
//  IosTraining
//
//  Created by release on 2020/10/10.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCNSURLConnectionVC.h"

@interface YCNSURLConnectionVC ()<NSURLConnectionDataDelegate>

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic)  NSMutableData *data;

@end

@implementation YCNSURLConnectionVC

- (NSMutableData *)data{
    if (!_data) {
        _data = [NSMutableData data];
    }
    return _data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

/**
 get测试地址：http://124.128.34.246:8084/app/order/detail?id=729F7AF4B8D14788983DDB70E1353F07&type=2
 get测试地址2:http://m2.qiushibaike.com/article/list/suggest?page=1
 post测试地址：http://112.6.33.87:8085/app/StbprpWaterReal/list-water?guanlisuoId=101
 */
- (IBAction)sendBtnClick:(id)sender {
   //get请求
    [self async];
//    [self sync];
//    [self delegate];
    
    //post请求
//    [self post];
}


-(void)async{
    NSString *urlStr = @"http://124.128.34.246:8084/app/order/detail?id=729F7AF4B8D14788983DDB70E1353F07&type=2";
    //中文转码处理
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    //1.确定路径
    NSURL *url = [NSURL URLWithString:urlStr];
    
    //2.创建请求对象
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    //3.发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        //容错处理
        if (connectionError) {
            YCLog(@"%@",connectionError);
            return;
        }
        
        //4.解析 data----->字符串
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        YCLog(@"%@",str);
        [self.label setText:str];
//        NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
//        YCLog(@"%zd",res.statusCode);
    }];
}

-(void)sync{
    //1.确定路径
    NSURL *url = [NSURL URLWithString:@"http://124.128.34.246:8084/app/order/detail?id=729F7AF4B8D14788983DDB70E1353F07&type=2"];
    
    //2.创建请求对象
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    //3.发送请求
    NSHTTPURLResponse *response = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    //4.解析 data----->字符串
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    YCLog(@"%@",str);
    [self.label setText:str];
}


-(void)delegate{
    //1.确定路径
    NSURL *url = [NSURL URLWithString:@"http://124.128.34.246:8084/app/order/detail?id=729F7AF4B8D14788983DDB70E1353F07&type=2"];
    
    //2.创建请求对象
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    //3.设置代理，发送请求
    //3.1
//    [NSURLConnection connectionWithRequest:request delegate:self];
    //3.2
//    [[NSURLConnection alloc]initWithRequest:request delegate:self];
    //3.3设置代理，发送请求需要检查startImmediately的值
    //startImmediately:YES 会发送   startImmediately:NO 则需要调用start方法
    NSURLConnection *connect = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
    [connect start];
}


#pragma mark  NSURLConnectionDataDelegate
/**
1.当接收到服务器响应的时候调用
*/
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{

    NSHTTPURLResponse* res = (NSHTTPURLResponse*)response;

    if (res.statusCode == 200) {
        YCLog(@"连接成功");
    }else if (res.statusCode == 404){
        YCLog(@"服务器正常，请求地址不对");
    }else if (res.statusCode == 500){
        YCLog(@"服务器宕机");
    }
}
/**
 2.接收到服务器返回来的数据时调用，调用多次
 */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    //拼接数据
    [self.data appendData:data];
}

/**
 3.请求失败时调用
 */
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{

    YCLog(@"error == %@",error);
}

/**
 4.请求结束时调用
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSString *str = [[NSString alloc]initWithData:self.data encoding:NSUTF8StringEncoding];
    YCLog(@"%@",str);
    [self.label setText:str];
}


/**
 post 请求
 */
-(void)post{
    //1.确定路径
    NSURL *url = [NSURL URLWithString:@"http://112.6.33.87:8085/app/StbprpWaterReal/list-water"];
    
    //2.创建可变的请求对象
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    
    //3.修改请求方式，post必须大写
    request.HTTPMethod = @"POST";
    
    //设置属性，请求超时
    request.timeoutInterval = 10;
    
    //设置请求头User-Agent
    [request setValue:@"ios 10.1" forHTTPHeaderField:@"User-Agent"];
    
    //4.设置请求提信息
    request.HTTPBody = [@"guanlisuoId=101" dataUsingEncoding:NSUTF8StringEncoding];
    
    //5.发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        //容错处理
        if (connectionError) {
            return;
        }
        //6.解析 data----->字符串
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        YCLog(@"%@",str);
        [self.label setText:str];
    }];
}
@end
