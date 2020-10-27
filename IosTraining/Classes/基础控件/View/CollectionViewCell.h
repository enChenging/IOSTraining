//
//  CollectionViewCell.h
//  UI
//
//  Created by release on 2019/11/22.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *titleLabel;
 
@property (nonatomic, strong) UIImageView *itemImageView;

@end

NS_ASSUME_NONNULL_END
