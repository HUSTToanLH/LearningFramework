//
//  UIKitDynamics.m
//  LearningFramework
//
//  Created by TaiND on 10/6/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import "UIKitDynamics.h"
#import "UICircleView.h"

@interface UIKitDynamics ()<UIDynamicAnimatorDelegate, UICollisionBehaviorDelegate>

@end

@implementation UIKitDynamics{
    UIDynamicAnimator *animator;
    UIGravityBehavior *gravity;
    UICollisionBehavior *collision;
    UIDynamicItemBehavior *itemBehavior;
    UISnapBehavior *snapBehavior;
    UIView *square;
    BOOL firstContact;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    [self addView];
}

-(void)addView{
    square = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    square.layer.cornerRadius = 50;
    square.backgroundColor = [UIColor grayColor];
    [self.view addSubview:square];
    
    animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    gravity = [[UIGravityBehavior alloc] initWithItems:@[square]];
//    gravity.magnitude = 0.1;
    [animator addBehavior:gravity];
    
    collision = [[UICollisionBehavior alloc] initWithItems:@[square]];
    collision.translatesReferenceBoundsIntoBoundary = TRUE;
    [animator addBehavior:collision];
    
    UIView *barrier = [[UIView alloc] initWithFrame:CGRectMake(0, 300, 130, 20)];
    barrier.backgroundColor = [UIColor redColor];
    [self.view addSubview:barrier];
    
    NSLog(@"w: %f", self.view.frame.size.width);
    
    UIView *barrier2 = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 130, 450, 130, 20)];
    barrier2.backgroundColor = [UIColor redColor];
    [self.view addSubview:barrier2];
    
    [collision addBoundaryWithIdentifier:@"barrier" forPath:[UIBezierPath bezierPathWithRect:barrier.frame]];
    
    [collision addBoundaryWithIdentifier:@"barrier2" forPath:[UIBezierPath bezierPathWithRect:barrier2.frame]];
    
    [collision setAction:^{
//        NSLog(@"%@, %@", NSStringFromCGAffineTransform(square.transform), NSStringFromCGPoint(square.center));
    }];
    
    collision.collisionDelegate = self;
    
    itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[square]];
    itemBehavior.elasticity = 0.6;
    //elasticity: đàn hồi
    //friction: ma sát
    //density: trọng lượng
    //resistance: lực cản
    //angularResistance: lực cản góc
    //allowsRotation: xoay
    
    [animator addBehavior:itemBehavior];
    firstContact = false;
}

-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p{
    NSLog(@"Bounce: %@", identifier);
    UIView *coliddingView = (UIView*)item;
    coliddingView.backgroundColor = [UIColor yellowColor];
    [UIView animateWithDuration:0.3 animations:^{
        coliddingView.backgroundColor = [UIColor grayColor];
    } completion:nil];
    
    if (!firstContact) {
        firstContact = true;
        
        UIView *square2 = [[UIView alloc] initWithFrame:CGRectMake(100, 0, 100, 100)];
        square2.layer.cornerRadius = 50;
        square2.backgroundColor = [UIColor grayColor];
        [self.view addSubview:square2];
        
        [itemBehavior addItem:square2];
        [collision addItem:square2];
        [gravity addItem:square2];
        
//        UIAttachmentBehavior *attach= [[UIAttachmentBehavior alloc] initWithItem:coliddingView attachedToItem:square];
//        
//        [animator addBehavior:attach];
    }
//    else{
//        firstContact = false;
//    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (snapBehavior != nil) {
        [animator removeBehavior:snapBehavior];
    }
    
    UITouch *touch = (UITouch*)touches.anyObject;
    snapBehavior = [[UISnapBehavior alloc] initWithItem:square snapToPoint:[touch locationInView:self.view]];
    [animator addBehavior:snapBehavior];
}

@end
