//
//  LoadingAnimationTableView.m
//  LearningFramework
//
//  Created by TaiND on 10/2/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import "LoadingAnimationTableView.h"
#import "LoadingAnimationCell.h"
#import "TestDrawContext.h"

@interface LoadingAnimationTableView ()
@end

@implementation LoadingAnimationTableView

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)longPressHandle:(UILongPressGestureRecognizer*)ges{
//    CGPoint point = [ges locationInView:self.tableView];
//    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point];
//    if (!indexPath) {
//        NSLog(@"Gesture not in tableview cell.");
//    }
//    else{
//        if (ges.state == UIGestureRecognizerStateEnded) {
//            NSLog(@"Gesture was ended.");
//        }
//        else if (ges.state == UIGestureRecognizerStateBegan){
//            LoadingAnimationCell *cell = (LoadingAnimationCell*)[self.tableView cellForRowAtIndexPath:indexPath];
////            [cell setExpand];
//            UIView *cellContentView  = [cell contentView];
//            CATransform3D transform = CATransform3DIdentity;
////            transform = CATransform3DMakeScale(1, 1, 1);
//            CGPoint offsetPositioning = CGPointMake(0, cell.contentView.frame.size.height*4);
//            transform = CATransform3DTranslate(transform, offsetPositioning.x, offsetPositioning.y, -50.0);
//            cellContentView.layer.transform = transform;
//            cellContentView.layer.opacity = 0.8;
//        }
//    }
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 700;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LoadingAnimationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"x"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"LoadingAnimationCell" owner:nil options:nil].firstObject;
//        cell = [[LoadingAnimationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"x"];
//        cell.accessoryType = UITableViewCellAccessoryDetailButton;
        
//        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressHandle:)];
//        longPress.minimumPressDuration = 1.0;
//        [cell addGestureRecognizer:longPress];
    }
    [cell setData:(int)indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    UIView *cellContentView  = [cell contentView];
//    CGFloat rotationAngleDegrees = -30;
//    CGFloat rotationAngleRadians = rotationAngleDegrees * (M_PI/180);
//    CGPoint offsetPositioning = CGPointMake(500, -20.0);
//    CATransform3D transform = CATransform3DIdentity;
//    transform = CATransform3DRotate(transform, rotationAngleRadians, -50.0, 0.0, 1.0);
//    transform = CATransform3DTranslate(transform, offsetPositioning.x, offsetPositioning.y, -50.0);
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DMakeScale(0, 1, 1);
    cellContentView.layer.transform = transform;
    cellContentView.layer.opacity = 0.8;
    
    [UIView animateWithDuration:.65 delay:0.0 usingSpringWithDamping:0.85 initialSpringVelocity:.8 options:0 animations:^{
        cellContentView.layer.transform = CATransform3DIdentity;
        cellContentView.layer.opacity = 1;
    } completion:^(BOOL finished) {}];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LoadingAnimationCell *cell = (LoadingAnimationCell*)[tableView cellForRowAtIndexPath:indexPath];
//    CGRect cellRect = [tableView rectForRowAtIndexPath:indexPath];
//    
//    [UIView animateWithDuration:0.5 animations:^{
//        if (CGAffineTransformEqualToTransform(cell.transform, CGAffineTransformIdentity)) {
//            cell.transform = CGAffineTransformScale(cell.transform, 1, 4);
//        }else{
//            cell.transform = CGAffineTransformIdentity;
//        }
//    } completion:nil];
    
    NSString* xibClass = @"TestDrawContext";
    
    UIViewController* detailScreen;
    
    if([[NSBundle mainBundle] pathForResource:xibClass ofType:@"nib"] != nil)
    {
        //If the xib file exists
        detailScreen = [(UIViewController*)[NSClassFromString(xibClass) alloc] initWithNibName:xibClass bundle:nil];
    } else {
        //If the xib file does not exist
        detailScreen = [NSClassFromString(xibClass) new];
    }
    detailScreen.title = [NSString stringWithFormat:@"One piece chap %d",(int)indexPath.row];
    ADTransition * transition = [[ADFlipTransition alloc] initWithDuration:0.25f orientation:ADTransitionRightToLeft sourceRect:self.view.frame];
    [self.transitionController pushViewController:detailScreen withTransition:transition];
}

@end
