//
//  MXRootViewController.h
//  MXAnimatedTransitioning
//
//  Created by 谢鹏翔 on 16/3/28.
//  Copyright © 2016年 谢鹏翔. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MXAnimatedSegueType)
{
    MXAnimatedSegueTypeDefault  = 0,
    MXAnimatedSegueTypeSlider   = 1 << 1,
    MXAnimatedSegueTypeWindow   = 1 << 2,
    MXAnimatedSegueTypeScale    = 1 << 3
};

@interface MXRootViewController : UIViewController<UIViewControllerTransitioningDelegate>

@property (nonatomic, assign) MXAnimatedSegueType   MXType;

// for Scale type
@property (nonatomic, assign) CGRect imageRect;

@end
