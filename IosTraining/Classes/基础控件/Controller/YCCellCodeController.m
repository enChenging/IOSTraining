//
//  YCCellCodeController.m
//  UI
//
//  Created by release on 2020/8/6.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCCellCodeController.h"
#import "YCTg.h"
#import "MJExtension.h"
#import "YCTgCodeCell.h"

@interface YCCellCodeController ()

//所有的团购数据
@property(nonatomic,strong)NSArray *tgs;
@end

@implementation YCCellCodeController


- (NSArray *)tgs{
    if (!_tgs) {
        _tgs = [YCTg mj_objectArrayWithFilename:@"tgs.plist"];
    }
    return _tgs;
}

NSString *ID = @"tg";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 70;
    self.tableView.separatorColor = [UIColor clearColor];
    [self.tableView registerClass:[YCTgCodeCell class] forCellReuseIdentifier:ID];
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tgs.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YCTgCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //设置数据
    cell.tg = self.tgs[indexPath.row];
    return cell;
}

@end
