//
//  DemoCollectionViewCell.m
//  LearningFramework
//
//  Created by TaiND on 10/5/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import "DemoCollectionViewCell.h"
@interface DemoCollectionViewCell()

@property (strong, nonatomic) IBOutlet UILabel *labelItem;
@property (strong, nonatomic) IBOutlet UIImageView *imageItem;
@end
@implementation DemoCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
}

-(void)setData:(NSString *)imgName{
    _imageItem.image = [UIImage imageNamed:imgName];
    NSRange range = [imgName rangeOfString:@"." options:NSBackwardsSearch];
    _labelItem.text = [imgName substringToIndex:range.location];
}
@end
