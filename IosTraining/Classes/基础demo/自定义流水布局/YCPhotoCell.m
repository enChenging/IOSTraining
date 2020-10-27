//
//  YCPhotoCell.m
//  IosTraining
//
//  Created by release on 2020/10/27.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCPhotoCell.h"

@interface YCPhotoCell()

@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@end

@implementation YCPhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setImage:(UIImage *)image{
    _image = image;
    
    _photoView.image = image;
}

@end
