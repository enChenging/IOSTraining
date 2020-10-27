//
//  YCContactVC.m
//  UI
//
//  Created by release on 2020/8/16.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCContactVC.h"
#import "YCContactItem.h"
#import "YCAddContactVC.h"
#import "YCEditContactVC.h"

@interface YCContactVC ()<YCAddContactVCDelegate>

@property(nonatomic,strong)NSMutableArray *contactArray;

@end

@implementation YCContactVC

- (NSMutableArray *)contactArray{
    if (!_contactArray) {
        _contactArray = [NSMutableArray array];
    }
    
    return _contactArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [NSString stringWithFormat:@"%@的通讯录",self.account];
//    self.title = [NSString stringWithFormat:@"%@的通讯录",self.account];
    [self initTitle];
    
    //第一种方式监听通知
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(contactChange) name:@"saveNotice" object:nil];
    
    //第二种方式监听通知，使用这种方法不需要移除通知
    [[NSNotificationCenter defaultCenter]addObserverForName:@"saveNotice" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [self.tableView reloadData];
    }];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
}
//第一种方式监听通知
//-(void)contactChange{
//    YCLog(@"%s",__func__);
//    [self.tableView reloadData];
//}
//
//第一种方式监听通知
//- (void)setContactItem:(YCContactItem *)contactItem{
//    _contactItem = contactItem;
//    YCLog(@"%@",contactItem.name);
//}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)initTitle{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加"
    style:UIBarButtonItemStyleDone target:self action:@selector(pressRight)];
    self.navigationItem.leftItemsSupplementBackButton = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注销"
    style:UIBarButtonItemStyleDone target:self action:@selector(pressLeft)];
}

-(void)pressRight{
    //跳转到下一页
    //根据一个标示，手动执行指定的Segue
    [self performSegueWithIdentifier:@"contact2addContact" sender:nil];
}

-(void)pressLeft{
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    alertControl.title = @"确定要退出登录吗？";
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction* cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertControl addAction:confirm];
    [alertControl addAction:cancle];
    [self presentViewController:alertControl animated:YES completion:nil];
    
}

/**
 自动执行segue时，也会来到prepareForSegue这个方法
 准备执行segue线时调用
 注意：
 在编辑页面不能够直接重写contactItem的set方法给里面的子控件赋值
 因为控制器的View是懒加载的，在set方法中，控制器的View还没有用到，它里面的子控件都还没有值
 所以不能够在它的set方法中进行给控制器的view的里面的k子控制器赋值
 我们一般等view加载完毕时，给控制器的View内部的子控件进行赋值
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.destinationViewController isKindOfClass:[YCAddContactVC class]]) {
        YCAddContactVC *addVC =  segue.destinationViewController;
        addVC.delegate = self;
    }else{
        YCEditContactVC *editVC = segue.destinationViewController;
        YCContactItem *contactItem = self.contactArray[[self.tableView indexPathForSelectedRow].row];
        editVC.contactItem = contactItem;
    }
}

/**
 实现协议方法
 */
- (void)addViewController:(YCContactVC *)addViewController contact:(YCContactItem *)contactItem{
    [self.contactArray addObject:contactItem];
    [self.tableView reloadData];
}

#pragma mark - 数据源方法
/**
 返回多少条
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contactArray.count;
}

/**
 每条ui
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"contactCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//    }
    
    YCContactItem *contactItem = self.contactArray[indexPath.row];
    cell.textLabel.text = contactItem.name;
    cell.detailTextLabel.text = contactItem.phoneNum;
    
    return cell;
}

@end
