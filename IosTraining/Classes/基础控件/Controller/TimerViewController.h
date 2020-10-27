//
//  TimerViewController.h
//  UI
//
//  Created by release on 2019/11/8.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimerViewController : UIViewController

{
    NSTimer* _timerView;
}
@property(nonatomic,strong)NSTimer*  timer;
@end

NS_ASSUME_NONNULL_END
