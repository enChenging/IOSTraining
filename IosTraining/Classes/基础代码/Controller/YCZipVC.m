//
//  YCZipVC.m
//  IosTraining
//
//  Created by release on 2020/10/13.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCZipVC.h"
#import <SSZipArchive.h>

@interface YCZipVC ()

@end

@implementation YCZipVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self zip];
//    [self zip2];
//    [self unZip];
}

-(void)zip{
    
    NSArray *arrayM = @[
        @"/Users/releasemr./Desktop/用户名.txt",
        @"/Users/releasemr./Desktop/账号密码.txt"
    ];
    
    [SSZipArchive createZipFileAtPath:@"/Users/releasemr./Desktop/Test.zip" withFilesAtPaths:arrayM];
}

-(void)zip2{
    
    [SSZipArchive createZipFileAtPath:@"/Users/releasemr./Desktop/视频.zip" withContentsOfDirectory:@"/Users/releasemr./Documents/视频"];
}

-(void)unZip{
    [SSZipArchive unzipFileAtPath:@"/Users/releasemr./Desktop/视频.zip" toDestination:@"/Users/releasemr./Desktop/视频" progressHandler:^(NSString * _Nonnull entry, unz_file_info zipInfo, long entryNumber, long total) {
        YCLog(@"%zd-----%zd",entryNumber,total);
    } completionHandler:^(NSString * _Nonnull path, BOOL succeeded, NSError * _Nullable error) {
        YCLog(@"%@",path);
        YCLog(@"%d",succeeded);
    }];
}


@end
