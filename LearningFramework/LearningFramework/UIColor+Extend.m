//
//  UIColor+Extend.m
//  TechMasterMainProgram
//
//  Created by TaiND on 8/12/15.
//  Copyright (c) 2015 GiangNX. All rights reserved.
//

#import "UIColor+Extend.h"

@implementation UIColor (Extend)
-(instancetype) initColorHex:(NSString *)hex
                       alpha:(float)alpha
{
    CGFloat alphaValue = 1;
    if (alpha >= 0 && alpha < 1) {
        alphaValue = alpha;
    }
    
    NSString *validateHex = @"abcdefABCDEF0123456789";
    NSMutableString *filterHex = [[NSMutableString alloc] initWithCapacity:6];
    
    for (int i = 0; i < hex.length; i++) {
        unichar item = [hex characterAtIndex:i];
        NSString *itemStr = [[NSString alloc] initWithFormat:@"%c", item];
        if ([validateHex rangeOfString:itemStr
                               options:NSCaseInsensitiveSearch].location != NSNotFound) {
            [filterHex appendString:itemStr];
        }
    }
    
    if (filterHex.length == 6) {
        unsigned long long colorValue;
        NSScanner *scanner = [[NSScanner alloc] initWithString:filterHex];
        [scanner scanHexLongLong:&colorValue];
        
        CGFloat redColor = (CGFloat)((colorValue & 0XFF0000) >> 16) /255.0;
        CGFloat greenColor = (CGFloat)((colorValue & 0X00FF00) >> 8) /255.0;
        CGFloat blueColor = (CGFloat)((colorValue & 0X0000FF))/255.0;
        
        return [self initWithRed:redColor
                           green:greenColor
                            blue:blueColor
                           alpha:alphaValue];
        
    }
    
    return [self initWithRed:0
                       green:0
                        blue:0
                       alpha:alphaValue];
}

@end
