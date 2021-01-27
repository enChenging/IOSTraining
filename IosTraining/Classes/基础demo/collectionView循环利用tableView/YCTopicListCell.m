//
//  YCTopicListCell.m
//  IosTraining
//
//  Created by release on 2020/11/27.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCTopicListCell.h"

@interface YCTopicListCell() <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation YCTopicListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setModule:(NSString *)module{
    _module = module;
    
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@ -- %zd",self.module,indexPath.row];
//    YCLog(@"%@ -- %zd",self.module,indexPath.row)
    return cell;
}

@end
