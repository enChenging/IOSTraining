//
//  YCCellStoryBoardController.m
//  UI
//
//  Created by release on 2020/8/6.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCCellStoryBoardController.h"
#import "YCTg.h"
#import "MJExtension.h"
#import "YCTgSbCell.h"

@interface YCCellStoryBoardController ()
//所有的团购数据
@property(nonatomic,strong)NSArray *tgs;
@end

@implementation YCCellStoryBoardController

- (NSArray *)tgs{
    if (!_tgs) {
        _tgs = [YCTg mj_objectArrayWithFilename:@"tgs.plist"];
    }
    return _tgs;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 70;
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tgs.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YCTgSbCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tg"];
    cell.tg = self.tgs[indexPath.row];
    return cell;
    
}



@end
