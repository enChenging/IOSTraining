//
//  YCFreeCellFrameController.m
//  UI
//
//  Created by release on 2020/8/6.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCFreeCellFrameController.h"
#import "YCStatus.h"
#import "YCStatus.h"
#import "MJExtension.h"
#import "YCTgFrameFreeCell.h"

@interface YCFreeCellFrameController ()
//初始化所有数据
@property(nonatomic,strong)NSArray *statuses;
@end

@implementation YCFreeCellFrameController{
    NSString * ID;
}

- (NSArray *)statuses{
 
    if (!_statuses) {
        _statuses = [YCStatus mj_objectArrayWithFilename:@"statuses.plist"];
    }
    
    return _statuses;
}

 
- (void)viewDidLoad {
    [super viewDidLoad];

    ID = @"status";
    [self.tableView registerClass:[YCTgFrameFreeCell class] forCellReuseIdentifier:ID];
}

#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    YCTgFrameFreeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.status = self.statuses[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YCStatus *status = self.statuses[indexPath.row];
    return status.cellHeight;
    
}



@end
