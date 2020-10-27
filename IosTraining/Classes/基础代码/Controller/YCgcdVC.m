//
//  YCgcdVC.m
//  UI
//
//  Created by release on 2020/9/23.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCgcdVC.h"
#import "YCSingleTool.h"
#import "YCSinglePerson.h"

@interface YCgcdVC ()
@property (weak, nonatomic) IBOutlet UIImageView *iamgeV;
@property (strong, nonatomic)  UIImage *image1;
@property (strong, nonatomic)  UIImage *image2;

@end

@implementation YCgcdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    [self asyncConcurrent];
    //    [self asyncSerial];
    //    [self syncConcurrent];
    //    [self syncSerial];
    //    [self asyncMain];
    //    [NSThread detachNewThreadSelector:@selector(syncMain) toTarget:self withObject:nil];
    //    [self syncMain];//这样会发生死锁
    //    [self threadCommunication];
    //    [self delay];
//    [self once];
//    [self once];
    [self single];
//    [self barrier];
//    [self apply];
//    [self group1];
//    [self group2];
//    [self group3];
}

/**
 异步函数+并发队列：会开启多条线程，队列中的任务是并发执行
 */
-(void)asyncConcurrent{
    //1.创建队列
    /**
     第一个参数：c语言的字符串，标签
     第二个参数：队列的类型
     DISPATCH_QUEUE_CONCURRENT ：并发
     DISPATCH_QUEUE_SERIAL :串行
     */
    //    dispatch_queue_t queue = dispatch_queue_create("com.release.download", DISPATCH_QUEUE_CONCURRENT);
    
    //获得全局并发队列
    /**
     第一个参数：优先级
     第二个参数：
     */
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //2.封装任务 添加任务到队列中
    dispatch_async(queue, ^{
        YCLog(@"@download1 --- %@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        YCLog(@"@download2 --- %@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        YCLog(@"@download3 --- %@",[NSThread currentThread]);
    });
    
    YCLog(@"----end----");
}

/**
 异步函数+串行队列：会开启多一条线程，队列中的任务是串行执行的
 */
-(void)asyncSerial{
    dispatch_queue_t queue = dispatch_queue_create("com.release.download", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        YCLog(@"@download1 --- %@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        YCLog(@"@download2 --- %@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        YCLog(@"@download3 --- %@",[NSThread currentThread]);
    });
    
    YCLog(@"----end----");
}

/**
 同步函数+并发队列：不会开线程，任务是串行执行的
 */
-(void)syncConcurrent{
    dispatch_queue_t queue = dispatch_queue_create("com.release.download", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(queue, ^{
        YCLog(@"@download1 --- %@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        YCLog(@"@download2 --- %@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        YCLog(@"@download3 --- %@",[NSThread currentThread]);
    });
    
    YCLog(@"----end----");
}

/**
 同步函数+串行队列：不会开线程，任务是串行执行的
 */
-(void)syncSerial{
    dispatch_queue_t queue = dispatch_queue_create("com.release.download", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(queue, ^{
        YCLog(@"@download1 --- %@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        YCLog(@"@download2 --- %@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        YCLog(@"@download3 --- %@",[NSThread currentThread]);
    });
    
    YCLog(@"----end----");
}

/**
 异步函数+主队列：不会开线程，所有任务都在主线程中执行
 */
-(void)asyncMain{
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
        YCLog(@"@download1 --- %@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        YCLog(@"@download2 --- %@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        YCLog(@"@download3 --- %@",[NSThread currentThread]);
    });
    
    YCLog(@"----end----");
}

/**
 同步函数+主队列：死锁
 注意：如果该方法在子线程中执行，那么所有的任务在主线程中执行
 */
-(void)syncMain{
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    //同步函数：立刻马上执行，如果我没有执行完毕，那么后面的也别想执行
    //异步函数：如果我没有执行完毕，那么后面的也可以执行
    dispatch_sync(queue, ^{
        YCLog(@"@download1 --- %@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        YCLog(@"@download2 --- %@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        YCLog(@"@download3 --- %@",[NSThread currentThread]);
    });
    
    YCLog(@"----end----");
}

/**
 GCD线程间通信
 */
-(void)threadCommunication{
    
    NSURL *url = [NSURL URLWithString:@"http://cms-bucket.ws.126.net/2019/11/15/f95af90062a645ccaefdd117054c2073.png?imageView&thumbnail=200y140"];
    //创建子线程下载队列
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //根据url下载图片 二进制数据到本地
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:imageData];
        YCLog(@"download---%@",[NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.iamgeV.image = image;
            YCLog(@"UI---%@",[NSThread currentThread]);
        });
    });
    
}

/**
 GCD 延迟执行
 */
-(void)delay{
    //1.延迟执行的第一种方法
    //    [self performSelector:@selector(task) withObject:nil afterDelay:2.0];
    //2.延迟执行的第二种方法
    //    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(task) userInfo:nil repeats:YES];
    
    //3.延迟执行的第三种方法
    /**
     第一个参数：DISPATCH_TIME_NOW 从现在开始计算时间
     第二个参数：延迟的时间2.0 GCD时间单位：纳秒
     第三个参数：队列
     */
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        YCLog(@"GCD-------%@",[NSThread currentThread]);
    });
}


