//
//  ProvinceTextF.m
//  UI
//
//  Created by release on 2020/8/13.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "ProvinceTextF.h"
#import "ProvinceItem.h"

@interface ProvinceTextF ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong)NSMutableArray *provinceDataArray;
//记录当前选中的是哪一个省的角标
@property(nonatomic,assign)NSInteger curProIndex;

@property(nonatomic,weak)UIPickerView *pick;
@end

@implementation ProvinceTextF

- (NSMutableArray *)provinceDataArray{
    if (_provinceDataArray == nil) {
        _provinceDataArray = [NSMutableArray array];
        NSArray *tempArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"provinces.plist" ofType:nil]];
        for (NSDictionary *dict in tempArray) {
            ProvinceItem *item = [ProvinceItem provinceItemWithDict:dict];
            [_provinceDataArray addObject:item];
        }
    }
    return _provinceDataArray;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setUp];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

-(void)setUp{
    UIPickerView *pickV = [[UIPickerView alloc]init];
    pickV.delegate = self;
    pickV.dataSource = self;
    self.pick = pickV;
    self.inputView = pickV;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return self.provinceDataArray.count;
    }else{
        ProvinceItem *proItem =  self.provinceDataArray[self.curProIndex];
        return proItem.cities.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    //如果是第0列，就是省份，返回省份的名称
    if (component == 0) {
        ProvinceItem *proItem = self.provinceDataArray[row];
        return proItem.name;
    }else{
        ProvinceItem *proItem = self.provinceDataArray[self.curProIndex];
        //返回选中省份下每一个城市
        return  proItem.cities[row];
    }
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        self.curProIndex = row;
        //刷新列表
        [pickerView reloadAllComponents];
        //让第1列的第0行成为选中状态
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
    //把选中的省份，城市显示到文本框中
    //获取选中的省
    ProvinceItem *proItem = self.provinceDataArray[self.curProIndex];
    NSString *province = proItem.name;
    //获取第一列选中的行
    NSInteger seleRow = [pickerView selectedRowInComponent:1];
    //获取当前选中省下面d选中的行
    NSString *city = proItem.cities[seleRow];
    //显示数据
    self.text = [NSString stringWithFormat:@"%@ %@",province,city];
}

//开始编辑选中第一列的第一行
- (void)initWithText{
    [self pickerView:self.pick didSelectRow:0 inComponent:0];
}
@end
