//
//  YCSinglePictureVC.m
//  IosTraining
//
//  Created by release on 2020/11/26.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCSinglePictureVC.h"
#import <AVFoundation/AVFoundation.h>

@interface YCSinglePictureVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end

@implementation YCSinglePictureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)selectPhoto:(id)sender {
    YCLog(@"-----------")
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //按钮
    [alert addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openAlbum];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"照相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           [self openCamera];
       }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

/**
 打开相册
 UIImagePickerControllerSourceTypePhotoLibrary, 从所有相册中选一张图片
 UIImagePickerControllerSourceTypeCamera,利用照相机拍一张图片
 UIImagePickerControllerSourceTypeSavedPhotosAlbum 冲Moments相册中选一张图片
 */
-(void)openAlbum{
    UIImagePickerController *pick = [[UIImagePickerController alloc]init];
    pick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pick.delegate = self;
    [self presentViewController:pick animated:YES completion:nil];
}

/**
 打开照相机
 */
-(void)openCamera{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])return;
    UIImagePickerController *pick = [[UIImagePickerController alloc]init];
    pick.sourceType = UIImagePickerControllerSourceTypeCamera;
    pick.delegate = self;
    [self presentViewController:pick animated:YES completion:nil];
}

#pragma mark - <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    YCLog(@"%@",info)
    //关闭图片选择界面
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //显示选择的图片
    self.imageV.image = info[UIImagePickerControllerOriginalImage];
}


@end
