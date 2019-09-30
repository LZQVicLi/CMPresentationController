//
//  CMPresentationController.m
//  CMPresentationController
//
//  Created by Liziqiang on 2019/9/29.
//  Copyright © 2019 Liziqiang. All rights reserved.
//

#import "CMPresentationController.h"

@interface CMPresentationController()

@property (nonatomic,strong) UIView *dimmingView;
@property (nonatomic,strong) UIView *presentedWrapView;
@property (assign, nonatomic) CGFloat controllerHeight;

@end

@implementation CMPresentationController
- (void)dealloc{
    NSLog( @"%@", NSStringFromClass([self class]));
}

//初始化方法
- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController{
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if (self) {
        //必须是`UIModalPresentationCustom`类型
        presentedViewController.modalPresentationStyle = UIModalPresentationCustom;
        _controllerHeight = presentedViewController.CMControllerHeight == 0 ? [UIScreen mainScreen].bounds.size.height : presentedViewController.CMControllerHeight;
        
    }
    return self;
    
}

#pragma mark - Private Menthod

/*返回动画结束后的`presented view`的frame*/
- (CGRect)frameOfPresentedViewInContainerView{
    return CGRectMake(0, [UIScreen mainScreen].bounds.size.height-_controllerHeight, [UIScreen mainScreen].bounds.size.width, _controllerHeight);
}
/*返回动画结束后的`presented view`的frame*/
- (BOOL)shouldRemovePresentersView{
    return NO;
}
/*提供给动画控制器使用的视图，默认返回 presentedVC.view，通过重写该方法返回其他视图，但一定要是 presentedVC.view 的上层视图。对 presentedView 的外观进行定制。*/
- (UIView *)presentedView{
    return self.presentedWrapView;
}

//重写此方法可以在弹框即将显示时执行所需要的操作
//接访问动画控制器与转场过程同步,转场协调器(Transition Coordinator)。该对象可通过UIViewController 的transitionCoordinator()方法获取
/*与动画控制器中的转场动画同步，执行其他动画*/
//- (BOOL)animateAlongsideTransition:(void (^ __nullable)(id <UIViewControllerTransitionCoordinatorContext>context))animation completion:(void (^ __nullable)(id <UIViewControllerTransitionCoordinatorContext>context))completion;
/*与动画控制器中的转场动画同步，在指定的视图内执行动画*/
//- (BOOL)animateAlongsideTransitionInView:(nullable UIView *)view animation:(void (^ __nullable)(id <UIViewControllerTransitionCoordinatorContext>context))animation completion:(void (^ __nullable)(id <UIViewControllerTransitionCoordinatorContext>context))completion;

- (void)presentationTransitionWillBegin{
    [self.containerView addSubview:self.dimmingView];
    self.dimmingView.alpha = 0;
    [self.presentingViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 0.5;
        self.presentingViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.92, 0.92);
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];
    
}

//重写此方法可以在弹框显示完毕时执行所需要的操作
- (void)presentationTransitionDidEnd:(BOOL)completed{
    if(!completed){
        [self.dimmingView removeFromSuperview];
    }
}

//重写此方法可以在弹框即将消失时执行所需要的操作
- (void)dismissalTransitionWillBegin{
    self.dimmingView.alpha = 0.5;
    [self.presentingViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 0;
        self.presentingViewController.view.transform = CGAffineTransformIdentity;
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
    }];
}

//重写此方法可以在弹框消失之后执行所需要的操作
- (void)dismissalTransitionDidEnd:(BOOL)completed{
    if (completed) {
        [self.dimmingView removeFromSuperview];
    }
}

#pragma mark - Setter && Getter
- (UIView *)dimmingView{
    if (!_dimmingView) {
        _dimmingView = [[UIView alloc]initWithFrame:self.containerView.bounds];
        _dimmingView.backgroundColor = [UIColor blackColor];
        _dimmingView.alpha = 0;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapDissmiss:)];
        [_dimmingView addGestureRecognizer:gesture];
    }
    return _dimmingView;
}

- (UIView *)presentedWrapView{
    if (!_presentedWrapView) {
        _presentedWrapView = [[UIView alloc]initWithFrame:self.frameOfPresentedViewInContainerView];
        UIView *presentedViewControllerView = [super presentedView];
        presentedViewControllerView.frame = _presentedWrapView.bounds;
        [_presentedWrapView addSubview:presentedViewControllerView];
    }
    return _presentedWrapView;
}

#pragma mark - Event Response
- (void)tapDissmiss:(UITapGestureRecognizer *)recognizer{
    CGPoint point = [recognizer locationInView:self.dimmingView];
    if (!CGRectContainsPoint([self frameOfPresentedViewInContainerView], point)) {//点击区域判断
        [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
