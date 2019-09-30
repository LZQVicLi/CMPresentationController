//
//  UIViewController+CMPresentation.m
//  CMPresentationController
//
//  Created by Liziqiang on 2019/9/29.
//  Copyright © 2019 Liziqiang. All rights reserved.
//

#import "UIViewController+CMPresentation.h"
#import <objc/runtime.h>
#import "CMPresentationTransitionDelegate.h"
@implementation UIViewController (CMPresentation)
- (void)setCMControllerHeight:(CGFloat)CMControllerHeight{
    objc_setAssociatedObject(self, @"CMControllerHeight", @(CMControllerHeight), OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)CMControllerHeight {
    return [objc_getAssociatedObject(self, @"CMControllerHeight") floatValue];
}

- (void)setCMTransitionDelegate:(CMPresentationTransitionDelegate *)delegate{
    objc_setAssociatedObject(self, @"CMTransitionDelegate", delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CMPresentationTransitionDelegate *)CMTransitionDelegate{
    return objc_getAssociatedObject(self, @"CMTransitionDelegate");
    
}

- (void)CMmodal:(UIViewController *)vc controllerHeight:(CGFloat)controllerHeight {
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.CMControllerHeight = controllerHeight;
    CMPresentationTransitionDelegate <UIViewControllerTransitioningDelegate>*manager = [[CMPresentationTransitionDelegate alloc]initWithPresentedViewController:vc presentingViewController:self];
    vc.CMTransitionDelegate = manager;
    vc.transitioningDelegate = manager;
    [self presentViewController:vc animated:YES completion:nil];
}
@end
