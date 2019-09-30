//
//  UIViewController+CMPresentation.h
//  CMPresentationController
//
//  Created by Liziqiang on 2019/9/29.
//  Copyright © 2019 Liziqiang. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (CMPresentation)<UIViewControllerTransitioningDelegate>
 @property (assign, nonatomic) CGFloat CMControllerHeight;

 - (void)CMmodal:(UIViewController *)vc controllerHeight:(CGFloat)controllerHeight;
@end

NS_ASSUME_NONNULL_END
