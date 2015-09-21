//
//  PlayVideo.m
//  LearningFramework
//
//  Created by TaiND on 9/21/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import "PlayVideo.h"


@interface PlayVideo ()

@end

@implementation PlayVideo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (IBAction)onPlayVideo:(id)sender {
    NSURL *url = [[NSURL alloc] initWithString:@"http://www.ebookfrenzy.com/ios_book/movie/movie.nov"];
    self.movie = [[MPMoviePlayerController alloc] initWithContentURL:url];
    self.movie.controlStyle = MPMovieControlStyleDefault;
    self.movie.shouldAutoplay = YES;
    [self.view addSubview:self.movie.view];
    [self.movie setFullscreen:YES animated:YES];
    [self.movie play];
}

@end
