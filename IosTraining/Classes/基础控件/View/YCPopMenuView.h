//
//  YCPopMenuView.h
//  UI
//
//  Created by release on 2020/9/17.
//  Copyright © 2020 Mr. release. All rights reserved.
//

typedef void (^MyBlock)();
#import <UIKit/UIKit.h>
@class YCPopMenuView;

@protocol YCPopMenuDelegate <NSObject>

- (void)popMenuDidCloseBtn:(YCPopMenuView *_Nullable)popMenu;

@end

NS_ASSUME_NONNULL_BEGIN

@interface YCPopMenuView : UIView

+ (instancetype)showInPoint:(CGPoint)point;

@property(nonatomic,weak)id<YCPopMenuDelegate> delegate;

//-(void)hideInCenter;

//没有参数没有返回值block void(^)()
//-(void)hideInCenter:(CGPoint)center completion:(参数类型)参数名;
-(void)hideInCenter:(CGPoint)center completion:(MyBlock)completion;

@end

NS_ASSUME_NONNULL_END
