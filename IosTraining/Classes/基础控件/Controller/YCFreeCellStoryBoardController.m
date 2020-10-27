//
//  YCFreeCellStoryBoardController.m
//  UI
//
//  Created by release on 2020/8/7.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCFreeCellStoryBoardController.h"
#import "YCStatus.h"
#import "MJExtension.h"
#import "YCFreeCell.h"

@interface YCFreeCellStoryBoardController ()

//初始化所有数据
@property(nonatomic,strong)NSArray *statuses;
@property(nonatomic,copy)NSString *ID;

@end

@implementation YCFreeCellStoryBoardController

- (NSArray *)statuses{
 
    if (!_statuses) {
        _statuses = [YCStatus mj_objectArrayWithFilename:@"statuses.plist"];
    }
    
    return _statuses;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self-sizing(ios8以后)
    //告诉tableView所有cell的真实高度是自动计算的（根据设置的约束）
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    //设置估算高度(减少tableView:heightForRowAtIndexPath:的嗲用次数)
    self.tableView.estimatedRowHeight = 200;
    self.ID = @"freeCell";
}

#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    YCFreeCell *cell = [tableView dequeueReusableCellWithIdentifier:self.ID];
    cell.status = self.statuses[indexPath.row];
    return cell;

}

//self-sizing(ios8以前，自己计算高度)
//YCFreeCell *cell;
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    //创建一个临时的cell(目的：传递indexPath对应这行的模型，布局内部所有的子控件，得到cell的高度)
//    if (cell == nil) {
//        cell = [tableView dequeueReusableCellWithIdentifier:self.ID];
//    }
//    //传递数据模型数据
//    cell.status = self.statuses[indexPath.row];
//    return cell.cellHeight;
//}

@end
