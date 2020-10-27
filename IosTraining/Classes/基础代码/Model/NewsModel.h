//
//  NewsModel.h
//  UI
//
//  Created by release on 2019/11/16.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsModel : NSObject
/**
 "ctime" : "2019-11-15 17:08",
    "title" : "任正非:今年公司利润太多了 建议终端公司少赚些",
    "description" : "网易IT",
    "url" : "https:\/\/tech.163.com\/19\/1115\/17\/EU1PFRJM00097U7T.html",
    "picUrl" : "http:\/\/cms-bucket
 */
@property(nonatomic,copy)NSString* ctime;
@property(nonatomic,copy)NSString* title;
@property(nonatomic,copy)NSString* des;
@property(nonatomic,copy)NSString* url;
@property(nonatomic,copy)NSString* picUrl;

@end

NS_ASSUME_NONNULL_END
