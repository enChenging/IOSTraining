//
//  YCDog.m
//  UI
//
//  Created by release on 2020/8/24.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCDog.h"

@implementation YCDog

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.name forKey:@"name"];
}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [self init];
    if (self) {
        self.name = [coder decodeObjectForKey:@"name"];
    }
    return self;
}
@end
