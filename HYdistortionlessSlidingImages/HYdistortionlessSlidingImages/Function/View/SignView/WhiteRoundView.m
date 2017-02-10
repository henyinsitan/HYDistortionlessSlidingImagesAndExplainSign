//
//  WhiteRoundView.m
//  HYdistortionlessSlidingImages
//
//  Created by henyinsitan on 16/12/6.
//  Copyright © 2016年 刘梦翔. All rights reserved.
//

#import "WhiteRoundView.h"

#define whiteWidth 4.5f

@interface WhiteRoundView ()<CAAnimationDelegate>

@end

@implementation WhiteRoundView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //这里y坐标不是0而是3左右不懂为啥 ！！！
        UIBezierPath *backgroundPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 3, kRoundViewSize, kRoundViewSize) cornerRadius:kRoundViewSize / 2];
        //设置外圈阴影, 制造透明效果
        self.layer.shadowPath = backgroundPath.CGPath;
        self.layer.shadowOpacity = 0.3;
        self.layer.shadowRadius = 0;
        self.layer.shadowColor = [UIColor grayColor].CGColor;
        self.hidden = YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    //画白实心圆
    CGContextRef ref = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.w / 2, self.h / 2) radius:whiteWidth startAngle:0.f endAngle:M_PI * 2 clockwise:YES];
    [[UIColor whiteColor] set];
    CGContextAddPath(ref, path.CGPath);
    CGContextFillPath(ref);
}

- (void)runAnimation:(roundViewCompleteAnimation)block{
    self.hidden = NO;
    _roudViewCompleteAnimationBlock = block;
    //先放大再缩小再放大实现弹性动画
    CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    expandAnimation.duration = 0.2f;
    expandAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    expandAnimation.toValue = [NSNumber numberWithFloat:1.8f];
    expandAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *narrowAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    narrowAnimation.beginTime = 0.2f;
    narrowAnimation.fromValue = [NSNumber numberWithFloat:1.8f];
    narrowAnimation.duration = 0.15f;
    narrowAnimation.toValue = [NSNumber numberWithFloat:0.9f];
    narrowAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    shakeAnimation.beginTime = 0.35f;
    shakeAnimation.fromValue = [NSNumber numberWithFloat:0.8f];
    shakeAnimation.duration = 0.1f;
    shakeAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    shakeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.removedOnCompletion=NO;
    groups.fillMode=kCAFillModeForwards;
    groups.delegate = self;
    groups.animations = @[expandAnimation, narrowAnimation, shakeAnimation];
    groups.duration = 0.45f;
    [self.layer addAnimation:groups forKey:@"group"];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //动画完成用block通知
    _roudViewCompleteAnimationBlock();
    
}

@end
