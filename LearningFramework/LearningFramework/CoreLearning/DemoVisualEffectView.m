//
//  DemoVisualEffectView.m
//  LearningFramework
//
//  Created by TaiND on 9/30/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import "DemoVisualEffectView.h"
#import "AutoLayout.h"
#import "MainScreen.h"

@interface DemoVisualEffectView ()

@end

@implementation DemoVisualEffectView{
    ADTransitionController *vc;
    UIViewController *main;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor grayColor];
    [self addViewController];
}

-(void)addViewController{
    main = [UIViewController new];
    main.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height/2);
    main.view.backgroundColor = [UIColor yellowColor];
    main.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    
    [main.view addGestureRecognizer:tap];
    
    vc = [[ADTransitionController alloc] initWithMainViewController:main];
    [vc setNavigationBarHidden:YES];
    vc.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height/2);
    
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
}

-(void)onTap:(UITapGestureRecognizer*)ges{
    if (ges.state == UIGestureRecognizerStateEnded) {
        AutoLayout *autoView = [AutoLayout new];
        autoView.view.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapBack:)];
        
        [autoView.view addGestureRecognizer:tap];
        ADTransition * transition = [[ADCubeTransition alloc] initWithDuration:0.25f orientation:ADTransitionRightToLeft sourceRect:self.view.frame];
        [vc changeViewController:autoView withTransition:transition];
    }
}

-(void)onTapBack:(UITapGestureRecognizer*)ges{
    if (ges.state == UIGestureRecognizerStateEnded) {
        ADTransition * transition = [[ADCubeTransition alloc] initWithDuration:0.25f orientation:ADTransitionRightToLeft sourceRect:self.view.frame];
        [vc changeViewController:main withTransition:transition];
    }
}

-(void)addButton{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    btn.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    [btn setTitle:@"Open other view" forState:UIControlStateNormal];
    
    [btn.titleLabel setFont:[UIFont fontWithName:@"Arial" size:13]];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(onClickButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)onClickButton{
    AutoLayout *autoView = [AutoLayout new];
    ADTransition * transition = [[ADCubeTransition alloc] initWithDuration:0.25f orientation:ADTransitionRightToLeft sourceRect:self.view.frame];
    [[AppDelegate getMainTransition] pushViewController:autoView withTransition:transition];
}

@end
