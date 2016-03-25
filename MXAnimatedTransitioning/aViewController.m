//
//  aViewController.m
//  MXAnimatedTransitioning
//
//  Created by 谢鹏翔 on 16/3/25.
//  Copyright © 2016年 谢鹏翔. All rights reserved.
//

#import "aViewController.h"
#import "MXAnimatedTransiton.h"

@implementation aViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.transitioningDelegate = self;
    self.modalPresentationStyle = UIModalPresentationCustom;
}
- (IBAction)backVC:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [MXAnimatedTransiton transitionWithType:MXAnimatedPresentType durantion:0.5 presentHeight:350 scale:CGPointMake(0.9, 0.9)];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [MXAnimatedTransiton transitionWithType:MXAnimatedDismissType durantion:0.5 presentHeight:350 scale:CGPointMake(0.9, 0.9)];
}


@end
