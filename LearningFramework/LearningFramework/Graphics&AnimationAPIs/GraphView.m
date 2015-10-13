//
//  GraphView.m
//  LearningFramework
//
//  Created by TaiND on 10/9/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import "GraphView.h"



@implementation GraphView{
    NSArray *graphPoints;
}

- (void)drawRect:(CGRect)rect {
    graphPoints = @[@4, @2, @6, @4, @5, @8, @3];
//    //create the gradient
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    gradient.startPoint = CGPointMake(0.5, 0);
//    gradient.endPoint = CGPointMake(0.5,1);
//    gradient.frame = self.bounds;
//    gradient.colors = [NSArray arrayWithObjects:(id)[_startColor CGColor], (id)[_endColor CGColor], nil];
////    gradient.cornerRadius = 8.0f;
//    [self.layer insertSublayer:gradient atIndex:0];
    
    //clip corner
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect
                                               byRoundingCorners:UIRectCornerAllCorners
                                                     cornerRadii:CGSizeMake(8.0, 8.0)];
    [path addClip];
    
    //add gradient
    CGContextRef context = UIGraphicsGetCurrentContext();
    NSArray *colors = [NSArray arrayWithObjects:(id)_startColor.CGColor, (id)_endColor.CGColor, nil];
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGFloat colorLocations[] = {0.0, 1.0};
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colors, colorLocations);
    
    CGPoint startPoint = CGPointZero;
    CGPoint endPoint = CGPointMake(0, self.bounds.size.height);
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    //path
    CGFloat margin = 20.0;
    CGFloat (^columnXPoint)(int column) = ^CGFloat(int column){
        CGFloat spacer = (self.bounds.size.width - margin*2 - 4)/(CGFloat)(graphPoints.count - 1);
        CGFloat x = (CGFloat)column * spacer;
        x += margin + 2;
        return x;
    };
    
    CGFloat topBorder = 60;
    CGFloat bottomBorder = 50;
    CGFloat graphHeight = self.bounds.size.height - topBorder - bottomBorder;

    int maxValue = (int)[graphPoints valueForKeyPath:@"@max.intValue"];
    
    CGFloat (^columnYPoint)(int graphPoint) = ^CGFloat(int graphPoint){
        CGFloat y = (CGFloat)graphPoint/(CGFloat)maxValue * graphHeight;
        y = graphHeight + topBorder - y;
        return y;
    };
    
    UIBezierPath *graphPath = [[UIBezierPath alloc] init];
//    graphPath.lineWidth = 3.0f;
    [graphPath moveToPoint:CGPointMake(columnXPoint(0), columnYPoint((int)graphPoints[0]))];
    
    for (int i = 1; i < graphPoints.count; i++) {
        CGPoint nextPoint = CGPointMake(columnXPoint(i), columnYPoint((int)graphPoints[i]));
        [graphPath addLineToPoint:nextPoint];
    }
    
    [[UIColor whiteColor] setFill];
    [[UIColor whiteColor] setStroke];
    
//    [graphPath stroke];//stroke line
    
    //graph gradient
    CGContextSaveGState(context);
    
    UIBezierPath *clippingPath = (UIBezierPath*)[graphPath copy];
    [clippingPath addLineToPoint:CGPointMake(columnXPoint((int)graphPoints.count - 1), self.bounds.size.height)];
    [clippingPath addLineToPoint:CGPointMake(columnXPoint(0), self.bounds.size.height)];
    [clippingPath closePath];
    
    [clippingPath addClip];
    
//    [[UIColor greenColor] setFill];
//    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:self.bounds];
//    [rectPath fill];
    
    //change fill color
    CGFloat heighestYPoint = columnYPoint(maxValue);
    startPoint = CGPointMake(margin, heighestYPoint);
    endPoint = CGPointMake(margin, self.bounds.size.height);
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    CGContextRestoreGState(context);
    
    //change line with because when change fill color, line has fuzzy
    graphPath.lineWidth = 2.0;
    [graphPath stroke];
    
    //add circle point to graph
    for (int i = 0; i < graphPoints.count; i++) {
        CGPoint point = CGPointMake(columnXPoint(i), columnYPoint((int)graphPoints[i]));
        
        point.x -= 5.0/2;
        point.y -= 5.0/2;
        
        UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(point.x, point.y, 5.0, 5.0)];
        [circle fill];
    }
    
    //add horizontal line
    UIBezierPath *lineGraph = [UIBezierPath new];
    
    [lineGraph moveToPoint:CGPointMake(margin, topBorder)];
    [lineGraph addLineToPoint:CGPointMake(self.bounds.size.width - margin, topBorder)];
    
    [lineGraph moveToPoint:CGPointMake(margin, graphHeight/2 + topBorder)];
    [lineGraph addLineToPoint:CGPointMake(self.bounds.size.width - margin, graphHeight/2 + topBorder)];
    
    [lineGraph moveToPoint:CGPointMake(margin, graphHeight + topBorder)];
    [lineGraph addLineToPoint:CGPointMake(self.bounds.size.width - margin, graphHeight + topBorder)];
    
    lineGraph.lineWidth = 1.0;
    UIColor *color = [[UIColor alloc] initWithWhite:1.0 alpha:0.3];
    [color setStroke];
    [lineGraph stroke];
    
    [self addLabelWithMargin:margin andTopBorder:topBorder andBottomBorder:bottomBorder andGraphHeight:graphHeight];
    
}

