//
//  VCNSOperation.m
//  UI
//
//  Created by release on 2019/11/18.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import "VCNSOperation.h"
#import "YCOperation.h"

@interface VCNSOperation ()

@property(nonatomic,strong)NSOperationQueue *queue;

@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (strong, nonatomic)  UIImage *image1;
@property (strong, nonatomic)  UIImage *image2;
@end

@implementation VCNSOperation

- (void)viewDidLoad {
    [super viewDidLoad];
   
//    [self basicUsage];
//    [self basicUsage2];
//    [self customWithQueue ];
//    [self operatorListener];
    [self infomation];
}



/**
 NSOperation 基本使用
 */
-(void)basicUsage{
    
    //创建任务队列
    NSOperationQueue  *queue = [[NSOperationQueue alloc]init];
    //创建操作，封装任务
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(download1) object:nil];
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(download2) object:nil];
    NSInvocationOperation *op3 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(download3) object:nil];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    
//    [queue setMaxConcurrentOperationCount:3];
}

/**
 NSOperation 基本使用
 */
-(void)basicUsage2{
    //创建任务队列
    NSOperationQueue  *queue = [[NSOperationQueue alloc]init];
    //创建操作
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        YCLog(@"1-----%@",[NSThread currentThread]);
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        YCLog(@"2-----%@",[NSThread currentThread]);
    }];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        YCLog(@"3-----%@",[NSThread currentThread]);
    }];
    //追加任务
    [op2 addExecutionBlock:^{
        YCLog(@"4-----%@",[NSThread currentThread]);
    }];
    [op2 addExecutionBlock:^{
        YCLog(@"5-----%@",[NSThread currentThread]);
    }];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    
    
    //简便方法
    [queue addOperationWithBlock:^{
        YCLog(@"6-----%@",[NSThread currentThread]);
    }];
}


-(void)download1{
    YCLog(@"%s-------%@",__func__,[NSThread currentThread]);
}

-(void)download2{
    YCLog(@"%s-------%@",__func__,[NSThread currentThread]);
}

-(void)download3{
    YCLog(@"%s-------%@",__func__,[NSThread currentThread]);
}

/**
 自定义Operation
 */
-(void)customWithQueue{
    YCOperation *op1 = [[YCOperation alloc]init];
    YCOperation *op2 = [[YCOperation alloc]init];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
}

/**
 开始
 */
- (IBAction)startBtnClick:(id)sender {
    self.queue = [[NSOperationQueue alloc]init];
    
    //设置最大并发数量
    self.queue.maxConcurrentOperationCount = 1;
    
    [self.queue addOperationWithBlock:^{
        for (NSInteger i = 0; i<10000; i++) {
            YCLog(@"download1------%zd---%@",i,[NSThread currentThread]);
        }
    }];
    [self.queue addOperationWithBlock:^{
        for (NSInteger i = 0; i<10000; i++) {
            YCLog(@"download2------%zd---%@",i,[NSThread currentThread]);
        }
    }];
    [self.queue addOperationWithBlock:^{
        for (NSInteger i = 0; i<10000; i++) {
            YCLog(@"download3------%zd---%@",i,[NSThread currentThread]);
        }
    }];
}

/**
 暂停
 */
- (IBAction)suspendBtnClick:(id)sender {
    //暂停，是可以恢复的
    [self.queue setSuspended:YES];
}


/**
 继续
 */
- (IBAction)goOnBtnClick:(id)sender {
    [self.queue setSuspended:NO];
}

/**
 取消
 */
- (IBAction)cancelBtnClick:(id)sender {
    //取消不可以恢复
    [self.queue cancelAllOperations];
}


/**
 操作的依赖和监听
 */
-(void)operatorListener{
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    NSOperationQueue *queue2 = [[NSOperationQueue alloc]init];
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        YCLog(@"1--------%@",[NSThread currentThread]);
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
           YCLog(@"2--------%@",[NSThread currentThread]);
       }];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
           YCLog(@"3--------%@",[NSThread currentThread]);
       }];
    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
           YCLog(@"4--------%@",[NSThread currentThread]);
       }];
    
    //监听操作
    op3.completionBlock = ^{
        YCLog(@"+++++++++++++completionBlock++++++++++++%@",[NSThread currentThread]);
    };
    
    //添加操作依赖
    //注意点：不能循环依赖
    //可以跨队列依赖
    [op4 addDependency:op3];
    [op2 addDependency:op4];
    [op1 addDependency:op2];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    [queue2 addOperation:op4];
}


/**
 线程间的通信
 */
-(void)infomation{
    //1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    //2.下载图片1
    NSBlockOperation *download1 = [NSBlockOperation blockOperationWithBlock:^{
        YCLog(@"download1-----%@",[NSThread currentThread]);
        //1.确定URL
        NSURL *url = [NSURL URLWithString:@"http://cms-bucket.ws.126.net/2019/11/15/f95af90062a645ccaefdd117054c2073.png?imageView&thumbnail=200y140"];
        
        //2.根据url下载图片 二进制数据到本地
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        
        //3.转换图片格式
        self.image1 = [UIImage imageWithData:imageData];
    }];
   
    
    //下载图片2
    NSBlockOperation *download2 = [NSBlockOperation blockOperationWithBlock:^{
        YCLog(@"download2-----%@",[NSThread currentThread]);
        //1.确定URL
        NSURL *url = [NSURL URLWithString:@"http://cms-bucket.ws.126.net/2019/11/15/f95af90062a645ccaefdd117054c2073.png?imageView&thumbnail=200y140"];
        
        //2.根据url下载图片 二进制数据到本地
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        
        //3.转换图片格式
        self.image2 = [UIImage imageWithData:imageData];
    }];
    
    //3.封装合并图片的操作
   NSBlockOperation *combie = [NSBlockOperation blockOperationWithBlock:^{
        YCLog(@"-----------dispatch_group_notify----------");
        
        //1.创建图形上下文
        UIGraphicsBeginImageContext(CGSizeMake(200, 200));
        //2.画图1
        [self.image1 drawInRect:CGRectMake(0, 0, 200, 100)];
        self.image1 = nil;
        //3.画图2
        [self.image2 drawInRect:CGRectMake(0, 100, 200, 100)];
        self.image2 = nil;
        
        //4.根据上下文得到一张图片
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        //5.关闭上下文
        UIGraphicsEndImageContext();
        //6.更新ui
        dispatch_async(dispatch_get_main_queue(), ^{
             YCLog(@"UI-----%@",[NSThread currentThread]);
            self.imageV.image = image;
        });
    }];
    
    //4.设置依赖关系
    [combie addDependency:download1];
    [combie addDependency:download2];
    
    //5.添加操作到队列
    [queue addOperation:download1];
    [queue addOperation:download2];
    [queue addOperation:combie];
}

@end
