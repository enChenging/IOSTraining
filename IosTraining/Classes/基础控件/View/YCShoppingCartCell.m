//
//  YCShoppingCartCell.m
//  UI
//
//  Created by release on 2020/8/10.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCShoppingCartCell.h"
#import "YCWine.h"
#import "YCCircleButton.h"

@interface YCShoppingCartCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet YCCircleButton *minusButton;

@end
@implementation YCShoppingCartCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil]lastObject];
    }
    return self;
}
- (void)awakeFromNib{
    [super awakeFromNib];
   
}
- (IBAction)add {
    self.wine.count++;
    self.countLabel.text = [NSString stringWithFormat:@"%d",self.wine.count];
    self.minusButton.enabled = YES;
    self.minusButton.alpha = 1;
    if ([self.delegate respondsToSelector:@selector(wineCellDidClickAddButton:)]) {
        [self.delegate wineCellDidClickAddButton:self];
    }
}

- (IBAction)minus {
    self.wine.count--;
    self.countLabel.text = [NSString stringWithFormat:@"%d",self.wine.count];
    if (self.wine.count == 0) {
        self.minusButton.enabled = NO;
        self.minusButton.alpha = 0.5;
    }
    if ([self.delegate respondsToSelector:@selector(wineCellDidClickMinusButton:)]) {
        [self.delegate wineCellDidClickMinusButton:self];
    }
}

/**
 设置子控件的数据
 */
- (void)setWine:(YCWine *)wine{
    _wine = wine;
    self.iconImageView.image = [UIImage imageNamed:wine.image];
    self.titleLabel.text = wine.name;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",wine.money];
    self.countLabel.text = [NSString stringWithFormat:@"%d",self.wine.count];
    if (wine.count > 0) {
        self.minusButton.enabled = YES;
        self.minusButton.alpha = 1;
    }else{
        self.minusButton.enabled = NO;
        self.minusButton.alpha = 0.5;
    }
    
}

@end
