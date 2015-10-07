//
//  TestDrawContext.m
//  LearningFramework
//
//  Created by TaiND on 10/2/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#define HIGHLIGHT_Y_CONTROL_POINT   25

#import "TestDrawContext.h"

@interface TestDrawContext ()
@property(nonatomic, assign) CGFloat verticalVelocity;
@property(nonatomic, assign) CGRect rect;
@property(nonatomic, assign) CGFloat touchXLocationInCell;

@end

@implementation TestDrawContext{
    UIView *demoview;
    UIImageView *drawpad;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor grayColor];
//    [self addView];
    [self drawPath];
}

-(void)drawPath{
      CGRect r = self.myImageView.bounds;
//    UIGraphicsBeginImageContextWithOptions(r.size, NO, 0);
//    UIBezierPath* p = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(r,10,10) cornerRadius:10];
//    [p stroke];
//    CGPoint c = CGPointMake(r.size.width/2.0, r.size.height/2.0);
//    p = [UIBezierPath bezierPath];
//    [p moveToPoint:CGPointMake(c.x-30, c.y)];
//    [p addLineToPoint:CGPointMake(c.x + 30, c.y)];
////    [p addLineToPoint:CGPointMake(c.x, c.y)];
//    [p addLineToPoint:CGPointMake(c.x, c.y + 60)];
//    
////    [p addLineToPoint:CGPointMake(c.x, c.y-30)];
////    [p addLineToPoint:CGPointMake(c.x+30, c.y)];
////    [p addLineToPoint:CGPointMake(c.x, c.y+30)];
//    [p closePath];
//    [p fill];
//    self.myImageView.image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    
    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(r.size.width/2-70, r.size.height/2 - 70)
                                                        radius:30
                                                    startAngle:(22.0f/7.0f)
                                                      endAngle:0
                                                     clockwise:YES];
    
    UIBezierPath *path2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(r.size.width/2+70, r.size.height/2 - 70)
                                                         radius:30
                                                     startAngle:(22.0f/7.0f)
                                                       endAngle:0
                                                      clockwise:YES];
    
    UIBezierPath *path3 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(r.size.width/2, r.size.height/2)
                                                         radius:150
                                                     startAngle:0
                                                       endAngle:6.5
                                                      clockwise:YES];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(r.size.width/2, r.size.height/2 + 70)
                                                        radius:45
                                                    startAngle:0
                                                      endAngle:(22.0f/7.0f)
                                                     clockwise:YES];
    UIGraphicsBeginImageContext(self.view.frame.size);
    path1.lineCapStyle = kCGLineCapRound;
    path1.lineWidth = 10.0f;
    [path1 stroke];
    
    path2.lineCapStyle = kCGLineCapRound;
    path2.lineWidth = 10.0f;
    [path2 stroke];
    
    path3.lineCapStyle = kCGLineCapRound;
    path3.lineWidth = 10.0f;
    [path3 stroke];
    
    path.lineCapStyle = kCGLineCapRound;
    path.lineWidth = 10.0f;
    [[UIColor blackColor] setStroke];
    [path stroke];
    self.myImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

-(void)addView{
    demoview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 40, self.view.bounds.size.height/3)];
    demoview.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    demoview.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:demoview];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
    demoview.userInteractionEnabled = YES;
    [demoview addGestureRecognizer:tap];
}

- (void)tapHandle:(UITapGestureRecognizer*)gesture{
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    _verticalVelocity = 0.0;
    _rect = demoview.frame;
    _touchXLocationInCell = [gesture locationInView:demoview].x;
        
    CGFloat x = _rect.origin.x;
    CGFloat y = _rect.origin.y;
    CGFloat w = _rect.size.width;
    CGFloat h = _rect.size.height;
    
    // Avoid drawing the path behond the next cell
    CGFloat controlYOffset = _verticalVelocity*2>(h/2)?(h/2):_verticalVelocity*2;
    
    // Draw background color
    CGContextSetFillColorWithColor(ctx, [[UIColor redColor] CGColor]);
    CGContextFillRect(ctx, _rect);
    
    // Bezier control points
    CGFloat controlPointX1, controlPointX2, controlPointX3, controlPointX4, controlPointY1, controlPointY2;
//    switch (_flabbyHighlightState) {
//        case BRFlabbyHighlightStateCellAboveTouched:
//            controlPointX1 = _touchXLocationInCell + x;
//            controlPointX2 = _touchXLocationInCell + x;
//            controlPointX3 = x + (w/2 + x) + (w - (w/2 + x))/2;
//            controlPointX4 = (x + (w/2 + x))/2;
//            controlPointY1 = HIGHLIGHT_Y_CONTROL_POINT;
//            controlPointY2 = y+h+controlYOffset;
//            CGContextSetFillColorWithColor(ctx, [[UIColor redColor] CGColor]);
//            CGContextFillRect(ctx, CGRectMake(x, y, w, h/2));
//            break;
//        case BRFlabbyHighlightStateCellBelowTouched:
//            controlPointX1 = (x + (w/2 + x))/2;
//            controlPointX2 = x + (w/2 + x) + (w - (w/2 + x))/2;
//            controlPointX3 = _touchXLocationInCell + x;
//            controlPointX4 = _touchXLocationInCell + x;
//            controlPointY1 = controlYOffset;
//            controlPointY2 = y+h-HIGHLIGHT_Y_CONTROL_POINT;
//            CGContextSetFillColorWithColor(ctx, [[UIColor redColor] CGColor]);
//            CGContextFillRect(ctx, CGRectMake(x, y+h/2, w, h/2));
//            break;
//        default:
//            controlPointX1 = (x + (w/2 + x))/2;
//            controlPointX2 = x + (w/2 + x) + (w - (w/2 + x))/2;
//            controlPointX3 = controlPointX2;
//            controlPointX4 = controlPointX1;
//            controlPointY1 = y+controlYOffset;
//            controlPointY2 = y+h+controlYOffset;
//            break;
//    }
    
    controlPointX1 = _touchXLocationInCell + x;
    controlPointX2 = _touchXLocationInCell + x;
    controlPointX3 = x + (w/2 + x) + (w - (w/2 + x))/2;
    controlPointX4 = (x + (w/2 + x))/2;
    controlPointY1 = HIGHLIGHT_Y_CONTROL_POINT;
    controlPointY2 = y+h+controlYOffset;
    CGContextSetFillColorWithColor(ctx, [[UIColor redColor] CGColor]);
    CGContextFillRect(ctx, CGRectMake(x, y, w, h/2));
    
    // Draw the path
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, x, y);
    CGPathAddCurveToPoint(path, nil, controlPointX1, controlPointY1, controlPointX2, controlPointY1, x+w, y);
    CGPathAddLineToPoint(path, nil, x+w, y+h);
    CGPathAddCurveToPoint(path, nil, controlPointX3, controlPointY2, controlPointX4, controlPointY2, x, y+h);
    CGPathCloseSubpath(path);
    CGContextAddPath(ctx, path);
    CGContextSetFillColorWithColor(ctx, [[UIColor redColor] CGColor]);
    CGContextFillPath(ctx);
    CGPathRelease(path);
}

@end
