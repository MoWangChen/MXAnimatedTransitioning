//
//  UITapGestureRecognizer+blankSlider.h
//  MXAnimatedTransitioning
//
//  Created by 谢鹏翔 on 16/4/5.
//  Copyright © 2016年 谢鹏翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITapGestureRecognizer (blankSlider)

/**
 *  侧边栏的viewController
 */
@property (nonatomic, strong) UIViewController *currentViewController;

/**
 *  要跳转的viewController
 */
@property (nonatomic, strong) UIViewController *toViewController;

@end
