//
//  UIView+Copy.m
//  LearningFramework
//
//  Created by TaiND on 10/5/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import "UIView+Copy.h"

@implementation UIView (Copy)
- (UIView*)duplicate {
    UIView *v = [[[self class] alloc] initWithFrame:self.frame];
    v.autoresizingMask = self.autoresizingMask;
    
    for (UIView *v1 in self.subviews) {
        UIView *v2 = [[[v1 class] alloc] initWithFrame:v1.frame];
        v2.autoresizingMask = v1.autoresizingMask;
        [v addSubview:v2];
    }
    
    return v;
}
@end

