//
//  VCParseJson.m
//  UI
//
//  Created by release on 2019/11/16.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import "VCParseJson.h"
#import "NewsListTableViewCell.h"
#import "NewsModel.h"
#import <SDWebImage.h>
#import "MJExtension.h"

@interface VCParseJson ()

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *news;

@end

@implementation VCParseJson

- (NSMutableArray *)news{
    if (!_news) {
        _news = [NSMutableArray array];
    }
    return _news;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //替换
    [NewsModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
            @"des":@"description"
        };
    }];
    
    [self initView];
    [self parseJson];
    
}

-(void)parseJson{
    //获取文件路径
    NSString* path = [[NSBundle mainBundle]pathForResource:@"data" ofType:@"json"];
    //返回二进制文件的格式数据
    NSData* dataJson = [NSData dataWithContentsOfFile:path];
    //将json数据解析为字典格式
    /**
     NSJSONReadingMutableContainers = (1UL << 0),  可变字典和数组
     NSJSONReadingMutableLeaves = (1UL << 1),        内部所有的字符串都是可变的，ios7之后有问题 一般不用
     NSJSONReadingFragmentsAllowed = (1UL << 2),   既不是字典也不是数组
     */
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:dataJson options:NSJSONReadingMutableContainers error:nil];
    
    //字典转模型
    if ([dic isKindOfClass:[NSDictionary class]]) {
        //        NSNumber* code = [dic objectForKey:@"code"];//老式写法
        NSNumber* code = dic[@"code"];
        NSString* msg =dic[@"msg"];
        YCLog(@"code===%@   ,msg====%@",code,msg);
//        YCLog(@"json===%@",dic);
        
        //原始写法
        //        NSArray* newslist = dic[@"newslist"];
        //        for (int i =0 ; i<newslist.count; i++) {
        //            NSDictionary* dicNews = [newslist objectAtIndex:i];
        //            NSString* ctime = [dicNews objectForKey:@"ctime"];
        //            NSString* picUrl = [dicNews objectForKey:@"picUrl"];
        //            NSString* title = [dicNews objectForKey:@"title"];
        //            NSString* url = [dicNews objectForKey:@"url"];
        //
        //            NewsModel *model = [[NewsModel alloc]init];
        //            model.ctime = ctime;
        //            model.picUrl = picUrl;
        //            model.title = title;
        //            model.url = url;
        //            [self.news addObject:model];
        //        }
        
        //生产中的写法
        self.news = [NewsModel mj_objectArrayWithKeyValuesArray:dic[@"newslist"]];
    }
    
    //更新UI
    [self.tableView reloadData];
}

-(void)initView{
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = (id)self;
    _tableView.dataSource = (id)self;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 50, 0, 0);
    _tableView.scrollEnabled = YES;//石否可以有滚动效果
    _tableView.bounces = YES;//是否可以边缘弹动效果
    _tableView.alwaysBounceVertical = YES;
    _tableView.showsVerticalScrollIndicator = YES;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 80)];
    [self.view addSubview:_tableView];
    
}

#pragma mark data
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.news.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* indentify = @"cellr4rfrklfkre";
    NewsListTableViewCell* cell=[_tableView dequeueReusableCellWithIdentifier:indentify];
    
    if (!cell) {
        cell = [[NewsListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentify];
    }
    
    NewsModel* model =  self.news[indexPath.row];
    
    cell.mTitleLable.text = model.title;
    cell.mCtimeLable.text = model.ctime;
    [cell.mImageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl]
                       placeholderImage:[UIImage imageNamed:@"guide_1"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YCLog(@"点击条目%d",(int)indexPath.row);
    
}

/**
 JSON--->OC
 */
-(void)JSONWithOc{
    //NSString *strM = @"{\"error\":\"用户名不存在\"}";
    //NSString *strM = @"[\"error\",\"用户名不存在\"]";
    //NSString *strM = @"\"wendingding\"";
    //NSString *strM = @"false";
    //NSString *strM = @"true";
    NSString *strM = @"null";
    
    id obj = [NSJSONSerialization JSONObjectWithData:[strM dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:0];
    NSLog(@"%@---%@",[obj class],obj);
    
    /*
     JOSN   OC
     {}     @{}
     []     @[]
     ""     @""
     false  NSNumber 0
     true   NSNumber 1
     null      NSNull为空
     */
    
    //nil
    [NSNull null];   //该方法获得的是一个单例,表示为空,可以用在字典或者是数组中
    
}

/**
 OC--->json
 */
-(void)OCtojson{
    NSDictionary *dictM = @{
        @"name":@"dasheng11",
        @"age":@3
    };
    
    NSArray *arrayM = @[@"123",@"456"];
    
    //注意:并不是所有的OC对象都能转换为JSON
    /*
     - 最外层必须是 NSArray or NSDictionary
     - 所有的元素必须是 NSString, NSNumber, NSArray, NSDictionary, or NSNull
     - 字典中所有的key都必须是 NSStrings类型的
     - NSNumbers不能死无穷大
     */
    NSString *strM = @"WENIDNGDING";
    
    BOOL isValid = [NSJSONSerialization isValidJSONObject:strM];
    if (!isValid) {
        NSLog(@"%z",isValid);
        return;
    }
    
    //OC--->json
    /*
     第一个参数:要转换的OC对象
     第二个参数:选项NSJSONWritingPrettyPrinted 排版 美观
     */
    NSData *data = [NSJSONSerialization dataWithJSONObject:strM options:NSJSONWritingPrettyPrinted error:nil];
    
    NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
}



@end
