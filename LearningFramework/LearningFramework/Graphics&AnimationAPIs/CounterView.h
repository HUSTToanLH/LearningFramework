//
//  CounterView.h
//  LearningFramework
//
//  Created by TaiND on 10/8/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CounterView : UIView
@property(nonatomic, assign) IBInspectable int counter;
@property(nonatomic, strong) IBInspectable UIColor *outlineColor;
@property(nonatomic, strong) IBInspectable UIColor *counterColor;
@end
