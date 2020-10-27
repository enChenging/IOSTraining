//
//  YCInVertedView.m
//  UI
//
//  Created by release on 2020/9/15.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCInVertedView.h"

@implementation YCInVertedView

/**
 返回当前UIView内容layer类型
 */
+ (Class)layerClass{
    return [CAReplicatorLayer class];
}

@end
