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

@implementation MXRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (_MXType != MXAnimatedSegueTypeDefault) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
}

- (void)clickBlank:(UITapGestureRecognizer *)gesture
{
    [gesture.currentViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [MXAnimatedTransiton transitionWithType:MXAnimatedPresentType durantion:0.5 presentHeight:220 scale:CGPointMake(1, 1)];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [MXAnimatedTransiton transitionWithType:MXAnimatedDismissType durantion:0.5 presentHeight:220 scale:CGPointMake(1, 1)];
}

@end
