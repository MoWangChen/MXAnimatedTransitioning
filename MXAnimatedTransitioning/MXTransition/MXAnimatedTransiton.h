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
    MXAnimatedDismissSliderType,
    
    MXAnimatedPresentWindowType,
    MXAnimatedDismissWindowType
};

@interface MXAnimatedTransiton : NSObject<UIViewControllerAnimatedTransitioning>

/**
 *  跳转动画
 *
 *  @param type          动画类型
 *  @param duration      动画时间
 *  @param presentHeight 弹出距离
 *  @param scale         缩放系数
 *
 *  @return 
 */
+ (MXAnimatedTransiton *)transitionWithType:(MXAnimatedType)type
                                  durantion:(NSTimeInterval)duration
                              presentHeight:(CGFloat)presentHeight
                                      scale:(CGPoint)scale;

@end
