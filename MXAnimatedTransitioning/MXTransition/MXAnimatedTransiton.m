//
//  MXAnimatedTransiton.m
//  MXAnimatedTransitioning
//
//  Created by 谢鹏翔 on 16/3/22.
//  Copyright © 2016年 谢鹏翔. All rights reserved.
//

#import "MXAnimatedTransiton.h"

#define mainScreenWidth     [UIScreen mainScreen].bounds.size.width
#define mainScreenHeight    [UIScreen mainScreen].bounds.size.height

@interface MXAnimatedTransiton ()

@property (nonatomic, assign) MXAnimatedType type;
@property (nonatomic, assign) NSTimeInterval duration;

// Scale type
@property (nonatomic, assign) CGRect         rect;

@end

@implementation MXAnimatedTransiton



#pragma mark - UIViewControllerAnimatedTransitioning

+ (MXAnimatedTransiton *)transitionWithType:(MXAnimatedType)type
                                  durantion:(NSTimeInterval)duration
{
    MXAnimatedTransiton * transition = [[MXAnimatedTransiton alloc] init];
    
    transition.type = type;
    transition.duration = duration;
    
    return transition;
}


#pragma mark - UIViewControllerAnimatedTransitioning

- (void)animationEnded:(BOOL)transitionCompleted
{
    NSLog(@"%s", __FUNCTION__);
}

// 指定转场动画时长，必须实现
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.duration;
}

// 转场动画效果
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    switch (self.type) {
        case MXAnimatedPresentType:
            [self present:transitionContext];
            break;
        case MXAnimatedDismissType:
            [self dismiss:transitionContext];
            break;
            
        default:
            break;
    }
}

#pragma mark - Private  Animate -- example
- (void)present:(id<UIViewControllerContextTransitioning>)transitonContext {
    UIViewController *fromVC    = [transitonContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC      = [transitonContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView       = [transitonContext containerView];
    
    // 对fromVC.view的截图添加动画效果
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    tempView.frame = fromVC.view.frame;
    
    // 对截图添加动画，则fromVC可以隐藏
    fromVC.view.hidden = YES;
    
    // 要实现转场，必须加入到containerView中
    [containerView addSubview:tempView];
    [containerView addSubview:toVC.view];
    
    // 我们要设置外部所传参数
    // 设置呈现的高度
    toVC.view.frame = CGRectMake(0,containerView.frame.size.height,containerView.frame.size.width,mainScreenHeight/2);
    
    // 开始动画
    [UIView animateWithDuration:self.duration delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0 / 0.5 options:0 animations:^{
        // 在Y方向移动指定的高度
        toVC.view.transform = CGAffineTransformMakeTranslation(0, -mainScreenHeight/2);
        
    } completion:^(BOOL finished) {
        if (finished) {
            [transitonContext completeTransition:YES];
        }
    }];
}

- (void)dismiss:(id<UIViewControllerContextTransitioning>)transitonContext {
    UIViewController *fromVC = [transitonContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC   = [transitonContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView    = [transitonContext containerView];
    
    // 取出present时的截图用于动画
    UIView *tempView = containerView.subviews.lastObject;
    
    // 开始动画
    [UIView animateWithDuration:self.duration animations:^{
        toVC.view.transform = CGAffineTransformIdentity;
        fromVC.view.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        if (finished) {
            [transitonContext completeTransition:YES];
            toVC.view.hidden = NO;
            
            // 将截图去掉
            [tempView removeFromSuperview];
        }
    }];
}


@end
