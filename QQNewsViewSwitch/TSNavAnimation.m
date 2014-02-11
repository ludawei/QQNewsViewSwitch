//
//  TSNavAnimation.m
//  Test
//
//  Created by ludawei on 14-2-10.
//  Copyright (c) 2014年 ludawei. All rights reserved.
//

#import "TSNavAnimation.h"

#define screenWidth [UIScreen mainScreen].bounds.size.width

@implementation TsNavAnimation

-(void)modifyFrameXwithView:(UIView *)view value:(float)value
{
    CGRect frame = view.frame;
    frame.origin.x = value;
    view.frame = frame;
}

#pragma mark - UIViewControllerAnimatedTransitioning

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    NSAssert(NO, @"animateTransition: should be handled by subclass of BaseAnimation");
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.0;
}

@end

@implementation TSPushNavAnimation

#pragma mark - Animated Transitioning

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    //Get references to the view hierarchy
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //Take a snapshot of the 'from' view
    UIView *fromSnapshot = [fromViewController.view snapshotViewAfterScreenUpdates:NO];
    fromSnapshot.frame = fromViewController.view.frame;
    [containerView insertSubview:fromSnapshot aboveSubview:fromViewController.view];
    [fromViewController.view removeFromSuperview];
    
    //Add the 'to' view to the hierarchy
    toViewController.view.frame = fromSnapshot.frame;
    [self modifyFrameXwithView:toViewController.view value:screenWidth];
//    [containerView insertSubview:toViewController.view belowSubview:fromSnapshot];
    [containerView addSubview:toViewController.view];
    
    //Animate using keyframe animations
    [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:0 animations:^{
        
        //Apply z-index translations to make the views move away from the user
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.20 animations:^{

            fromSnapshot.transform = CGAffineTransformMakeScale(0.9f, 0.9f);//将要显示的view按照正常比例显示出来
            fromSnapshot.alpha = 0.7;
            
            [self modifyFrameXwithView:toViewController.view value:0];
        }];
        
        //Move the 'to' view to its final position
        [UIView addKeyframeWithRelativeStartTime:0.80 relativeDuration:0.20 animations:^{
            toViewController.view.layer.transform = CATransform3DIdentity;
        }];
    } completion:^(BOOL finished) {
        [fromSnapshot removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.3;
}

@end

@implementation TSPopNavAnimation

#pragma mark - Animated Transitioning

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    //Get references to the view hierarchy
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //Take a snapshot of the 'from' view
    UIView *fromSnapshot = [fromViewController.view snapshotViewAfterScreenUpdates:NO];
    fromSnapshot.frame = fromViewController.view.frame;
    [containerView insertSubview:fromSnapshot aboveSubview:fromViewController.view];
    [fromViewController.view removeFromSuperview];
    
    //Add the 'to' view to the hierarchy
    toViewController.view.frame = fromSnapshot.frame;
    toViewController.view.transform = CGAffineTransformMakeScale(0.9f, 0.9f);
    toViewController.view.alpha = 0.7;
    [containerView insertSubview:toViewController.view belowSubview:fromSnapshot];
    
    //Animate using keyframe animations
    [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:0 animations:^{
        
        //Apply z-index translations to make the views move away from the user
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.20 animations:^{
            
            [self modifyFrameXwithView:fromSnapshot value:screenWidth];
            
            toViewController.view.transform = CGAffineTransformMakeScale(1.0f, 1.0f);//将要显示的view按照正常比例显示出来
            toViewController.view.alpha = 1.0;
        }];

        //Move the 'to' view to its final position
        [UIView addKeyframeWithRelativeStartTime:0.80 relativeDuration:0.20 animations:^{
            toViewController.view.layer.transform = CATransform3DIdentity;
        }];
    } completion:^(BOOL finished) {
        [fromSnapshot removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.3;
}


@end
