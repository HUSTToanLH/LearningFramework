//
//  BootLogic.m
//  TechmasterApp
//
//  Created by techmaster on 9/7/14.
//  Copyright (c) 2014 Techmaster. All rights reserved.
//

#import "BootLogic.h"
#import "MainScreen.h"
#import "ADNavigationControllerDelegate.h"

@implementation BootLogic
+ (void) boot: (UIWindow*) window
{
    MainScreen* mainScreen = [[MainScreen alloc] initWithStyle:UITableViewStyleGrouped];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"BootMenu" ofType:@"plist"];
    NSArray *content = [[NSArray alloc] initWithContentsOfFile:path];
    NSMutableArray *mainMenu = [NSMutableArray new];
    
    for (int i = 0; i < content.count; i++) {
        @try {
            NSDictionary *dic = (NSDictionary *)[content objectAtIndex:i];
            
            if (dic) {
                if ((BOOL)[dic valueForKey:@"status"] == YES) {
                    NSArray *arr = (NSArray*)[dic objectForKey:@"childs"];
                    NSMutableArray *childMenu = [NSMutableArray new];
                    if (arr) {
                        for (int j = 0; j < arr.count; j++) {
                            NSDictionary *childDic = (NSDictionary*)[arr objectAtIndex:j];
                            if (childDic) {
                                if ((BOOL)[childDic valueForKey:@"status"] == YES) {
                                    [childMenu addObject:@{TITLE: [childDic valueForKey:@"name"], CLASS: [childDic valueForKey:@"class"]}];
                                    
                                }
                            }
                        }
                    }
                    [mainMenu addObject:@{SECTION: [dic valueForKey:@"name"], MENU: childMenu}];
                }
            }
        }
        @catch (NSException *exception) {
            NSLog(@"Does not exist dictionary");
        }
        @finally {
            NSLog(@"Finally");
        }
    }
    
    mainScreen.menu = mainMenu;
    mainScreen.title = @"ToanLH demo App";
    mainScreen.about = @"This is demo learning framework demo app. It is collection of sample code of AVFoundation";
    //--------- End of customization -----------
    ADTransitionController * transitionController = [[ADTransitionController alloc] initWithRootViewController:mainScreen];
    window.rootViewController = transitionController;
}
@end
