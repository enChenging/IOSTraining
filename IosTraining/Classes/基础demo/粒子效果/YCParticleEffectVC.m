//
//  YCParticleEffectVC.m
//  UI
//
//  Created by release on 2020/9/15.
//  Copyright © 2020 Mr. release. All rights reserved.
//

#import "YCParticleEffectVC.h"
#import "YCParticleEffectView.h"

@interface YCParticleEffectVC ()
@property (strong, nonatomic) IBOutlet YCParticleEffectView *vcView;

@end

@implementation YCParticleEffectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)start:(id)sender {
    [self.vcView start];
}
- (IBAction)redraw:(id)sender {
    [self.vcView redraw];
}



@end
