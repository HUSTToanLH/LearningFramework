//
//  LoadingAnimationTableView.m
//  LearningFramework
//
//  Created by TaiND on 10/2/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import "LoadingAnimationTableView.h"
#import "LoadingAnimationCell.h"

@interface LoadingAnimationTableView ()

@end

@implementation LoadingAnimationTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LoadingAnimationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"x"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"LoadingAnimationCell" owner:nil options:nil].firstObject;
//        cell = [[LoadingAnimationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"x"];
//        cell.accessoryType = UITableViewCellAccessoryDetailButton;
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

@end
