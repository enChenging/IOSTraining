//
//  YCDrawingBoardVC.m
//  UI
//
//  Created by release on 2020/9/3.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCDrawingBoardVC.h"
#import "YCDrawingBoardView.h"
#import "YCHandleImageView.h"


@interface YCDrawingBoardVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,handleImageViewDelegate>
@property (weak, nonatomic) IBOutlet YCDrawingBoardView *drawView;
@property (weak, nonatomic) IBOutlet UISlider *slide;

@end

@implementation YCDrawingBoardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)clear:(id)sender {
    [self.drawView clear];
}
- (IBAction)undo:(id)sender {
    [self.drawView undo];
}
- (IBAction)erase:(id)sender {
    [self.drawView erase];
}
- (IBAction)slideChange:(UISlider *)sender {
    [self.drawView setLineWith:sender.value];
}

- (IBAction)yellowClick:(id)sender {
    [self.drawView setLineColor:[UIColor yellowColor]];
}

- (IBAction)greenClick:(id)sender {
    [self.drawView setLineColor:[UIColor greenColor]];
}
- (IBAction)blueClick:(id)sender {
    [self.drawView setLineColor:[UIColor blueColor]];
}


- (IBAction)photo:(id)sender {
    UIImagePickerController *pickerVC = [[UIImagePickerController alloc]init];
    
    pickerVC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    pickerVC.delegate = self;
    //modal出系统相册
    [self presentViewController:pickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
//    NSData *data =  UIImagePNGRepresentation(image);
//    [data writeToFile:@"/Users/releasemr./Desktop/1.png" atomically:YES];
    
    YCHandleImageView *handleV = [[YCHandleImageView alloc]init];
    handleV.backgroundColor = [UIColor redColor];
    handleV.frame = self.drawView.frame;
    handleV.image = image;
    handleV.delegate = self;
    [self.view addSubview:handleV];
//    UIImageView *imageV = [[UIImageView alloc]initWithFrame:self.drawView.frame];
//    imageV.image = image;
//    imageV.userInteractionEnabled = YES;
//    [self.view addSubview:imageV];
//
//    //添加手势
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
//    [imageV addGestureRecognizer:pan];
//
//    UILongPressGestureRecognizer *longP = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longP:)];
//    [imageV addGestureRecognizer:longP];
    
    
    //取出弹出的相册
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)handleImageView:(YCHandleImageView *)handleImageView newImage:(UIImage *)newImage{
    self.drawView.image = newImage;
}

-(void)pan:(UIPanGestureRecognizer *)pan{
    CGPoint transP = [pan translationInView:pan.view];
    pan.view.transform = CGAffineTransformTranslate(pan.view.transform, transP.x, transP.y);
    //复位
    [pan setTranslation:CGPointZero inView:pan.view];
}

-(void)longP:(UILongPressGestureRecognizer *)longP{
    if (longP.state == UIGestureRecognizerStateBegan) {
        //先让图片闪一下，把图片绘制到画板当中
        [UIView animateWithDuration:0.5 animations:^{
            longP.view.alpha = 0;
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                 longP.view.alpha = 1;
            }completion:^(BOOL finished) {
                //把图片绘制到画板当中
                UIGraphicsBeginImageContextWithOptions(longP.view.bounds.size, NO, 0);
                CGContextRef ctx = UIGraphicsGetCurrentContext();
                [longP.view.layer renderInContext:ctx];
                UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                
                self.drawView.image = newImage;
                [longP.view removeFromSuperview];
                
            }];
        }];
    }
}

- (IBAction)save:(id)sender {
    UIGraphicsBeginImageContextWithOptions(self.drawView.bounds.size,NO,0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.drawView.layer renderInContext:ctx];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
     YCLog(@"saveSucess======");
}


@end
