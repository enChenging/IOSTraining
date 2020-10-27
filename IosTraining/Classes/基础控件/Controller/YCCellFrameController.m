//
//  YCCellFrameController.m
//  UI
//
//  Created by release on 2020/8/6.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCCellFrameController.h"
#import "YCTgFrameCell.h"
#import "MJExtension.h"
#import "YCTg.h"

@interface YCCellFrameController ()

//所有的团购数据
@property(nonatomic,strong)NSArray *tgs;

@end

@implementation YCCellFrameController{
    NSString *ID;
}

- (NSArray *)tgs{
    if (!_tgs) {
        _tgs = [YCTg mj_objectArrayWithFilename:@"tgs.plist"];
    }
    return _tgs;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    ID = @"tg";
    self.tableView.rowHeight = 70;
    [self.tableView registerClass:[YCTgFrameCell class] forCellReuseIdentifier:ID];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tgs.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YCTgFrameCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //设置数据
    cell.tg = self.tgs[indexPath.row];
    return cell;
}

@end
