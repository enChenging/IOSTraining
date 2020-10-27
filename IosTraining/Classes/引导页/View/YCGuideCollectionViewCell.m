//
//  YCGuideCollectionViewCell.m
//  UI
//
//  Created by release on 2020/9/18.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCGuideCollectionViewCell.h"
#import "TabBarController.h"

@interface YCGuideCollectionViewCell()

@property(nonatomic,weak)UIImageView *bgImageView;

@property(nonatomic,weak)UIButton *startBtn;

@end

@implementation YCGuideCollectionViewCell

- (UIButton *)startBtn{
    if (!_startBtn) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setBackgroundImage:[UIImage imageNamed:@"guideStart"] forState:UIControlStateNormal];
        [btn sizeToFit];
        btn.center = CGPointMake(kScreenWidth/2, kScreenHeight*0.9);
        [btn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        _startBtn = btn;
    }
    return _startBtn;
}
-(void)nextClick{
    TabBarController *tabBar = [[TabBarController alloc] init];
    self.window.rootViewController = tabBar;
}

- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        [self.contentView addSubview:imageView];
        _bgImageView  = imageView;
    }
    
    return _bgImageView;
}

- (void)setImage:(UIImage *)image{
    _image = image;
    self.bgImageView.image = image;
}

- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count{
    if (indexPath.item == count - 1) {
        //最后一个cell
        self.startBtn.hidden = NO;
    }else{
         self.startBtn.hidden = YES;
    }
}
@end
