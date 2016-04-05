//
//  UITapGestureRecognizer+blankSlider.m
//  MXAnimatedTransitioning
//
//  Created by 谢鹏翔 on 16/4/5.
//  Copyright © 2016年 谢鹏翔. All rights reserved.
//

#import "UITapGestureRecognizer+blankSlider.h"
#import <objc/runtime.h>


static const void *currentViewControllerKey = &currentViewControllerKey;
static const void *toViewControllerKey = &toViewControllerKey;

@interface UITapGestureRecognizer ()

@end

@implementation UITapGestureRecognizer (blankSlider)

- (UIViewController *)currentViewController
{
    return objc_getAssociatedObject(self, currentViewControllerKey);
}

-(void)setCurrentViewController:(UIViewController *)currentViewController
{
    objc_setAssociatedObject(self, currentViewControllerKey, currentViewController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIViewController *)toViewController
{
    return objc_getAssociatedObject(self, toViewControllerKey);
}

- (void)setToViewController:(UIViewController *)toViewController
{
    objc_setAssociatedObject(self, toViewControllerKey, toViewController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
