//
//  YCSaveTool.m
//  UI
//
//  Created by release on 2020/9/19.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCSaveTool.h"

@implementation YCSaveTool

+ (id)objectForKey:(NSString *)defaultName{
    return [[NSUserDefaults standardUserDefaults]objectForKey:defaultName];
}

+ (void)setObject:(id)value forKey:(NSString *)defaultName{
    if (defaultName) {
        [[NSUserDefaults standardUserDefaults]setObject:value forKey:defaultName];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}
@end
