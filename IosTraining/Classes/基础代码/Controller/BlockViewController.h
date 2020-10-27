//
//  BlockViewController.h
//  UI
//
//  Created by release on 2019/11/25.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^BlockOne)(void);

typedef void (^BlockTwo)(int value);

typedef  NSString* _Nullable(^BlockThree)(void);

typedef  NSString* _Nullable (^BlockFour)(int value);

@interface BlockViewController : UIViewController

@property(nonatomic,copy)BlockOne blockOne;

@property(nonatomic,copy)BlockTwo blockTow;

@property(nonatomic,copy)BlockThree blockThree;

@property(nonatomic,copy)BlockFour blockFour;

@end

NS_ASSUME_NONNULL_END
