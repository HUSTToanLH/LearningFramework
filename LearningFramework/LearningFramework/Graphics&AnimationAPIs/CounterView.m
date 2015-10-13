//
//  CounterView.m
//  LearningFramework
//
//  Created by TaiND on 10/8/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import "CounterView.h"

const CGFloat numberOfGlasses = 10.0;

@implementation CounterView

- (void)drawRect:(CGRect)rect {
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    CGFloat radius = MAX(self.bounds.size.width, self.bounds.size.height);
    CGFloat arcWidth = 76;
    
    CGFloat startAngle = 3*M_PI/4;
    CGFloat endAngle = M_PI/4;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                       radius:radius/2 - arcWidth/2
                                                   startAngle:startAngle
                                                     endAngle:endAngle
                                                    clockwise:true];
    path.lineWidth = arcWidth;
    [_counterColor setStroke];
    [path stroke];
    
    //draw outline
    CGFloat angleDifference = 2*M_PI - startAngle + endAngle;
    CGFloat arcLengthPerGlass = angleDifference/numberOfGlasses;
    CGFloat outlineEndAngle = arcLengthPerGlass * _counter + startAngle;
    
    UIBezierPath *outlinePath = [UIBezierPath bezierPathWithArcCenter:center
                                                              radius:self.bounds.size.width/2 - 2.5
                                                          startAngle:startAngle
                                                            endAngle:outlineEndAngle
                                                           clockwise:true];
    
    [outlinePath addArcWithCenter:center radius:self.bounds.size.width/2 - arcWidth + 2.5
                       startAngle:outlineEndAngle
                         endAngle:startAngle
                        clockwise:false];
    
    [outlinePath closePath];
    [_outlineColor setStroke];
    outlinePath.lineWidth = 5.0;
    [outlinePath stroke];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    
    [_outlineColor setFill];
    
    CGFloat markerWidth = 5.0;
    CGFloat markerSize = 10.0;
    
    UIBezierPath *markerPath = [UIBezierPath bezierPathWithRect:CGRectMake(-markerWidth/2, 0, markerWidth, markerSize)];
    
    CGContextTranslateCTM(context, rect.size.width/2, rect.size.height/2);
    
    for (int i = 1; i < numberOfGlasses; i++) {
        CGContextSaveGState(context);
        
        CGFloat angle = arcLengthPerGlass *(CGFloat)i + startAngle - M_PI_2;
        CGContextRotateCTM(context, angle);
        
        CGContextTranslateCTM(context, 0, rect.size.height/2 - markerSize);
        [markerPath fill];
        
        CGContextRestoreGState(context);
    }
    
    CGContextRestoreGState(context);
    
}

-(void)setCounter:(int)counter{
    _counter = counter;
    if(_counter <= numberOfGlasses){
        [self setNeedsDisplayInRect:self.bounds];
    }
}

@end
