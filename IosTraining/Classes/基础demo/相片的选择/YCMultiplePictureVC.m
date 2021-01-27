//
//  YCMultiplePictureVC.m
//  IosTraining
//
//  Created by release on 2020/11/26.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCMultiplePictureVC.h"
#import <TZImagePickerController.h>

@interface YCMultiplePictureVC ()<TZImagePickerControllerDelegate>

@property(nonatomic,weak)TZImagePickerController *imagePickerVc;


@end

@implementation YCMultiplePictureVC

- (void)viewDidLoad {
    [super viewDidLoad];

   
}
- (IBAction)openAuth:(id)sender {
    
    PHAuthorizationStatus oldStatus = [PHPhotoLibrary authorizationStatus];
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (status == PHAuthorizationStatusDenied) {//用户拒绝
                if (oldStatus != PHAuthorizationStatusNotDetermined) {
                    YCLog(@"提醒用户打开开关")
                }
            }else if (status == PHAuthorizationStatusAuthorized){//允许访问
                YCLog(@"--------------")
            }else if (status == PHAuthorizationStatusRestricted){//无法访问
                YCLog(@"因系统原因，无法访问相册")
            }
        });
    }];
}
- (IBAction)selectedPhoto:(id)sender {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    self.imagePickerVc = imagePickerVc;
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        [self.imagePickerVc dismissViewControllerAnimated:YES completion:nil];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}


@end
