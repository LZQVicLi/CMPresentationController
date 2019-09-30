//
//  CMPresentationTransitionDelegate.h
//  CMPresentationController
//
//  Created by Liziqiang on 2019/9/30.
//  Copyright © 2019 Liziqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CMPresentationTransitionDelegate : NSObject<UIViewControllerTransitioningDelegate>
- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController;

@end

NS_ASSUME_NONNULL_END
