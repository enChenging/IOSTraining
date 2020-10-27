//
//  YCAPP.m
//  UI
//
//  Created by release on 2020/9/26.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCAPP.h"

@implementation YCAPP


+ (instancetype)appWithDict:(NSDictionary *)dict{
    YCAPP *appM = [[YCAPP alloc]init];
    
    //KVC
    [appM setValuesForKeysWithDictionary:dict];
    
    return appM;
}
@end
