//
//  YCFlagView.h
//  UI
//
//  Created by release on 2020/8/13.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FlagItem;
@interface FlagView : UIView

+(instancetype)flagView;

@property(nonatomic,strong)FlagItem *flagItem;

@end

NS_ASSUME_NONNULL_END
