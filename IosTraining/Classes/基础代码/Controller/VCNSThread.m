//
//  VCNSThread.m
//  UI
//
//  Created by release on 2019/11/18.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import "VCNSThread.h"
#import <pthread.h>

@interface VCNSThread ()

@property(nonatomic,assign)NSInteger totalCount;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end

@implementation VCNSThread

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self simpleUnderstanding];
//    [self pthread];
//    [self createNSThread1];
//    [self createNSThread2];
//    [self createNSThread3];
//    [self threadSafe];
//    [NSThread detachNewThreadSelector:@selector(threadCommunication) toTarget:self withObject:nil];
     [NSThread detachNewThreadSelector:@selector(threadCommunication2) toTarget:self withObject:nil];
}

-(void)simpleUnderstanding{
    
    //1.获得主线程
    NSThread *mainThread = [NSThread mainThread];
    YCLog(@"%@",mainThread);
    
    //2.获得当前线程
    NSThread *currentThread = [NSThread currentThread];
    YCLog(@"%@",currentThread);
    
    //3.判断主线程
    //3.1类的方法
    BOOL isMainThreadA = [NSThread isMainThread];
    //3.2对象方法
    BOOL isMainThreadB = [currentThread isMainThread];
    YCLog(@"%d  ---  %d",isMainThreadA,isMainThreadB);
}

-(void)pthread{
    //1.创建线程对象
    pthread_t thread;
    
    //2.创建线程
    /**
     第一个参数：线程对象，传地址
     第二个参数：现成的属性 NULL
     第三个参数：指向函数的指针
     第四个参数：函数需要接受的参数
     */
    pthread_create(&thread, NULL,task, NULL);
}

void *task(void * param){
    for (NSInteger i = 0; i < 1000; i++) {
        YCLog(@"%zd ----- %@",i,[NSThread currentThread]);
    }
    return NULL;
}

/**
 1.alloc init 创建线程，需要手动启动线程
 //线程的生命周期：当任务执行完毕之后被释放掉
 */
-(void)createNSThread1{
    //1.创建线程
    /**
     第一个参数：目标对象 self
     第二个参数：方法选择器，调用的方法
     第三个参数：前面调用方法需要传递的参数 nil
     */
    NSThread *threadA = [[NSThread alloc]initWithTarget:self selector:@selector(run:) object:@"ABC"];
    //设置属性
    threadA.name = @"threadA";
    //设置优优先级 取值范围 0.0 ～ 1.0之间 最高是1.0 默认优先级是0.5
    threadA.threadPriority = 1.0;
    
    //启动线程
    [threadA start];
}

/**
2.分离子线程，自动启动线程
*/
-(void)createNSThread2{
    [NSThread detachNewThreadSelector:@selector(run:) toTarget:self withObject: @"BBBB"];
}

/**
 3.开启一条后台线程
 */
-(void)createNSThread3{
    [self performSelectorInBackground:@selector(run:) withObject:@"FFFF"];
}

-(void)run:(NSString *)param{
    
    YCLog(@"---run---%@---%@",[NSThread currentThread],param);
    
    //阻塞线程
//    [NSThread sleepForTimeInterval:3.0];
    [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:2.0]];
    YCLog(@"---end----");
    
    //退出线程，标示任务已经执行完毕
//    [NSThread exit];
}

-(void)threadSafe{
    //设置票数
    self.totalCount = 100;
    
    NSThread *threadA = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicet) object:nil];
    NSThread *threadB = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicet) object:nil];
    NSThread *threadC = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicet) object:nil];
    
    threadA.name = @"售票员A";
    threadB.name = @"售票员B";
    threadC.name = @"售票员C";
    
//    threadC.threadPriority = 0.6;
    
    //启动线程
    [threadA start];
    [threadB start];
    [threadC start];
    
}

-(void)saleTicet{
    while (1) {
        //锁：必须是全局唯一的
        /**
         1.注意加锁的位置
         2.注意加锁的前提条件，多线程共享同一块资源
         3.注意加锁是需要代价的，需要耗费性能的
         4.加锁的结果：线程同步
         */
        @synchronized (self) {
            NSInteger count = self.totalCount;
            if (count > 0) {
                for (NSInteger i =0; i < 1000000; i++) {
                }
                self.totalCount = count - 1;
                //卖出一张票
                YCLog(@"%@卖出去了一张票，还剩下%zd张票",[NSThread currentThread].name,self.totalCount);
            }else{
                YCLog(@"卖完了");
                break;
            }
        }
    }
}

/**
 线程间通信
 开子线程下载图片，回到主线程刷新UI
  1.计算代码执行时间方法一
 */
-(void)threadCommunication{
    //1.确定URL
    NSURL *url = [NSURL URLWithString:@"http://cms-bucket.ws.126.net/2019/11/15/f95af90062a645ccaefdd117054c2073.png?imageView&thumbnail=200y140"];
    
    NSDate *start = [NSDate date];
    
    //2.根据url下载图片 二进制数据到本地
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    
    NSDate *end = [NSDate date];
    YCLog(@"%f",[end timeIntervalSinceDate:start]);
    
    //3.转换图片格式
    UIImage *image = [UIImage imageWithData:imageData];
    
    YCLog(@"download---%@",[NSThread currentThread]);
    
    //4.回到主线程显示UI
    /**
     第一个参数：回到主线程要调用哪个方法
     第二个参数：前面方法需要传递的参数。
     第三个参数：是否等待
     */
//    [self performSelectorOnMainThread:@selector(showImage:) withObject:image waitUntilDone:NO];
    
//    [self performSelector:@selector(showImage:) onThread:[NSThread mainThread] withObject:image waitUntilDone:YES];
    
    [self.imageV performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:YES];
    
    YCLog(@"----end----");
}

/**
开子线程下载图片，回到主线程刷新UI
 2.计算代码执行时间方法二
*/
-(void)threadCommunication2{
    //1.确定URL
    NSURL *url = [NSURL URLWithString:@"http://cms-bucket.ws.126.net/2019/11/15/f95af90062a645ccaefdd117054c2073.png?imageView&thumbnail=200y140"];
    
    CFTimeInterval start = CFAbsoluteTimeGetCurrent();
    
    //2.根据url下载图片 二进制数据到本地
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    
    CFTimeInterval end = CFAbsoluteTimeGetCurrent();
    YCLog(@"%f",end - start);
    
    //3.转换图片格式
    UIImage *image = [UIImage imageWithData:imageData];
    
    YCLog(@"download---%@",[NSThread currentThread]);
    
    //4.回到主线程显示UI
    /**
     第一个参数：回到主线程要调用哪个方法
     第二个参数：前面方法需要传递的参数。
     第三个参数：是否等待
     */
//    [self performSelectorOnMainThread:@selector(showImage:) withObject:image waitUntilDone:NO];
    
//    [self performSelector:@selector(showImage:) onThread:[NSThread mainThread] withObject:image waitUntilDone:YES];
    
    [self.imageV performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:YES];
    
    YCLog(@"----end----");
}

-(void)showImage:(UIImage *)image{
    self.imageV.image = image;
    YCLog(@"showImage---%@",[NSThread currentThread]);
}

@end
