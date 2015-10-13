//
//  PushButtonView.h
//  LearningFramework
//
//  Created by TaiND on 10/8/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PushButtonView : UIButton
@property(nonatomic, assign) IBInspectable BOOL isAddButton;
@property(nonatomic, strong) IBInspectable UIColor *fillColor;
@end
