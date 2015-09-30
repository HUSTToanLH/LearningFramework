//
//  Car.m
//  LearningFramework
//
//  Created by TaiND on 9/29/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import "Car.h"

@implementation Car

-(void)driverForDuration:(double)duration
       withVariableSpeed:(double (^)(double))speedFunction
                 andStep:(double)numSteps{
    double dt = duration/ numSteps;
    for (int i = 0; i < numSteps; i++) {
        _odometer = speedFunction(i*dt)*dt;
    }
}

@end
