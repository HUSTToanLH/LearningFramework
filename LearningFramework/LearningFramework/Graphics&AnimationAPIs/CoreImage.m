//
//  CoreImage.m
//  LearningFramework
//
//  Created by TaiND on 10/7/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import "CoreImage.h"

@interface CoreImage ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation CoreImage{
    UIImageView *imgView;
    UISlider *slider;
    CIFilter *filter;
    CIContext *context;
    UIButton *btn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addImageView];
}

-(void)addImageView{
    imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    imgView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
//    imgView.image = [UIImage imageNamed:@"Zoro.png"];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:imgView];
    
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"Zoro" withExtension:@"jpg"];
    CIImage *beginImage = [[CIImage alloc] initWithContentsOfURL:fileURL];
    
    filter = [CIFilter filterWithName:@"CISepiaTone"];
    [filter setValue:beginImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:0.5] forKey:kCIInputIntensityKey];
    
    
    UIImage *newImage = [UIImage imageWithCIImage:filter.outputImage];
    imgView.image = newImage;

    
    context = [CIContext contextWithOptions:nil];
    
    struct CGImage *cgImage = [context createCGImage:filter.outputImage fromRect:filter.outputImage.extent];
    
    UIImage *newImage2 = [UIImage imageWithCGImage:cgImage];
    imgView.image = newImage2;
    
    slider = [[UISlider alloc] initWithFrame:CGRectMake(8, self.view.bounds.size.height - 200, self.view.bounds.size.width - 16, 40)];
    slider.minimumValue = 0;
    slider.maximumValue = 100;
    slider.value = 10;
    [self.view addSubview:slider];
    
    [slider addTarget:self action:@selector(amountSliderValueChange:) forControlEvents:UIControlEventValueChanged];
    
    btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    btn.center = CGPointMake(self.view.bounds.size.width/2, 80);
    [btn setTitle:@"Load Photo" forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont fontWithName:@"Arial" size:14]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(loadView:) forControlEvents:UIControlEventTouchUpInside];
}

//load photo from device?!
-(IBAction)loadView:(id)sender{
    UIImagePickerController *pickerC = [UIImagePickerController new];
    pickerC.delegate = self;
    [self presentViewController:pickerC animated:true completion:nil];
}

-(IBAction)amountSliderValueChange:(UISlider*)sender{
    float sliderValue = sender.value;
    [filter setValue:[NSNumber numberWithFloat:sliderValue] forKey:kCIInputIntensityKey];
    
    CIImage *outputImage = filter.outputImage;
    struct CGImage *cgImage = [context createCGImage:outputImage fromRect:outputImage.extent];
    
    UIImage *newImage = [UIImage imageWithCGImage:cgImage];
    imgView.image = newImage;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"info: %@", info);
}

@end
