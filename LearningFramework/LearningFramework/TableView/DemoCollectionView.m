//
//  DemoCollectionView.m
//  LearningFramework
//
//  Created by TaiND on 10/5/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import "DemoCollectionView.h"
#import "DemoCollectionViewCell.h"
#import "Flickr.h"
#import "FlickrPhoto.h"
#import "UIView+Copy.h"
#import "UIColor+Extend.h"

@interface DemoCollectionView ()<UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property(nonatomic, weak) IBOutlet UIToolbar *toolbar;
@property(nonatomic, weak) IBOutlet UIBarButtonItem *shareButton;
@property(nonatomic, weak) IBOutlet UITextField *textField;
@property(nonatomic, weak) IBOutlet UICollectionView *collectionView;

@property(nonatomic, strong) NSMutableDictionary *searchResults;
@property(nonatomic, strong) NSMutableArray *searches;
@property(nonatomic, strong) Flickr *flickr;

- (IBAction)shareButtonTapped:(id)sender;
@end

@implementation DemoCollectionView{
    UIView *contentCell;
    CGRect contentFrame;
}

#pragma mark - initilazion view
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_cork.png"]];
//    [self.collectionView registerClass:[DemoCollectionViewCell class] forCellWithReuseIdentifier:@"collectionItem"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"DemoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"collectionItem"];
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self setCustomView];
    [self initData];
}

-(void)setCustomView{
    UIImage *navImg = [[UIImage imageNamed:@"navbar.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(27, 27, 27, 27)];
    [self.toolbar setBackgroundImage:navImg forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    
    UIImage *shareImg = [[UIImage imageNamed:@"button.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [self.shareButton setBackgroundImage:shareImg forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    UIImage *txfImg= [[UIImage imageNamed:@"search_field.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [self.textField setBackground:txfImg];
    
    contentFrame = CGRectMake(0, 0, 0, 0);
    contentCell = [[UIView alloc] initWithFrame:contentFrame];
    [self.view addSubview:contentCell];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnView:)];
    contentCell.userInteractionEnabled = YES;
    [contentCell addGestureRecognizer:tap];
}

-(void)tapOnView:(UIGestureRecognizer*)ges{
    if (ges.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:1 animations:^{
            contentCell.frame = CGRectMake(0, 0, 0, 0);
        } completion:nil];
    }
}

-(void)initData{
    self.searchResults = [@{} mutableCopy];
    self.searches = [NSMutableArray arrayWithArray:@[@"bao.png",@"bo.png",@"cat.png",@"cat2.png",@"cuu.png",@"dog.png",@"dog2.png",@"grows.png",@"lion.png",@"monkey.png",@"bao.png",@"bo.png",@"cat.png",@"cat2.png",@"cuu.png",@"dog.png",@"dog2.png",@"grows.png",@"lion.png",@"monkey.png",@"bao.png",@"bo.png",@"cat.png",@"cat2.png",@"cuu.png",@"dog.png",@"dog2.png",@"grows.png",@"lion.png",@"monkey.png", @"bao.png",@"bo.png",@"cat.png",@"cat2.png",@"cuu.png",@"dog.png",@"dog2.png",@"grows.png",@"lion.png",@"monkey.png",@"bao.png",@"bo.png",@"cat.png",@"cat2.png",@"cuu.png",@"dog.png",@"dog2.png",@"grows.png",@"lion.png",@"monkey.png",@"bao.png",@"bo.png",@"cat.png",@"cat2.png",@"cuu.png",@"dog.png",@"dog2.png",@"grows.png",@"lion.png",@"monkey.png",@"bao.png",@"bo.png",@"cat.png",@"cat2.png",@"cuu.png",@"dog.png",@"dog2.png",@"grows.png",@"lion.png",@"monkey.png",@"bao.png",@"bo.png",@"cat.png",@"cat2.png",@"cuu.png",@"dog.png",@"dog2.png",@"grows.png",@"lion.png",@"monkey.png",@"bao.png",@"bo.png",@"cat.png",@"cat2.png",@"cuu.png",@"dog.png",@"dog2.png",@"grows.png",@"lion.png",@"monkey.png"]];
    self.flickr = [Flickr new];
}

#pragma mark - event inview
-(void)shareButtonTapped:(id)sender{
    
}

#pragma mark - collection view
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100, 150);
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.searches.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"collectionItem";
    
    DemoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"DemoCollectionViewCell" owner:nil options:nil].firstObject;
    }
    
    [cell setData:(NSString*)_searches[(int)indexPath.row]];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DemoCollectionViewCell *cell = (DemoCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    
    UICollectionViewLayoutAttributes *attributes = [collectionView layoutAttributesForItemAtIndexPath:indexPath];
    
    CGRect cellRect = attributes.frame;
    CGPoint cellCenter = CGPointMake(cellRect.origin.x + cellRect.size.width/2, cellRect.origin.y + cellRect.size.height/2);
    
    [UIView animateWithDuration:0.5 animations:^{
        if (CGAffineTransformEqualToTransform(cell.transform, CGAffineTransformIdentity)){
            cell.transform = CGAffineTransformScale(cell.transform, 3.0, 3.0);
            cell.center = CGPointMake(_collectionView.bounds.size.width/2, _collectionView.bounds.size.height/2 + _collectionView.contentOffset.y);
            cell.imageBg.backgroundColor = [[UIColor alloc] initColorHex:@"#CCFFFF" alpha:1];
            cell.imagePush.hidden = YES;
            [_collectionView bringSubviewToFront:cell];
            
        } else {
            cell.transform = CGAffineTransformIdentity;
            cell.imageBg.backgroundColor = [UIColor whiteColor];
            cell.center = cellCenter;
        }
    } completion:^(BOOL finished) {
        if (CGAffineTransformEqualToTransform(cell.transform, CGAffineTransformIdentity)){
            cell.imagePush.hidden = NO;
        } else {
            cell.imagePush.hidden = YES;
        }
    }];
}

#pragma mark - event core
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
