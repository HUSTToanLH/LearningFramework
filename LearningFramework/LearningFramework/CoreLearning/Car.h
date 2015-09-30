//
//  Car.h
//  LearningFramework
//
//  Created by TaiND on 9/29/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject
@property double odometer;

-(void)driverForDuration:(double)duration
       withVariableSpeed:(double (^)(double time))speedFunction
                 andStep:(double)numSteps;
@end
