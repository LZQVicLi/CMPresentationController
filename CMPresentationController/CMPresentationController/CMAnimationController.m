//
//  CMAnimationController.m
//  CMPresentationController
//
//  Created by Liziqiang on 2019/9/30.
//  Copyright © 2019 Liziqiang. All rights reserved.
//

#import "CMAnimationController.h"
@interface CMAnimationController()
@property (nonatomic,assign) CMAnimationType type;
@end

@implementation CMAnimationController
- (void)dealloc{
    NSLog( @"%@", NSStringFromClass([self class]));
}

#pragma mark - Init Menthod
- (instancetype)initWithType:(CMAnimationType)type{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}


/*返回动画执行时间，一般0.5s就足够了*/
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

/*核心方法，做一些动画相关的操作*/
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    UIView *fromView;
    UIView *toView;
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    }else{
        fromView = fromVC.view;
        toView = toVC.view;
    }
    
    CGRect fromViewFrame = [transitionContext initialFrameForViewController:fromVC];
    CGRect toViewFrame = [transitionContext finalFrameForViewController:toVC];
    
    /*进行动画*/
    if (_type == AnimationTypePresent) {
        CGRect orginalFrame = CGRectZero;
        orginalFrame.origin = CGPointMake(CGRectGetMinX(containerView.bounds), CGRectGetMaxY(containerView.bounds));
        orginalFrame.size = toViewFrame.size;
        toView.frame = orginalFrame;
        [containerView addSubview:toView];
    }else if (_type == AnimationTypeDissmiss){
        fromViewFrame = CGRectOffset(fromViewFrame, 0, CGRectGetHeight(containerView.bounds));
    }
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        if (self.type == AnimationTypePresent) {
            toView.frame = toViewFrame;
        }else if (self.type == AnimationTypeDissmiss){
            fromView.frame = fromViewFrame;
        }
    } completion:^(BOOL finished) {
        /*告诉系统动画结束*/
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
