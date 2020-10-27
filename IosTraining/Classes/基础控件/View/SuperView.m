//
//  SuperView.m
//  UI
//
//  Created by release on 2019/11/12.
//  Copyright © 2019 Mr. release. All rights reserved.
//

#import "SuperView.h"

@implementation SuperView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)createView{
 
    _view01 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    _view01.backgroundColor = [UIColor orangeColor];
    _view02 = [[UIView alloc]initWithFrame:CGRectMake(self.bounds.size.width - 40, 0, 40, 40)];
    _view02.backgroundColor = [UIColor orangeColor];
    _view03 = [[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height - 40, 40, 40)];
    _view03.backgroundColor = [UIColor orangeColor];
    _view04 = [[UIView alloc]initWithFrame:CGRectMake(self.bounds.size.width - 40, self.bounds.size.height - 40, 40, 40)];
    _view04.backgroundColor = [UIColor orangeColor];
   
    [self addSubview:_view01];
    [self addSubview:_view02];
    [self addSubview:_view03];
    [self addSubview:_view04];

}

//当需要重新布局时调整次函数
//手动调整子函数的位置
- (void)layoutSubviews{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    _view01.frame = CGRectMake(0, 0, 40, 40);
    _view02.frame = CGRectMake(self.bounds.size.width - 40, 0, 40, 40);
    _view03.frame = CGRectMake(0, self.bounds.size.height - 40, 40, 40);
    _view04.frame = CGRectMake(self.bounds.size.width - 40, self.bounds.size.height - 40, 40, 40);
    [UIView commitAnimations];
}

@end
