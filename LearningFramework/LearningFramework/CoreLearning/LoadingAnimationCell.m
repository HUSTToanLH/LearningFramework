//
//  LoadingAnimationCell.m
//  LearningFramework
//
//  Created by TaiND on 10/2/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import "LoadingAnimationCell.h"
@interface LoadingAnimationCell()
@property (strong, nonatomic) IBOutlet UILabel *labelContent;

@end
@implementation LoadingAnimationCell

- (void)awakeFromNib {
    // Initialization code
//    self.backgroundColor = [UIColor clearColor];
//    self.contentView.backgroundColor = [UIColor clearColor];
    _labelContent.backgroundColor = [UIColor clearColor];
    [_labelContent setFont:[UIFont fontWithName:@"Arial" size:13]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setData:(int)numberOfLine{
    _labelContent.text = [@"OnePiece loading animation cell " stringByAppendingString:[NSString stringWithFormat:@"%d", numberOfLine]];
}

@end
