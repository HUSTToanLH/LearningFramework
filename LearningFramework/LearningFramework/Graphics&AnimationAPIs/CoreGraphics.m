//
//  CoreGraphics.m
//  LearningFramework
//
//  Created by TaiND on 10/8/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import "CoreGraphics.h"
#import "CounterView.h"
#import "PushButtonView.h"
#import "GraphView.h"

@interface CoreGraphics ()
@property (strong, nonatomic) IBOutlet CounterView *counterView;
@property (strong, nonatomic) IBOutlet UILabel *counterLabel;
@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet GraphView *graphView;

@end

@implementation CoreGraphics{
    BOOL isShowGraphView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _counterView.counter = 1;
    _counterLabel.text = [NSString stringWithFormat:@"%d", _counterView.counter];
    isShowGraphView = false;
    _graphView.hidden = YES;
}

- (IBAction)pushButton:(PushButtonView*)sender {
    if (isShowGraphView) {
        [self tapOnContainerView:nil];
    }
    else{
        if(sender.isAddButton){
            if(_counterView.counter < 10){
                _counterView.counter++;
            }
        }
        else{
            if (_counterView.counter > 0) {
                _counterView.counter--;
            }
        }
        _counterLabel.text = [NSString stringWithFormat:@"%d", _counterView.counter];
    }
}
- (IBAction)tapOnContainerView:(UITapGestureRecognizer*)ges {
    if (ges != nil) {
        _counterView.hidden = NO;
        if (isShowGraphView) {
            [UIView transitionFromView:_graphView
                                toView:_counterView
                              duration:1.0
                               options:UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionShowHideTransitionViews
                            completion:nil];
        }
        else{
            [UIView transitionFromView:_counterView
                                toView:_graphView
                              duration:1.0
                               options:UIViewAnimationOptionTransitionFlipFromRight | UIViewAnimationOptionShowHideTransitionViews
                            completion:nil];
        }
        isShowGraphView = !isShowGraphView;
    }
}

@end
