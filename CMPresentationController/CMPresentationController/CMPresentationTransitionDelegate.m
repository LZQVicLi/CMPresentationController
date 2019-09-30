//
//  CMPresentationTransitionDelegate.m
//  CMPresentationController
//
//  Created by Liziqiang on 2019/9/30.
//  Copyright © 2019 Liziqiang. All rights reserved.
//

#import "CMPresentationTransitionDelegate.h"
#import "CMPresentationController.h"
#import "CMAnimationController.h"
#import "CMInteractionController.h"
@interface CMPresentationTransitionDelegate()
@property (nonatomic,strong) CMInteractionController *interactionController;
@end

@implementation CMPresentationTransitionDelegate
- (void)dealloc{
    NSLog( @"%@", NSStringFromClass([self class]));
}

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController{
    self = [super init];
    if(self){
        _interactionController = [[CMInteractionController alloc]initWithController:presentedViewController];
    }
    return self;
}

#pragma  mark -UIViewControllerTransitioningDelegate
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return [[CMPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}


- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [[CMAnimationController alloc]initWithType:AnimationTypePresent];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [[CMAnimationController alloc]initWithType:AnimationTypeDissmiss];
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator{
    return nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    // 如果直接返回 interactive 会与系统的 dismiss 动画有冲突，导致点击 button 无法 dismiss 界面。
    // 同时如果返回  interactiveAnimator，那么 animationControllerForDismissedController: 则必须实现
    return self.interactionController.isStart? self.interactionController: nil;
    
}


@end
