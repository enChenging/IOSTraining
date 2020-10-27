//
//  YCGuideCollectionViewCell.h
//  UI
//
//  Created by release on 2020/9/18.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YCGuideCollectionViewCell : UICollectionViewCell

//背景图片
@property(nonatomic,strong)UIImage *image;

-(void)setIndexPath:(NSIndexPath *)indexPath count:(int)count;
@end

NS_ASSUME_NONNULL_END
