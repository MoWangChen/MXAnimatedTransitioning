//
//  MXAnimatedTransiton.m
//  MXAnimatedTransitioning
//
//  Created by 谢鹏翔 on 16/3/22.
//  Copyright © 2016年 谢鹏翔. All rights reserved.
//

#import "MXAnimatedTransiton.h"
#import "UITapGestureRecognizer+blankSlider.h"
#import "UIView+Screenshot.h"

@interface MXAnimatedTransiton ()

@property (nonatomic, assign) MXAnimatedType type;
@property (nonatomic, assign) CGFloat        presentHeight;
@property (nonatomic, assign) CGPoint        scale;
@property (nonatomic, assign) NSTimeInterval duration;

@end

@implementation MXAnimatedTransiton



#pragma mark - UIViewControllerAnimatedTransitioning

+ (MXAnimatedTransiton *)transitionWithType:(MXAnimatedType)type
                                durantion:(NSTimeInterval)duration
                            presentHeight:(CGFloat)presentHeight
                                    scale:(CGPoint)scale
{
    MXAnimatedTransiton *transition = [[MXAnimatedTransiton alloc] init];
    
    transition.type          = type;
    transition.presentHeight = presentHeight;
    transition.scale         = scale;
    transition.duration      = duration;
    
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
            
        case MXAnimatedPresentSliderType:
            [self presentSliderMode:transitionContext];
            break;
        case MXAnimatedDismissSliderType:
            [self dismissSliderMode:transitionContext];
            break;
            
        case MXAnimatedPresentWindowType:
            [self presentWindowMode:transitionContext];
            break;
        case MXAnimatedDismissWindowType:
            [self dismissWindowMode:transitionContext];
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
    toVC.view.frame = CGRectMake(0,containerView.frame.size.height,containerView.frame.size.width,self.presentHeight);
    
    // 开始动画
    __weak __typeof(self) weakSelf = self;
    [UIView animateWithDuration:self.duration delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0 / 0.5 options:0 animations:^{
        // 在Y方向移动指定的高度
        toVC.view.transform = CGAffineTransformMakeTranslation(0, -weakSelf.presentHeight);
        
        // 让截图缩放
        tempView.transform = CGAffineTransformMakeScale(weakSelf.scale.x, weakSelf.scale.y);
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

#pragma mark - Private  Animate -- 1.侧边栏
- (void)presentSliderMode:(id<UIViewControllerContextTransitioning>)transitonContext {
    UIViewController *fromVC    = [transitonContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC      = [transitonContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView       = [transitonContext containerView];
    
    // 对fromVC.view的截图添加动画效果
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    tempView.frame = fromVC.view.frame;
    
    // 添加边框特效
    UIView *coolLine = [[UIView alloc] initWithFrame:CGRectMake(-1, 0, 1, tempView.bounds.size.height)];
    coolLine.backgroundColor = [UIColor orangeColor];
    coolLine.layer.shadowOffset = CGSizeMake(0, 5);
    coolLine.layer.shadowRadius = 5.0;
    coolLine.layer.shadowColor = [UIColor redColor].CGColor;
    coolLine.layer.shadowOpacity = 1;
    [tempView addSubview:coolLine];
    
    // 增加空白处  点击 退出侧边栏效果
    UITapGestureRecognizer *tapBlank = [[UITapGestureRecognizer alloc] initWithTarget:toVC action:@selector(clickBlank:)];
    tapBlank.currentViewController = toVC;
    [tempView addGestureRecognizer:tapBlank];
    
    // 对截图添加动画，则fromVC可以隐藏
    fromVC.view.hidden = YES;
    
    // 要实现转场，必须加入到containerView中
    [containerView addSubview:tempView];
    [containerView addSubview:toVC.view];
    
    // 我们要设置外部所传参数
    // 设置呈现的高度
    toVC.view.frame = CGRectMake(-self.presentHeight,0,self.presentHeight,containerView.frame.size.height);
    
    // 开始动画
    __weak __typeof(self) weakSelf = self;
    [UIView animateWithDuration:self.duration delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0 / 0.5 options:0 animations:^{
        // 在Y方向移动指定的高度
        tempView.transform = CGAffineTransformMakeTranslation(weakSelf.presentHeight, 0);
        toVC.view.transform   = CGAffineTransformMakeTranslation(weakSelf.presentHeight, 0);
        
        // 让截图缩放
//        tempView.transform = CGAffineTransformMakeScale(weakSelf.scale.x, weakSelf.scale.y);
    } completion:^(BOOL finished) {
        if (finished) {
            [transitonContext completeTransition:YES];
        }
    }];
}

- (void)dismissSliderMode:(id<UIViewControllerContextTransitioning>)transitonContext {
    UIViewController *fromVC = [transitonContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC   = [transitonContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView    = [transitonContext containerView];
    
    // 取出present时的截图用于动画
    UIView *tempView = containerView.subviews.firstObject;
    
    // 开始动画
    [UIView animateWithDuration:self.duration animations:^{
        toVC.view.transform = CGAffineTransformIdentity;
        fromVC.view.transform = CGAffineTransformIdentity;
        tempView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if (finished) {
            [transitonContext completeTransition:YES];
            toVC.view.hidden = NO;
            
            // 将截图去掉
            [tempView removeFromSuperview];
        }
    }];
}


#pragma mark - Privite Animate -- 2.窗户效果
- (void)presentWindowMode:(id<UIViewControllerContextTransitioning>)transitonContext {
    UIViewController *fromVC    = [transitonContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC      = [transitonContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView       = [transitonContext containerView];
    
    NSLog(@"%f,  %f",toVC.view.frame.size.width,toVC.view.frame.size.height);
    
    // 对fromVC.view的截图添加动画效果
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    tempView.frame = fromVC.view.frame;
    
    UIImage *leftPartImage = [fromVC.view screenshotWithRect:CGRectMake(0, 0,tempView.bounds.size.width/2,tempView.bounds.size.height)];
    UIImage *rightPartImage = [fromVC.view screenshotWithRect:CGRectMake(tempView.bounds.size.width/2, 0,tempView.bounds.size.width/2,tempView.bounds.size.height)];
    
    UIImageView *leftPartWindow = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, tempView.bounds.size.width/2, tempView.bounds.size.height)];
    leftPartWindow.image = leftPartImage;
    leftPartWindow.backgroundColor = [UIColor redColor];
    leftPartWindow.contentMode = UIViewContentModeScaleAspectFit;
    
    UIImageView *rightPartWindow = [[UIImageView alloc] initWithFrame:CGRectMake(tempView.bounds.size.width/2, 0, tempView.bounds.size.width/2, tempView.bounds.size.height)];
    rightPartWindow.image = rightPartImage;
    rightPartWindow.backgroundColor = [UIColor yellowColor];
    rightPartWindow.contentMode = UIViewContentModeScaleAspectFit;
    
    
    
    // 对截图添加动画，则fromVC可以隐藏
    fromVC.view.hidden = YES;
    
    // 要实现转场，必须加入到containerView中
    [containerView addSubview:toVC.view];
    [containerView addSubview:leftPartWindow];
    [containerView addSubview:rightPartWindow];
    
    
    // 开始动画
    [UIView animateWithDuration:self.duration animations:^{
        // 在X方向移动指定的高度
        leftPartWindow.transform = CGAffineTransformMakeTranslation(- containerView.frame.size.width/2, 0);
        rightPartWindow.transform = CGAffineTransformMakeTranslation( containerView.frame.size.width/2, 0);
    } completion:^(BOOL finished) {
        if (finished) {
            [transitonContext completeTransition:YES];
        }
    }];
    
    
    
}

- (void)dismissWindowMode:(id<UIViewControllerContextTransitioning>)transitonContext {
    UIViewController *fromVC = [transitonContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC   = [transitonContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView    = [transitonContext containerView];
    
    // 取出present时的截图用于动画
    UIView *leftView = containerView.subviews[1];
    UIView *rightView = containerView.subviews[2];
    
    // 开始动画
    [UIView animateWithDuration:self.duration animations:^{
        leftView.transform = CGAffineTransformIdentity;
        rightView.transform = CGAffineTransformIdentity;
        fromVC.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if (finished) {
            [transitonContext completeTransition:YES];
            toVC.view.hidden = NO;
            
            // 将截图去掉
            [leftView removeFromSuperview];
            [rightView removeFromSuperview];
        }
    }];
}



#pragma mark - Privite Method
- (void)clickBlank:(UITapGestureRecognizer *)gesture
{
    [gesture.currentViewController dismissViewControllerAnimated:YES completion:nil];
}


@end
