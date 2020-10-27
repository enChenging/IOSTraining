//
//  VCNSUserDefaults.m
//  UI
//
//  Created by release on 2019/11/14.
//  Copyright © 2019 Mr. release. All rights reserved.
//
/**
 NSUserDefaults用来存储 用户设置 系统配置等一些小的数据。
 因为数据是明文存储在 plist 文件中，不安全，即使只是修改一个 key 都会 load 整个文件，数据多加载慢(IO 内存)，不适合存储大量数据。
 它是单例的，也是线程安全的，是以键值对 key-value 的形式保存在沙盒中
 存储路径为：沙盒路径的Library——>Preferences文件夹中
 相当于全局的变量
 */

#import "VCNSUserDefaults.h"
#import "YCUser.h"
#import "YCDog.h"

@interface VCNSUserDefaults ()

@end

@implementation VCNSUserDefaults

- (void)viewDidLoad {
    [super viewDidLoad];
     NSLog(@"%@",NSHomeDirectory());
}

- (IBAction)writePlist:(id)sender {
    
    //第一个参数：搜索的目录
    //第二个参数：搜索的范围
    //第三个参数：是否展开路径（在ios当中不识别～）
    NSString *path =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:@"data.plist"];
    NSLog(@"%@",filePath);
    
    //把数组保存到沙盒
    NSArray *dataArray = @[@"xiaoming",@20];
    //路径是沙盒路径
    [dataArray writeToFile:filePath atomically:YES];
    
    NSDictionary *dict = @{@"name":@"xiaozhang",@"age":@18};
    NSString *filePath2 = [path stringByAppendingPathComponent:@"dict.plist"];
    [dict writeToFile:filePath2 atomically:YES];
}
- (IBAction)readPlist:(id)sender {
    NSString *path =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:@"data.plist"];
    NSArray *dataArray = [NSArray arrayWithContentsOfFile:filePath];
    NSLog(@"dataArray == %@",dataArray);
    
    NSString *filePath2 = [path stringByAppendingPathComponent:@"dict.plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath2];
    NSLog(@"dict == %@",dict);
}

- (IBAction)writePreference:(id)sender {
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"Xiaoming" forKey:@"Name"];
    [ud setBool:YES forKey:@"isName"];
    [ud setFloat:3.1415926 forKey:@"pai"];
    [ud setInteger:100 forKey:@"age"];
    NSArray* array = [NSArray arrayWithObjects:@"1",@"2",@"3", nil];
    [ud setObject:array forKey:@"array"];
}


- (IBAction)readPreference:(id)sender {
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    NSString* name = [ud objectForKey:@"Name"];
    BOOL boolName = [ud boolForKey:@"isName"];
    float pai = [ud floatForKey:@"pai"];
    NSInteger age = [ud integerForKey:@"age"];
    NSArray* array = [ud objectForKey:@"array"];
    YCLog(@"name=%@,  boolName=%@   pai = %f  age = %zd  array%@",name,boolName?@"YES":@"NO",pai,age,array);
}


- (IBAction)writeNSKeyedArchiver:(id)sender {
    
    YCUser *user = [[YCUser alloc]init];
    user.name = @"xiaoli";
    user.age = 30;
    
    YCDog *dog = [[YCDog alloc]init];
    dog.name = @"xiaohu";
    user.dog = dog;
    
    //获取沙盒目录
    NSString *tempPath = NSTemporaryDirectory();
    NSString *filePath = [tempPath stringByAppendingPathComponent:@"user.data"];
    NSLog(@"filePath === %@",filePath);
    
    //归档 archiveRootObject会调用encodeWithCoder:
    [NSKeyedArchiver archiveRootObject:user toFile:filePath];
}
- (IBAction)readNSKeyedArchiver:(id)sender {
    
    NSString *tempPath = NSTemporaryDirectory();
    NSString *filePath = [tempPath stringByAppendingPathComponent:@"user.data"];
    
    //unarchiveObjectWithFile 会调用
    YCUser *user = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"%@-----%@",user.name,user.dog.name);
}

@end
