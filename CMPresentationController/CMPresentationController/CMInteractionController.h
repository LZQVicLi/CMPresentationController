//
//  CMInteractionController.h
//  CMPresentationController
//
//  Created by Liziqiang on 2019/9/30.
//  Copyright © 2019 Liziqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+CMPresentation.h"
NS_ASSUME_NONNULL_BEGIN

@interface CMInteractionController : UIPercentDrivenInteractiveTransition<UIViewControllerInteractiveTransitioning>
- (instancetype)initWithController:(UIViewController *)controller;
@property (nonatomic,assign) BOOL isStart;
@end

NS_ASSUME_NONNULL_END
