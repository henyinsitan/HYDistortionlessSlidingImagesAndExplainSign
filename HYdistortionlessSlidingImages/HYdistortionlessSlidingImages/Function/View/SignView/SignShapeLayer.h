//
//  SignShapeLayer.h
//  HYdistortionlessSlidingImages
//
//  Created by henyinsitan on 16/12/9.
//  Copyright © 2016年 刘梦翔. All rights reserved.
//  标签用于执行线条动画的CAShapeLayer

#import <QuartzCore/QuartzCore.h>

typedef void(^completeAnimation)();

@interface SignShapeLayer : CAShapeLayer

/**
 执行CAShapeLayer画线动画
 
 @param pointA    第一个点
 @param pointB    第二个点
 @param pointC    第三个点
 @param isForward 正向 = YES，逆向 = NO
 @param block 动画完成执行的block
 */
- (void)addPathAnimationPointA:(CGPoint)pointA pointB:(CGPoint)pointB pointC:(CGPoint)pointC isForward:(BOOL)isForward completeAnimation:(completeAnimation)block;

@end