-(void)task{
    YCLog(@"task-------%@",[NSThread currentThread]);
}

/**
 GCD 实现一次性代码
 不能放到懒加载中 ，应用场景：单例模式
 */
-(void)once{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        YCLog(@"------once-------");
    });
}

/**
 单例模式
 */
-(void)single{
   
    YCSingleTool *s1 = [[YCSingleTool alloc]init];
    YCSingleTool *s2 = [YCSingleTool new];
    YCSingleTool *s3 = [YCSingleTool shareSingleTool];
//    YCSingleTool *s4 = [s1 copy];
    //    YCSingleTool *s5 = [s1 mutableCopy];
    
    //    YCLog(@"s1:%@ s2:%@ s3:%@ s4:%@ s5:%@",s1,s2,s3,s4,s5);
    YCLog(@"s1:%@ s2:%@ s3:%@",s1,s2,s3);
    
    YCSinglePerson *p1 = [[YCSinglePerson alloc]init];
    YCSinglePerson *p2 = [YCSinglePerson new];
    YCSinglePerson *p3 = [YCSinglePerson shareSinglePerson];
    
    YCLog(@"p1:%@ p2:%@ p3:%@",p1,p2,p3);
}

/**
 GCD 栅栏函数
 */
-(void)barrier{
    //1.获取全局并发队列
    //栅栏函数不能使用全局并发队列
    //    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t queue = dispatch_queue_create("download", DISPATCH_QUEUE_CONCURRENT);
    //2.异步函数
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i<10; i++) {
            YCLog(@"download------%zd--%@",i,[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i<10; i++) {
            YCLog(@"download2------%zd--%@",i,[NSThread currentThread]);
        }
    });
    
    //栅栏函数
    dispatch_barrier_async(queue, ^{
        YCLog(@"+++++++++++++++++++++++++++++++");
    });
    
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i<10; i++) {
            YCLog(@"download3------%zd--%@",i,[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i<10; i++) {
            YCLog(@"download4------%zd--%@",i,[NSThread currentThread]);
        }
    });
}

/**
 GCD 快速迭代
 子线程和主线程一起完成遍历任务，任务的执行时并发的
 */
-(void)apply{
    /**
     第一个参数：遍历的次数
     第二个参数：队列（并发队列）
     第三个参数：index 索引
     */
    dispatch_apply(10, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
        YCLog(@"%zd------%@",index,[NSThread currentThread]);
    });
}

//使用for循环
-(void)moveFile
{
    //1.拿到文件路径
    NSString *from = @"/Users[表情]omage/Desktop/from";
    
    //2.获得目标文件路径
    NSString *to = @"/Users[表情]omage/Desktop/to";
    
    //3.得到目录下面的所有文件
    NSArray *subPaths = [[NSFileManager defaultManager] subpathsAtPath:from];
    
    NSLog(@"%@",subPaths);
    //4.遍历所有文件,然后执行剪切操作
    NSInteger count = subPaths.count;
    
    for (NSInteger i = 0; i< count; i++) {
        
        //4.1 拼接文件的全路径
       // NSString *fullPath = [from stringByAppendingString:subPaths[i]];
        //在拼接的时候会自动添加/
        NSString *fullPath = [from stringByAppendingPathComponent:subPaths[i]];
        NSString *toFullPath = [to stringByAppendingPathComponent:subPaths[i]];
        
        NSLog(@"%@",fullPath);
        //4.2 执行剪切操作
        /*
         第一个参数:要剪切的文件在哪里
         第二个参数:文件应该被存到哪个位置
         */
        [[NSFileManager defaultManager]moveItemAtPath:fullPath toPath:toFullPath error:nil];
        
        NSLog(@"%@---%@--%@",fullPath,toFullPath,[NSThread currentThread]);
    }
}

/**
 GCD 快速迭代
 应用场景
 */
