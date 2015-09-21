//
//  BootLogic.m
//  TechmasterApp
//
//  Created by techmaster on 9/7/14.
//  Copyright (c) 2014 Techmaster. All rights reserved.
//

#import "BootLogic.h"
#import "MainScreen.h"


@implementation BootLogic
+ (void) boot: (UIWindow*) window
{
    MainScreen* mainScreen = [[MainScreen alloc] initWithStyle:UITableViewStyleGrouped];
    //--------- From this line, please customize your menu data -----------
    NSDictionary* multi = @{SECTION: @"Multimedia", MENU: @[
                                    @{TITLE: @"Play Video", CLASS: @"PlayVideo"}                          ]};
    NSDictionary* autolayout = @{SECTION: @"Autolayout", MENU: @[
                                    @{TITLE: @"Auto layout", CLASS: @"AutoLayout"}                          ]};
    
    mainScreen.menu = @[multi, autolayout];
    mainScreen.title = @"ToanLH demo App";
    mainScreen.about = @"This is demo learning framework demo app. It is collection of sample code of AVFoundation";
    //--------- End of customization -----------
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController: mainScreen];
    
    window.rootViewController = nav;
}
@end