-(void)addLabelWithMargin:(CGFloat)margin andTopBorder:(CGFloat)topBorder andBottomBorder:(CGFloat)bottomBorder andGraphHeight:(CGFloat)graphHeight{
    UILabel *waterDrunk = [[UILabel alloc] initWithFrame:CGRectMake(margin, topBorder/5, self.bounds.size.width - 2*margin, 20)];
    waterDrunk.text = @"Water Drunk";
    waterDrunk.textColor = [UIColor whiteColor];
    [waterDrunk setFont:[UIFont fontWithName:@"AvenirNextCondensed-Medium" size:18]];
    
    [self addSubview:waterDrunk];
    
    CGSize averageSize = [@"Average: " sizeWithFont:[UIFont fontWithName:@"AvenirNextCondensed-Medium" size:18]];
    
    UILabel *average = [[UILabel alloc] initWithFrame:CGRectMake(margin, waterDrunk.frame.origin.y + waterDrunk.frame.size.height, averageSize.width, 20)];
    average.text = @"Average: ";
    average.textColor = [UIColor whiteColor];
    [average setFont:[UIFont fontWithName:@"AvenirNextCondensed-Medium" size:18]];
    [self addSubview:average];
    
    UILabel *averageValue = [[UILabel alloc] initWithFrame:CGRectMake(average.frame.origin.x + average.frame.size.width, average.frame.origin.y, 100, average.frame.size.height)];
    
    CGFloat averageV = [[graphPoints valueForKeyPath:@"@sum.self"] intValue]/graphPoints.count;
    
    averageValue.text = [NSString stringWithFormat:@"%.2f", averageV];
    averageValue.textColor = [UIColor whiteColor];
    [averageValue setFont:[UIFont fontWithName:@"AvenirNextCondensed-Medium" size:18]];
    [self addSubview:averageValue];
    
    UILabel *maxLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, average.bounds.size.height, average.bounds.size.height)];
    maxLabel.center = CGPointMake(self.bounds.size.width - margin + maxLabel.bounds.size.width/2, topBorder);
    maxLabel.text = [NSString stringWithFormat:@"%d", [[graphPoints valueForKeyPath:@"@max.intValue"] intValue]];
    maxLabel.textColor = [UIColor whiteColor];
    [maxLabel setTextAlignment:NSTextAlignmentRight];
    [maxLabel setFont:[UIFont fontWithName:@"AvenirNextCondensed-Medium" size:18]];
    [self addSubview:maxLabel];
    
    UILabel *minLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, average.bounds.size.height, average.bounds.size.height)];
    minLabel.center = CGPointMake(self.bounds.size.width - margin + maxLabel.bounds.size.width/2, graphHeight + topBorder);
    minLabel.text = @"0";
    minLabel.textColor = [UIColor whiteColor];
    [minLabel setTextAlignment:NSTextAlignmentRight];
    [minLabel setFont:[UIFont fontWithName:@"AvenirNextCondensed-Medium" size:18]];
    [self addSubview:minLabel];
    
    //add 7 day
    CGFloat width = self.bounds.size.width - 2*margin;
    CGFloat centerY = graphHeight + topBorder + bottomBorder/2;
    CGSize size = CGSizeMake(average.bounds.size.height, average.bounds.size.height);
    for (int i = 1; i < 8; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        label.center = CGPointMake(margin + (i-1)*width/6, centerY);
        label.tag = i;
        label.text = @"0";
        label.textColor = [UIColor whiteColor];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setFont:[UIFont fontWithName:@"AvenirNextCondensed-Medium" size:18]];
        [self addSubview:label];
    }
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit componentOptions = NSCalendarUnitWeekday;
    NSDateComponents *components = [calendar components:componentOptions fromDate:[NSDate date]];
    NSInteger weekday = components.weekday;
    NSArray *days = @[@"S", @"S", @"M", @"T", @"W", @"T", @"F"];
    
    for (int i = 1; i < days.count + 1; i++) {
        UILabel *labelView = (UILabel*)[self viewWithTag:i];
        if (labelView) {
            if (weekday == 7) {
                weekday = 0;
            }
            labelView.text = days[weekday--];
            if (weekday < 0) {
                weekday = days.count - 1;
            }
        }
    }
}

@end
