//
//  YCDictionaryToModel.m
//  UI
//
//  Created by release on 2020/7/11.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCDictionaryToModel.h"
#import "YCPerson.h"

@interface YCDictionaryToModel ()

@property(nonatomic,strong)NSArray* ceshiArray;
@property(nonatomic,strong)NSArray* dataArr;

@end

@implementation YCDictionaryToModel

/**
 懒加载
 过程：
 1.重写成员变量的get方法
 2.在get方法中判断
    1.如果为空，加载数据
    2.如果不为空，就返回数据
 */
- (NSArray *)ceshiArray{
    if (_ceshiArray == nil) {
        NSString *dataPath = [[NSBundle mainBundle]pathForResource:@"homeUI.plist" ofType:nil];
        self.ceshiArray = [NSArray arrayWithContentsOfFile:dataPath];
    }
    return _ceshiArray;
}

- (NSArray *)dataArr{
    if (_dataArr == nil) {
        NSString *dataPath = [[NSBundle mainBundle]pathForResource:@"person" ofType:@"plist"];
        self.dataArr = [NSArray arrayWithContentsOfFile:dataPath];
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dict in self.dataArr) {
            YCPerson *person = [[YCPerson alloc]initWithDict:dict];
            [tempArray addObject:person];
        }
        self.dataArr = tempArray;
    }
     return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self readModel];
}

-(void)readModel{
    YCPerson *dict = self.dataArr[1];
    NSLog(@"%@",dict.name);
    NSLog(@"%@",dict.friends);
}

@end
