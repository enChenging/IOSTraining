//
//  YCFlagView.m
//  UI
//
//  Created by release on 2020/8/13.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "FlagView.h"
#import "FlagItem.h"

@interface FlagView ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@end

@implementation FlagView

+ (instancetype)flagView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

- (void)setFlagItem:(FlagItem *)flagItem{
    self.name.text = flagItem.name;
    self.iconImage.image = flagItem.icon;
    
}

@end
