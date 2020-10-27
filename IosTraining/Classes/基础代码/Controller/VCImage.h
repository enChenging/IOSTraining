//
//  VCImage.h
//  UI
//
//  Created by release on 2019/11/13.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VCImage : UIViewController

@property(nonatomic)NSInteger mTag;
@property(nonatomic,retain)UIImage* mImage;
@property(nonatomic,strong)UIImageView* mImageView;
@end

NS_ASSUME_NONNULL_END
