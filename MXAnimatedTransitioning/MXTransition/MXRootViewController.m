//
//  MXRootViewController.m
//  MXAnimatedTransitioning
//
//  Created by 谢鹏翔 on 16/3/28.
//  Copyright © 2016年 谢鹏翔. All rights reserved.
//

#import "MXRootViewController.h"
#import "MXAnimatedTransiton.h"

#define ScreenWidth         ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight        ([UIScreen mainScreen].bounds.size.height)


@implementation MXRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.transitioningDelegate = self;
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.view.clipsToBounds = YES;
    self.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight/2);
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [MXAnimatedTransiton transitionWithType:MXAnimatedPresentType durantion:0.5];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [MXAnimatedTransiton transitionWithType:MXAnimatedDismissType durantion:0.5];
}

@end
