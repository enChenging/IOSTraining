//
//  YCFlagTextF.m
//  UI
//
//  Created by release on 2020/8/13.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "FlagTextF.h"
#import "FlagItem.h"
#import "FlagView.h"

@interface FlagTextF ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,weak)UIPickerView *pickView;


@end
@implementation FlagTextF

- (NSArray *)dataArray{
    if (_dataArray == nil) {
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"flags.plist" ofType:nil]];
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            FlagItem *item = [FlagItem itemWithDict:dict];
            [tempArray addObject:item];
        }
        _dataArray = tempArray;
    }
    return _dataArray;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setUP];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUP];
    }
    return self;
}


-(void)setUP{
    UIPickerView *pickView = [[UIPickerView alloc]init];
     self.pickView = pickView;
    pickView.delegate = self;
    pickView.dataSource = self;
    //让弹出的键盘是一个UIPickerView
    self.inputView = pickView;
}

//列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

//行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataArray.count;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    FlagView *flagView = [FlagView flagView];
    flagView.flagItem = self.dataArray[row];
    return flagView;
}

//每一行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 100;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    FlagItem *flagItem = self.dataArray[row];
    self.text = flagItem.name;
}
//开始编辑选中第一列的第一行
- (void)initWithText{
    [self pickerView:self.pickView didSelectRow:0 inComponent:0];
}
@end
