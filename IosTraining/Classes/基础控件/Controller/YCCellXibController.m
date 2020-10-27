//
//  YCCellXibController.m
//  UI
//
//  Created by release on 2020/8/6.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCCellXibController.h"
#import "YCTg.h"
#import "MJExtension.h"
#import "YCTgXibCell.h"
#import "YCTgXib2Cell.h"

@interface YCCellXibController (){
    NSString *ID;
    NSString *ID2;
}
//所有的团购数据
@property(nonatomic,strong)NSArray *tgs;

@end

@implementation YCCellXibController

- (NSArray *)tgs{
    if (!_tgs) {
        _tgs = [YCTg mj_objectArrayWithFilename:@"tgs.plist"];
    }
    return _tgs;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    ID =  @"xibtg";
    ID2 = @"xibtg2";
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YCTgXibCell class]) bundle:nil] forCellReuseIdentifier:ID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YCTgXib2Cell class]) bundle:nil] forCellReuseIdentifier:ID2];
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tgs.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     if (indexPath.row%2 == 0) {
         return 70;
     }else{
         return 110;
     }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row%2 == 0) {
        YCTgXibCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        cell.tg = self.tgs[indexPath.row];
        return cell;
    }else{
        return [tableView dequeueReusableCellWithIdentifier:ID2];
    }
    
}


@end
