//
//  CMInteractionController.m
//  CMPresentationController
//
//  Created by Liziqiang on 2019/9/30.
//  Copyright © 2019 Liziqiang. All rights reserved.
//

#import "CMInteractionController.h"

@interface CMInteractionController()
@property (nonatomic,weak) UIViewController *controller;
@end


@implementation CMInteractionController
/*更新转场进度，进度数值范围为0.0~1.0。*/
//- (void)updateInteractiveTransition:(CGFloat)percentComplete;
/*取消转场，转场动画从当前状态返回至转场发生前的状态。*/
//- (void)cancelInteractiveTransition;
/*完成转场，转场动画从当前状态继续直至结束。*/
//- (void)finishInteractiveTransition;

- (void)dealloc{
    NSLog( @"%@", NSStringFromClass([self class]));
}

- (instancetype)initWithController:(UIViewController *)controller{
    self = [super init];
    if (self) {
        _isStart = NO;
        _controller = controller;
        [self addGesture];
    }
    return self;
}

- (void)addGesture{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
    [_controller.view addGestureRecognizer:pan];
}

- (void)panGesture:(UIPanGestureRecognizer *)recognizer{
//    CGPoint point = [recognizer locationInView:recognizer.view];
    
    CGPoint currentPoint = [recognizer translationInView:recognizer.view];
    CGFloat progress = currentPoint.y/_controller.CMControllerHeight;
    progress = MIN(1, MAX(0, progress));
    //       NSLog(@"%@",NSStringFromCGPoint(currentPoint));
    NSLog(@"%ld", recognizer.state);
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        _isStart = YES;
        [_controller dismissViewControllerAnimated:YES completion:NULL];
        
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        [self updateInteractiveTransition:progress];
        
    }else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled){
        _isStart = NO;
        if (progress > 0.5) {
            [self finishInteractiveTransition];
        }else{
            [self cancelInteractiveTransition];
        }
    }
}


@end
