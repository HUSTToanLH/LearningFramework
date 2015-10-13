//
//  PushButtonView.m
//  LearningFramework
//
//  Created by TaiND on 10/8/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import "PushButtonView.h"

@implementation PushButtonView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    UIBezierPath *path  = [UIBezierPath bezierPathWithOvalInRect:rect];
    if (_fillColor == nil) {
        _fillColor = [UIColor greenColor];
    }
    [_fillColor setFill];
    [path fill];
    
    CGFloat plusHeight = 3.0;
    CGFloat plusWidth = MIN(self.bounds.size.width, self.bounds.size.height) * 0.6;
    
    UIBezierPath *plusPath = [UIBezierPath new];
    plusPath.lineWidth = plusHeight;
    
    [plusPath moveToPoint:CGPointMake(self.bounds.size.width/2 - plusWidth/2 + 0.5, self.bounds.size.height/2 + 0.5)];
    [plusPath addLineToPoint:CGPointMake(self.bounds.size.width/2 + plusWidth/2 + 0.5, self.bounds.size.height/2 + 0.5)];
    
    if (_isAddButton) {
        [plusPath moveToPoint:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2 - plusWidth/2 + 0.5)];
        
        [plusPath addLineToPoint:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2 + plusWidth/2 + 0.5)];
    }
    
    [[UIColor whiteColor] setStroke];
    [plusPath stroke];
}

@end
