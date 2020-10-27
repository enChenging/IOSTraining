//
//  YCParseXmlVC.m
//  IosTraining
//
//  Created by release on 2020/10/11.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCParseXmlVC.h"
#import "NewsModel.h"
#import "MJExtension.h"
#import "GDataXMLNode.h"

@interface YCParseXmlVC ()<NSXMLParserDelegate>

@property(nonatomic,strong)NSMutableArray *news;

@end

@implementation YCParseXmlVC

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
}

/**
 NSXMLParser解析XML  (一行行解析)
 */
-(void)NSXmlParser{
    //模拟获取数据源
    NSData* data = [NSData data];
    //解析数据
    //1. 创建XML解析器:SAX
    NSXMLParser *parser = [[NSXMLParser alloc]initWithData:data];
    
    //2. 设置代理
    parser.delegate = self;
    
    //3. 开始解析,阻塞
    [parser parse];
}

#pragma mark -------------------------------satrt-------------------------------------
#pragma mark NSXMLParserDelegate
//1.开始解析XML文档的时候
-(void)parserDidStartDocument:(NSXMLParser *)parser{
      NSLog(@"%s",__func__);
}

//2.开始解析某个元素
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    NSLog(@"开始解析%@---%@",elementName,attributeDict);
    //过滤根元素
    if ([elementName isEqualToString:@"videos"]) {
        return;
    }
    
    //字典转模型
    [self.news addObject:[NewsModel mj_objectWithKeyValues:attributeDict]];
}

//3.某个元素解析完毕
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSLog(@"结束解析%@",elementName);
}

//4.结束解析
-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"%s",__func__);
}

#pragma mark -----------------------------end---------------------------------------


#pragma mark -------------------------------satrt-------------------------------------
/**
 GDataXML解析XML
 */
-(void)GDataXml{
    //模拟获取数据源
    NSData* data = [NSData data];
    //解析数据
    //1. 加载XML文档
    GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithData:data options:kNilOptions error:nil];
    
    //2. 拿到根元素,得到根元素内部所有名称为video的子孙元素,
    NSArray *eles =  [doc.rootElement elementsForName:@"video"];
    
    //3. 遍历操作
    for (GDataXMLElement *ele in eles) {
        //元素内部所有的属性--->模型-->添加到self.videos
        NewsModel *model = [[NewsModel alloc]init];
        
        model.ctime = [ele attributeForName:@"ctime"].stringValue;
        model.title = [ele attributeForName:@"ctime"].stringValue;
        model.des = [ele attributeForName:@"description"].stringValue;
        model.url = [ele attributeForName:@"url"].stringValue;
        model.picUrl = [ele attributeForName:@"picUrl"].stringValue;
        
        [self.news addObject:model];
    }
    
}

#pragma mark -----------------------------end---------------------------------------

@end
