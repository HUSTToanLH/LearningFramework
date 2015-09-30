//
//  UsingBlock.m
//  LearningFramework
//
//  Created by TaiND on 9/29/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import "UsingBlock.h"
#import "Car.h"

@interface UsingBlock ()

@end

@implementation UsingBlock{
    double(^randomFloat)(void);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self parameterBlock];
//    [self variableBlock];
//    [self closureBlock];
//    [self mutableVariableBlock];
    [self methodParameterBlock];
}

-(void)variableBlock{
    double (^hourAndMinute)(double hour, double minute);
    
    hourAndMinute = ^double(double hour, double minute){
        return hour*60 + minute;
    };
    
    double dx = hourAndMinute(3, 39);
    NSLog(@"Sum minute: %f", dx);
    double dy = randomFloat();
    NSLog(@"Random number dy: %f", dy);
}

-(void)parameterBlock{
    
    randomFloat = ^{
        return (double)arc4random();
    };
    
    double dx = randomFloat();
    NSLog(@"Random number dx: %f", dx);
}

-(void)closureBlock{
    NSString *firstName = @"Lai";
    NSString * (^getFullName)(NSString *) = ^(NSString* lastname){
        return [firstName stringByAppendingString:lastname];
    };
    
    NSLog(@"Full name: %@", getFullName(@" Huu Toan"));
    
    firstName = @"Le";
    NSLog(@"Full name: %@", getFullName(@" Huu Toan"));
}

-(void)mutableVariableBlock{
    __block int i = 0;
    int (^count)(void) = ^{
        i+=1;
        return i;
    };
    
    NSLog(@"count: %d", count());
    NSLog(@"count: %d", count());
    NSLog(@"count: %d", count());
}

-(void)methodParameterBlock{
    Car *theCar = [Car new];
    [theCar driverForDuration:10
            withVariableSpeed:^double(double time) {
                return 5;
            } andStep:100];
    
    NSLog(@"Car odometer: %f", theCar.odometer);
    
    [theCar driverForDuration:10
            withVariableSpeed:^double(double time) {
                return time + 5;
            } andStep:100];
    
    NSLog(@"Car odometer: %f", theCar.odometer);
}

@end
