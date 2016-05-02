//
//  MXRootViewController.m
//  MXAnimatedTransitioning
//
//  Created by 谢鹏翔 on 16/3/28.
//  Copyright © 2016年 谢鹏翔. All rights reserved.
//

#import "MXRootViewController.h"
#import "MXAnimatedTransiton.h"
#import "UITapGestureRecognizer+blankSlider.h"

#define ScreenWidth         ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight        ([UIScreen mainScreen].bounds.size.height)


@implementation MXRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (_MXType != MXAnimatedSegueTypeDefault) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.view.clipsToBounds = YES;
        
        switch (_MXType) {
            case MXAnimatedSegueTypeSlider:
                self.view.frame = CGRectMake(0, 0, 220, ScreenHeight);
                break;
                
            default:
                break;
        }
        
    }
    
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (void)clickBlank:(UITapGestureRecognizer *)gesture
{
    [gesture.currentViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    switch (self.MXType) {
        case MXAnimatedSegueTypeSlider:
            return [MXAnimatedTransiton transitionWithType:MXAnimatedPresentSliderType durantion:0.5 presentHeight:220 scale:CGPointMake(1, 1)];
            break;
            
        case MXAnimatedSegueTypeWindow:
            return [MXAnimatedTransiton transitionWithType:MXAnimatedPresentWindowType durantion:0.5 presentHeight:ScreenWidth scale:CGPointMake(1, 1)];
            break;
            
        default:
            break;
    }
    
    
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    
    switch (self.MXType) {
        case MXAnimatedSegueTypeSlider:
            return [MXAnimatedTransiton transitionWithType:MXAnimatedDismissSliderType durantion:0.5 presentHeight:220 scale:CGPointMake(1, 1)];
            break;
            
        case MXAnimatedSegueTypeWindow:
            return [MXAnimatedTransiton transitionWithType:MXAnimatedDismissWindowType durantion:0.5 presentHeight:ScreenWidth scale:CGPointMake(1, 1)];
            break;
            
        default:
            break;
    }
    
    return nil;
}

@end
