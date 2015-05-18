//
//  ViewController.m
//  TODO
//
//  Created by chenguandong on 15/4/16.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import "ViewController.h"
#import <UIImageView+LBBlurredImage.h>
@interface ViewController ()
@property(nonatomic,strong)UIImageView *imageView;
@end

@implementation ViewController

-(void)awakeFromNib{
    
    self.menuPreferredStatusBarStyle = UIStatusBarStyleLightContent;
    self.contentViewShadowColor = [UIColor redColor];
    self.contentViewShadowOffset = CGSizeMake(0, 0);
    self.contentViewShadowOpacity = 0.6;
    self.contentViewShadowRadius = 12;
    
    self.panMinimumOpenThreshold = 100;
    
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Home"];
    self.leftMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    

    
    _imageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    
    
    __weak typeof(self) weakSelf = self;
    
    __weak UIImageView *blurImageView = _imageView;
    [blurImageView setImageToBlur:[UIImage imageNamed:@"Start"]
                        blurRadius:kLBBlurredImageDefaultBlurRadius
                   completionBlock:^(){
                       NSLog(@"The blurred image has been set");

                       weakSelf.backgroundImage = blurImageView.image;//[UIImage imageNamed:@"Start"];

                       _imageView = nil;

                       
                   }];

   
    
    self.delegate = self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}


#pragma mark -
#pragma mark RESideMenu Delegate

- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
