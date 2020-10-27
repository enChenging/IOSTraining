//
//  YCTabBar.m
//  UI
//
//  Created by release on 2020/9/16.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCTabBar.h"
#import "YCTabBarBtn.h"

@interface YCTabBar()
@property(nonatomic, weak)UIButton *preBtn;

@end
@implementation YCTabBar

-(void)setItemArray:(NSArray *)itemArray{
    _itemArray = itemArray;
    
    for (UITabBarItem *item in itemArray) {
        //添加按钮
        YCTabBarBtn *btn = [YCTabBarBtn buttonWithType:UIButtonTypeCustom];
        btn.tag = self.subviews.count;
        //设置按钮
        [btn setBackgroundImage:item.image forState:UIControlStateNormal];
        //设置选中状态下的按钮
        [btn setBackgroundImage:item.selectedImage forState:UIControlStateSelected];
        //添加按钮
        [self addSubview:btn];
        
        //坚听按钮点击
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        //默认让第一个按钮成为选中状态.
        if (self.subviews.count == 1) {
            [self btnClick:btn];
        }
        
    }
}


//当按钮点击时调用
- (void)btnClick:(UIButton *)btn{

    //1.取消上一个选中状态
    self.preBtn.selected = NO;
    //2.让当前点击按钮成为选中状态.
    btn.selected = YES;
    //3.把当前按钮赋值给上一个选中的按钮
    self.preBtn = btn;
    //通知代理,点击了哪个角标的按钮.
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectBtn:)]) {
        [self.delegate tabBar:self didSelectBtn:btn.tag];
    }
    

}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    //设置按钮尺寸
    int count = (int)self.subviews.count;
    CGFloat btnW = self.bounds.size.width / count;
    CGFloat btnH = self.bounds.size.height;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    //取出所有的按钮
    for (int i = 0; i < count; i++) {
        //取出每一个按钮
        UIButton *btn = self.subviews[i];
        //设置按钮的尺寸位置
        btnX = i * btnW;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
}

@end
