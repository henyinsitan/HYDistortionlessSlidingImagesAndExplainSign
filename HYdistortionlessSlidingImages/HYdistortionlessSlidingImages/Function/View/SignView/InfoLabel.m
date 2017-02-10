//
//  InfoLabel.m
//  HYdistortionlessSlidingImages
//
//  Created by henyinsitan on 16/12/7.
//  Copyright © 2016年 刘梦翔. All rights reserved.
//

#import "InfoLabel.h"

@interface InfoLabel ()<CAAnimationDelegate>

@property (nonatomic, strong) completeBlock block;

@end

@implementation InfoLabel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.textColor = [UIColor whiteColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:13.f];
        self.layer.opacity = 0.0f;
    }
    return self;
}


/**
渐显动画
 */
- (void)fadeIn:(completeBlock)block {
    _block = block;
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:1.0];
    opacityAnimation.duration = 0.2f;
    opacityAnimation.delegate = self;
    // 动画终了后不返回初始状态
    opacityAnimation.removedOnCompletion = NO;
    opacityAnimation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:opacityAnimation forKey:@"opacity"];
}


/**
 渐失动画
 */
- (void)fadeOut:(completeBlock)block {
    _block = block;
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.0];
    opacityAnimation.duration = 0.2f;
    opacityAnimation.delegate = self;
    // 动画终了后不返回初始状态
    opacityAnimation.removedOnCompletion = NO;
    opacityAnimation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:opacityAnimation forKey:@"opacity"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    _block();
}

@end
