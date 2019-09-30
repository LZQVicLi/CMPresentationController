//
//  CMAnimationController.h
//  CMPresentationController
//
//  Created by Liziqiang on 2019/9/30.
//  Copyright © 2019 Liziqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,CMAnimationType) {
    AnimationTypePresent=0,
    AnimationTypeDissmiss,
};

@interface CMAnimationController : NSObject<UIViewControllerAnimatedTransitioning>
- (instancetype)initWithType:(CMAnimationType)type;

@end

NS_ASSUME_NONNULL_END
