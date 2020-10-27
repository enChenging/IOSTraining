//
//  DateTextF.m
//  UI
//
//  Created by release on 2020/8/13.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "DateTextF.h"

@interface DateTextF ()

@property(nonatomic,weak)UIDatePicker *datePick;

@end
@implementation DateTextF

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
    UIDatePicker *pick = [[UIDatePicker alloc]init];
    //设置地区
    pick.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    //设置日期格式
    pick.datePickerMode = UIDatePickerModeDate;
    //监听日期改变
    [pick addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    self.datePick = pick;
    //设置键盘为datePick
    self.inputView = pick;
}

-(void)dateChange:(UIDatePicker *)datePick{
    //将日期转换成字符串
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateString = [fmt stringFromDate:datePick.date];
    self.text = dateString;
}

//开始编辑选中第一列的第一行
- (void)initWithText{
    [self dateChange:self.datePick];
}
@end
