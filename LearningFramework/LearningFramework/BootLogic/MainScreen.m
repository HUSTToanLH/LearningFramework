//
//  MainScreen.m
//  TechmasterApp
//
//  Created by techmaster on 9/7/14.
//  Copyright (c) 2014 Techmaster. All rights reserved.
//

#import "MainScreen.h"
#import "BootLogic.h"
#import "ADTransformTransition.h"
#import "ADNavigationControllerDelegate.h"

@interface MainScreen () <UIAlertViewDelegate>

@end

@implementation MainScreen
/*
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    }
    return self;
}
*/
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"About" style:UIBarButtonItemStylePlain target:self action:@selector(onAbout)];
    self.navigationItem.rightBarButtonItem = barButtonItem;
//    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
}
- (void)setAbout:(NSString *)about {
    _about = [NSString stringWithFormat:@"%@\n\n%@", about, @"Written by Techmaster Vietnam Ltd"];
}
-(void) onAbout {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"About" message:self.about delegate:self cancelButtonTitle:@"Thank" otherButtonTitles:nil, nil];
    [alert show];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.menu count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary* menuSection = self.menu[section];
    
    return [menuSection[MENU] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary* menuSection = self.menu[section];
    return menuSection[SECTION];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellID = @"ID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSDictionary* menuSection = self.menu[indexPath.section];
    NSDictionary* menuItem = menuSection[MENU][indexPath.row];
    cell.textLabel.text = menuItem[TITLE];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* menuSection = self.menu[indexPath.section];
    NSDictionary* menuItem = menuSection[MENU][indexPath.row];
    NSString* xibClass = menuItem[CLASS];

    UIViewController* detailScreen;
    
    if([[NSBundle mainBundle] pathForResource:xibClass ofType:@"nib"] != nil)
    {
        //If the xib file exists
        detailScreen = [(UIViewController*)[NSClassFromString(xibClass) alloc] initWithNibName:xibClass bundle:nil];
    } else {
        //If the xib file does not exist
        detailScreen = [NSClassFromString(xibClass) new];
    }
    detailScreen.title = menuItem[TITLE];
    
    //toanlh: effect for pushviewcontroller
//    CATransition *transition = [CATransition animation];
//    transition.duration = 1.0;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    transition.type = kCATransitionPush;
//    transition.subtype = kCATransitionFromTop;
//    transition.delegate = self;
//    
//    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    
    if (detailScreen) {
        //cách 1: transitionfromview
//        [UIView transitionFromView:self.navigationController.topViewController.view toView:detailScreen.view duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
//            [self.navigationController pushViewController:detailScreen animated:NO];
//        }];
        
        //UIViewAnimationOptionTransitionFlipFromRight: xoay theo trục Oy 180 độ
        //UIViewAnimationOptionTransitionFlipFromLeft: xoay theo trục Oy 180 độ
        //UIViewAnimationOptionTransitionFlipFromBottom: xoay theo trục Ox 180 độ
        //UIViewAnimationOptionTransitionFlipFromTop: xoay theo trục Ox 180 độ
        
        //UIViewAnimationOptionTransitionCrossDissolve
        //UIViewAnimationOptionTransitionCurlDown: lật trang sách từ trên xuống dưới
        //UIViewAnimationOptionTransitionCurlUp: lật trang sách từ dưới lên
        
        
        //cách 2: animation
//        [UIView animateWithDuration:1
//                         animations:^{
//                             [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//                             [self.navigationController pushViewController:detailScreen animated:NO];
//                             [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:NO];
//                         }];
        
//        [self.navigationController pushViewController:detailScreen animated:YES];
        
        //cách 2: ADTranssition
        //ADCarrouselTransition: hình hộp chìm
//        ADTransition * transition = [[ADCarrouselTransition alloc] initWithDuration:0.25f orientation:ADTransitionRightToLeft sourceRect:self.view.frame];

        //ADCubeTransition: hình hộp nổi
//        ADTransition * transition = [[ADCubeTransition alloc] initWithDuration:0.25f orientation:ADTransitionRightToLeft sourceRect:self.view.frame];
        
        //ADCrossTransition: cross 2 view
//        ADTransition* transition= [[ADCrossTransition alloc] initWithDuration:0.25f];
        
        //ADFlipTransition: lật view
        ADTransition * transition = [[ADFlipTransition alloc] initWithDuration:0.25f orientation:ADTransitionRightToLeft sourceRect:self.view.frame];
        
        //ADSwapTransition: đổi view
//        ADTransition * transition = [[ADSwapTransition alloc] initWithDuration:0.25f orientation:ADTransitionRightToLeft sourceRect:self.view.frame];
        
        //ADFadeTransition: làm nhạt dần view trước để hiện view sau
//        ADTransition * transition = [[ADFadeTransition alloc] initWithDuration:0.25f];
        
        //ADBackFadeTransition: thu nhỏ view trước rồi phóng to dần view sau
//        ADTransition * transition = [[ADBackFadeTransition alloc] initWithDuration:0.25f];
        
        //ADGhostTransition: thu nhỏ view trước rồi hiện luôn view sau
//        ADTransition * transition = [[ADGhostTransition alloc] initWithDuration:0.25f];
        
        //ADZoomTransition: hiện luôn view sau (animated: NO)
//        ADTransition * transition = [[ADZoomTransition alloc] initWithDuration:0.25f];
        
        //ADSwipeTransition: giống mặc định
//        ADTransition * transition = [[ADSwipeTransition alloc] initWithDuration:0.25 orientation:ADTransitionRightToLeft sourceRect:self.view.frame];
        
        //ADSwipeFadeTransition: vừa swipe vừa fade (xấu)
//        ADTransition * transition = [[ADSwipeFadeTransition alloc] initWithDuration:0.25 orientation:ADTransitionRightToLeft sourceRect:self.view.frame];
        
        //ADScaleTransition: scale nhỏ view trước rồi hiện view sau
//        ADTransition * transition = [[ADScaleTransition alloc] initWithDuration:0.25 orientation:ADTransitionRightToLeft sourceRect:self.view.frame];
        
        //ADGlueTransition: giống đóng mở cửa (1 cánh)
//        ADTransition * transition = [[ADGlueTransition alloc] initWithDuration:0.25 orientation:ADTransitionRightToLeft sourceRect:self.view.frame];
        
        //ADPushRotateTransition: tương tự glue
//         ADTransition * transition = [[ADPushRotateTransition alloc] initWithDuration:0.25 orientation:ADTransitionRightToLeft sourceRect:self.view.frame];
        
        //ADFoldTransition: tương tự trên
//        ADTransition * transition = [[ADFoldTransition alloc] initWithDuration:0.25 orientation:ADTransitionRightToLeft sourceRect:self.view.frame];
        
        //ADSlideTransition: giống chuyển slide
//        ADTransition * transition = [[ADSlideTransition alloc] initWithDuration:0.25 orientation:ADTransitionRightToLeft sourceRect:self.view.frame];
        
        [self.transitionController pushViewController:detailScreen withTransition:transition];
        
    } else {
        //Warn if cannot initialize detailScreen
        NSString* message = [NSString stringWithFormat:@"Please implement screen %@", xibClass];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

@end