-(void)moveFileWithGCD
{
    //1.拿到文件路径
    NSString *from = @"/Users[表情]omage/Desktop/from";
    
    //2.获得目标文件路径
    NSString *to = @"/Users[表情]omage/Desktop/to";
    
    //3.得到目录下面的所有文件
    NSArray *subPaths = [[NSFileManager defaultManager] subpathsAtPath:from];
    
    NSLog(@"%@",subPaths);
    //4.遍历所有文件,然后执行剪切操作
    NSInteger count = subPaths.count;
    
    dispatch_apply(count, dispatch_get_global_queue(0, 0), ^(size_t i) {
        //4.1 拼接文件的全路径
        // NSString *fullPath = [from stringByAppendingString:subPaths[i]];
        //在拼接的时候会自动添加/
        NSString *fullPath = [from stringByAppendingPathComponent:subPaths[i]];
        NSString *toFullPath = [to stringByAppendingPathComponent:subPaths[i]];
        
        NSLog(@"%@",fullPath);
        //4.2 执行剪切操作
        /*
         第一个参数:要剪切的文件在哪里
         第二个参数:文件应该被存到哪个位置
         */
        [[NSFileManager defaultManager]moveItemAtPath:fullPath toPath:toFullPath error:nil];
        
        NSLog(@"%@---%@--%@",fullPath,toFullPath,[NSThread currentThread]);

    });
}

/**
 GCD队列的基本使用
 */
-(void)group1{
    //1.创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    //2.创建队列组
    dispatch_group_t group = dispatch_group_create();
    
   
//    dispatch_async(queue, ^{
//        YCLog(@"1-----%@",[NSThread currentThread]);
//    });
    
     //3.异步函数
    dispatch_group_async(group, queue, ^{
         YCLog(@"1-----%@",[NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{
         YCLog(@"2-----%@",[NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{
         YCLog(@"3-----%@",[NSThread currentThread]);
    });
    
    //拦截通知，当队列组中所有的任务都执行完毕的时候会进入下面的方法
    dispatch_group_notify(group, queue, ^{
         YCLog(@"-----------dispatch_group_notify----------");
    });
}

/**
 GCD队列的基本使用
 以前的写法
 */
-(void)group2{
    //1.创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    //2.创建队列组
    dispatch_group_t group = dispatch_group_create();
    
    //3.在该方法的后的异步任务会被纳入到队列组的监听范围，进入群组
    dispatch_group_enter(group);
    
    //4.异步函数
    dispatch_async(queue, ^{
        YCLog(@"1-----%@",[NSThread currentThread]);
        //离开群组
        dispatch_group_leave(group);
    });
    

    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        YCLog(@"2-----%@",[NSThread currentThread]);
        dispatch_group_leave(group);
    });
    

    //拦截通知
    //内部本身是异步的
//    dispatch_group_notify(group, queue, ^{
//         YCLog(@"-----------dispatch_group_notify----------");
//    });
    
    //等待。。死等 直到队列组中的所有的任务都执行完毕后才能执行
    //阻塞的
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    YCLog(@"--------end------");
}

/**
 GCD队列的基本使用
 下载图片1 开子线程
 下载图片2 开子线程
 合成图片并显示图片。
 */
-(void)group3{
    //1.创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    //2.创建队列组
    dispatch_group_t group = dispatch_group_create();
    
    //3.下载图片1
    dispatch_group_async(group, queue, ^{
        YCLog(@"download1-----%@",[NSThread currentThread]);
        //1.确定URL
        NSURL *url = [NSURL URLWithString:@"http://cms-bucket.ws.126.net/2019/11/15/f95af90062a645ccaefdd117054c2073.png?imageView&thumbnail=200y140"];
        
        //2.根据url下载图片 二进制数据到本地
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        
        //3.转换图片格式
        self.image1 = [UIImage imageWithData:imageData];
        
    });
    
    //下载图片2
    dispatch_group_async(group, queue, ^{
        YCLog(@"download2-----%@",[NSThread currentThread]);
        //1.确定URL
        NSURL *url = [NSURL URLWithString:@"http://cms-bucket.ws.126.net/2019/11/15/f95af90062a645ccaefdd117054c2073.png?imageView&thumbnail=200y140"];
        
        //2.根据url下载图片 二进制数据到本地
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        
        //3.转换图片格式
        self.image2 = [UIImage imageWithData:imageData];
    });
    
    //拦截通知，当队列组中所有的任务都执行完毕的时候会进入下面的方法
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
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
            self.iamgeV.image = image;
        });
    });
}


@end
