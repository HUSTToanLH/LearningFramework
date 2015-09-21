//
//  AutoLayout.m
//  LearningFramework
//
//  Created by TaiND on 9/21/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import "AutoLayout.h"

@interface AutoLayout ()
@property (strong, nonatomic) IBOutlet UIView *viewTop;
@property (strong, nonatomic) IBOutlet UIView *viewBottom;

@end

@implementation AutoLayout

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"height view 1: %f", _viewTop.bounds.size.height);
//    NSLog(@"height view 2: %f", _viewBottom.bounds.size.height);
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(orientationChanged:)    name:UIDeviceOrientationDidChangeNotification  object:nil];
}

- (void)orientationChanged:(NSNotification *)notification{
    NSLog(@"height view 1: %f", _viewTop.bounds.size.height);
    NSLog(@"height view 2: %f", _viewBottom.bounds.size.height);
}

@end
