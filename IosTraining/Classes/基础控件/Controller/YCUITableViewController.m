//
//  YCUITableViewController.m
//  UI
//
//  Created by release on 2020/8/3.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCUITableViewController.h"
#import "YCCarGroup.h"
#import "YCCar.h"

@interface YCUITableViewController ()

@property(nonatomic,strong)NSArray *carGroups;

@end

@implementation YCUITableViewController

- (NSArray *)carGroup{
    if (!_carGroups) {
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"cars.plist" ofType:nil]];
        
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *carGroupDict in dictArray) {
            YCCarGroup *carGroup = [YCCarGroup carGroupWithDict:carGroupDict];
            [temp addObject:carGroup];
        }
        _carGroups = temp;
    }
    
    return _carGroups;
}
- (void)viewDidLoad {
    [super viewDidLoad];    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionIndexColor = [UIColor redColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor orangeColor];
    
}

#pragma mark - 数据源方法

/**
 返回多少组
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
 
    return self.carGroup.count;
}

/**
 返回多少条
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    YCCarGroup *group =  self.carGroup[section];
    return group.cars.count;
}

/**
 每条ui
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"car";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    YCCarGroup *group = self.carGroup[indexPath.section];
    YCCar *car = group.cars[indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:car.icon];
    cell.textLabel.text = car.name;
    
    return cell;
}

/**
 每组的title
 */
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    YCCarGroup *group = self.carGroup[section];
    return group.title;
}

//返回索引文字
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
//    NSMutableArray *temp = [NSMutableArray array];
//    for (YCCarGroup *group in self.carGroups) {
//        [temp addObject:group];
//    }
//    return temp;
    //抽取self.carGroup数组中每一个元素（YCCarGroup）的title属性值，放在新的数组中返回
    return [self.carGroup valueForKeyPath:@"title"];
}


@end
