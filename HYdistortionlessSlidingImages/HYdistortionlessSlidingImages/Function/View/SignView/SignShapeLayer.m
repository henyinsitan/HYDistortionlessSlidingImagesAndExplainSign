//
//  SignShapeLayer.m
//  HYdistortionlessSlidingImages
//
//  Created by henyinsitan on 16/12/9.
//  Copyright © 2016年 刘梦翔. All rights reserved.
//

#import "SignShapeLayer.h"

@interface SignShapeLayer ()<CAAnimationDelegate>

@property (nonatomic, strong) completeAnimation block;

@end

@implementation SignShapeLayer

- (instancetype)init {
    self  = [super init];
    if (self) {
        self.strokeColor = [UIColor whiteColor].CGColor;//线的颜色
        self.fillColor = [UIColor clearColor].CGColor;//填充颜色
        self.lineCap = kCALineCapButt;//线首尾的外观
        self.lineWidth = 2.0f;//线条宽度
        self.lineJoin = kCALineJoinRound;//线连接方式平滑
        //设置线条的起点比与终点 0-1之间
        self.strokeStart = 0.0f;
        self.strokeEnd = 1.0f;
    }
    return self;
}

- (void)addPathAnimationPointA:(CGPoint)pointA pointB:(CGPoint)pointB pointC:(CGPoint)pointC isForward:(BOOL)isForward completeAnimation:(completeAnimation)block{
    _block = block;
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:pointA];
    [path addLineToPoint:pointB];
    [path addLineToPoint:pointC];
    self.path = path.CGPath;//从贝塞尔曲线获取到形状
    //点一到点二的距离
    CGFloat lengthA = sqrt((pointB.y - pointA.y)*(pointB.y - pointA.y) + (pointB.x - pointA.x)*(pointB.x - pointA.x));
    //点二到点三的距离
    CGFloat lengthB = sqrt((pointC.y - pointB.y)*(pointC.y - pointB.y) + (pointC.x - pointB.x)*(pointC.x - pointB.x));
    //第一条线段占两条线段总长的比例
    CGFloat scale = lengthA / (lengthA + lengthB);
    //给这个layer添加动画效果
    CABasicAnimation *pathStepOne = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    CABasicAnimation *pathStepTwo = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    CABasicAnimation *pathStepThree = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    if (isForward) {//正向动画
        pathStepOne.beginTime = 0;
        pathStepOne.duration = 0.1;
        pathStepOne.fromValue = [NSNumber numberWithFloat:0.0f];
        pathStepOne.toValue = [NSNumber numberWithFloat:scale];
        
        pathStepTwo.beginTime = 0.1;
        pathStepTwo.duration = 0.2;
        pathStepTwo.fromValue = [NSNumber numberWithFloat:scale];
        pathStepTwo.toValue = [NSNumber numberWithFloat:scale];
        
        pathStepThree.duration = 0.1;
        pathStepThree.beginTime = 0.3;
        pathStepThree.fromValue = [NSNumber numberWithFloat:scale];
        pathStepThree.toValue = [NSNumber numberWithFloat:1.0f];
    } else {//逆向动画
        pathStepOne.beginTime = 0;
        pathStepOne.duration = 0.1;
        pathStepOne.fromValue = [NSNumber numberWithFloat:1.0f];
        pathStepOne.toValue = [NSNumber numberWithFloat:scale];
        
        pathStepTwo.beginTime = 0.1;
        pathStepTwo.duration = 0.2;
        pathStepTwo.fromValue = [NSNumber numberWithFloat:scale];
        pathStepTwo.toValue = [NSNumber numberWithFloat:scale];
        
        pathStepThree.duration = 0.1;
        pathStepThree.beginTime = 0.3;
        pathStepThree.fromValue = [NSNumber numberWithFloat:scale];
        pathStepThree.toValue = [NSNumber numberWithFloat:0.0f];
    }
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[pathStepOne, pathStepTwo, pathStepThree];
    groups.duration = 0.4f;
    groups.removedOnCompletion=NO;
    groups.fillMode=kCAFillModeForwards;
    groups.delegate = self;
    [self addAnimation:groups forKey:@"LineAnimation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    _block();
}

@end
