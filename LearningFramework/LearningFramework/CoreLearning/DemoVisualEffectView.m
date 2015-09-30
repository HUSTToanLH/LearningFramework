//
//  DemoVisualEffectView.m
//  LearningFramework
//
//  Created by TaiND on 9/30/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import "DemoVisualEffectView.h"

@interface DemoVisualEffectView ()

@end

@implementation DemoVisualEffectView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Blur effect
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [blurEffectView setFrame:self.view.bounds];
    [self.view addSubview:blurEffectView];
    
    // Vibrancy effect
    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
    UIVisualEffectView *vibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
    [vibrancyEffectView setFrame:self.view.bounds];
    
    // Label for vibrant text
    UILabel *vibrantLabel = [[UILabel alloc] init];
    [vibrantLabel setText:@"Vibrant"];
    [vibrantLabel setFont:[UIFont systemFontOfSize:72.0f]];
    [vibrantLabel sizeToFit];
    [vibrantLabel setCenter: self.view.center];
    
    // Add label to the vibrancy view
    [[vibrancyEffectView contentView] addSubview:vibrantLabel];
    
    // Add the vibrancy view to the blur view
    [[blurEffectView contentView] addSubview:vibrancyEffectView];
}

@end
