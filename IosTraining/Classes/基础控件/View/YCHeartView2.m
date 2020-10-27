//
//  YCHeartView2.m
//  UI
//
//  Created by release on 2020/7/29.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCHeartView2.h"


@interface YCHeartView2 ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;

@end
@implementation YCHeartView2


+ (instancetype)HeartView2{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];
}

- (void)setHeartModel:(YCHeartModel *)heartModel{
    _heartModel = heartModel;
    
    self.iconView.image = [UIImage imageNamed:heartModel.icon];
    self.titleView.text = heartModel.name;
}

@end
