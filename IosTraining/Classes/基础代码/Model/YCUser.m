//
//  YCUser.m
//  UI
//
//  Created by release on 2020/8/24.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCUser.h"

@implementation YCUser

-(void)encodeWithCoder:(NSCoder *)coder{
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeInt:self.age forKey:@"age"];
    [coder encodeObject:self.dog forKey:@"dog"];
}

/**
 当解析一个文件时调用（告诉当前要解析文件中哪些属性）
 */
- (instancetype)initWithCoder:(NSCoder *)coder
{
    //当只有遵守了NSCoding协议时，才有[super initWithCoder]
    self = [super init];
    if (self) {
        self.name = [coder decodeObjectForKey:@"name"];
        self.age = [coder decodeIntForKey:@"age"];
        self.dog = [coder decodeObjectForKey:@"dog"];
    }
    return self;
}
@end
