//
//  YCLockView.m
//  UI
//
//  Created by release on 2020/9/2.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCLockView.h"

@interface YCLockView()

//存放的都是当前选中的按钮
@property(nonatomic,strong)NSMutableArray *selectBtnArray;
//当前手指所在的点
@property(nonatomic,assign)CGPoint curP;

@end

@implementation YCLockView

- (NSMutableArray *)selectBtnArray{
    if (!_selectBtnArray) {
        _selectBtnArray = [NSMutableArray array];
    }
    return _selectBtnArray;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setUp];
}

-(void)setUp{
    
    for (int i = 0; i<9; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.userInteractionEnabled = NO;
        btn.tag = i;
        [btn setImage:[UIImage imageNamed:@"button_lock_n"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"button_lock_p"] forState:UIControlStateSelected];
        [self addSubview:btn];
        
    }
}

-(void)handleBtnSelect:(NSSet *)touches withIsTouch:(BOOL)isTouch{
    //1.获取当前位置的选中状态
    UITouch *touch = [touches anyObject];
    CGPoint curP = [touch locationInView:self];
    if (isTouch) {
        self.curP = curP;
        //重绘
        [self setNeedsDisplay];
    }
    //2.判断curP在不在按钮上
    //取出所有的按钮进行判断
    for (UIButton *btn in self.subviews) {
        if (CGRectContainsPoint(btn.frame, curP) && btn.selected == NO) {
            //让当前按钮成为选中状态
            btn.selected = YES;
            //保存当前选中的按钮
            [self.selectBtnArray addObject:btn];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self handleBtnSelect:touches withIsTouch:NO];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self handleBtnSelect:touches withIsTouch:YES];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.selectBtnArray.count) {
        //1.取消所有选中的按钮
        NSMutableString *str = [NSMutableString string];
        for (UIButton *btn in self.selectBtnArray) {
            [str appendFormat:@"%ld",btn.tag];
            btn.selected = NO;
        }
        //2.清空路径
        [self.selectBtnArray removeAllObjects];
        [self setNeedsDisplay];
        //3.查看当前按钮的顺序
        NSLog(@"%@",str);
    }
}

- (void)drawRect:(CGRect)rect{
    if (self.selectBtnArray.count) {
        //1.创建路径
        UIBezierPath *path = [UIBezierPath bezierPath];
        //2.取出所有保存的按钮
        for (int i = 0; i < self.selectBtnArray.count; i++) {
            //取出没个按钮
            UIButton *btn = self.selectBtnArray[i];
            //判断当前按钮是不是第一个按钮
            if (i == 0) {
                //如果是，设置成路径的起点
                [path moveToPoint:btn.center];
            }else{
                //添加一根线到按钮的中心
                [path addLineToPoint:btn.center];
            }
        }
        
        //添加一根线到当前手指所在地
        [path addLineToPoint:self.curP];
        
        //设置路径的状态
        [path setLineWidth:10];
        [[UIColor redColor]set];
        [path setLineJoinStyle:kCGLineJoinRound];
        //3.绘制路径
        [path stroke];
    }
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat btnWH = 74;
    CGFloat curC = 0;
    CGFloat curR = 0;
    
    //总共多少列
    int column = 3;
    CGFloat margin = (self.bounds.size.width - (btnWH * column))/(column +1);
    for (int i = 0; i<self.subviews.count; i++) {
        //当前所在的列
        curC = i % column;
        //当前所在的行
        curR = i / column;
        
        x = margin + (btnWH + margin) * curC;
        y = margin + (btnWH + margin) * curR;
        //取出米一个按钮
        UIButton *btn = self.subviews[i];
        btn.frame = CGRectMake(x, y, btnWH, btnWH);
        
    }
}
@end
