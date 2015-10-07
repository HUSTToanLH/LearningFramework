//
//  UICircleView.m
//  LearningFramework
//
//  Created by TaiND on 10/7/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import "UICircleView.h"

@implementation UICircleView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, rect);
    CGContextSetFillColor(ctx, CGColorGetComponents([[UIColor blueColor] CGColor]));
    CGContextFillPath(ctx);
}

@end
