//
//  DemoCollectionViewCell.h
//  LearningFramework
//
//  Created by TaiND on 10/5/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemoCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIView *imageBg;
@property (strong, nonatomic) IBOutlet UIImageView *imagePush;
-(void)setData:(NSString*)imgName;
@end
