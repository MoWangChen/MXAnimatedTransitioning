//
//  MXAnimatedTransiton.h
//  MXAnimatedTransitioning
//
//  Created by 谢鹏翔 on 16/3/22.
//  Copyright © 2016年 谢鹏翔. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, MXAnimatedType)
{
    MXAnimatedPresentType,
    MXAnimatedDismissType,
    
    MXAnimatedPresentSliderType,
    MXAnimatedDismissSliderType
};

@interface MXAnimatedTransiton : NSObject<UIViewControllerAnimatedTransitioning>


+ (MXAnimatedTransiton *)transitionWithType:(MXAnimatedType)type
                                  durantion:(NSTimeInterval)duration
                              presentHeight:(CGFloat)presentHeight
                                      scale:(CGPoint)scale;

@end
