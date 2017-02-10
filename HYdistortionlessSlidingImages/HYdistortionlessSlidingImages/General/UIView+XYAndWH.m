//
//  UIView+XYAndWH.m
//  LMX_FrameWork
//
//  Created by henyinsitan on 15/5/22.
//  Copyright (c) 2015年 刘梦翔. All rights reserved.
//

#import "UIView+XYAndWH.h"

@implementation UIView (XYAndWH)
- (CGFloat)endY {
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)endX {
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)X {
    return self.frame.origin.x;
}
- (CGFloat)x {
    return self.X;
}

- (CGFloat)Y {
    return self.frame.origin.y;
}
- (CGFloat)y {
    return self.Y;
}

- (CGFloat)H {
    return self.frame.size.height;
}

- (CGFloat)h {
    return self.H;
}

- (CGFloat)W {
    return self.frame.size.width;
}

- (CGFloat)w {
    return self.W;
}

- (CGSize)size{
    CGRect frame = [self frame];
    return frame.size;
}

- (void)setW:(float)width
{
    CGRect frame = [self frame];
    frame.size.width = round(width);
    [self setFrame:frame];
}
- (void)setH:(float)height{
    CGRect frame = [self frame];
    frame.size.height = round(height);
    [self setFrame:frame];
}

- (void)setW:(float)width andH:(float)height
{
    [self setWH:CGSizeMake(width, height)];
}

- (void)setWH:(CGSize)size
{
    CGRect frame = [self frame];
    frame.size.width = round(size.width);
    frame.size.height = round(size.height);
    [self setFrame:frame];
    
}

- (void)addW:(float)width
{
    CGRect frame = [self frame];
    frame.size.width += width;
    [self setFrame:frame];
}

- (void)addH:(float)height
{
    CGRect frame = [self frame];
    frame.size.height += height;
    [self setFrame:frame];
}

- (void)addW:(float)width andH:(float)height
{
    CGRect frame = [self frame];
    frame.size.height += height;
    frame.size.width += width;
    [self setFrame:frame];
}

- (void)setX:(float)x
{
    [self setX:x andY:self.frame.origin.y];
}

- (void)setY:(float)y
{
    [self setX:self.frame.origin.x andY:y];
}

- (void)setX:(float)x andY:(float)y
{
    CGRect frame = [self frame];
    frame.origin.x = round(x);
    frame.origin.y = round(y);
    [self setFrame:frame];
}

- (void)setXY:(CGPoint)point
{
    [self setX:point.x andY:point.y];

}

- (void)setPositionCenteredOnPoint:(CGPoint)position{
    [self setX:(position.x - self.frame.size.width / 2) andY:(position.y - self.frame.size.height / 2)];
}

- (void)addX:(float)x
{
    CGRect frame = [self frame];
    frame.origin.x += x;
    [self setFrame:frame];
}
- (void)addY:(float)y{
    CGRect frame = [self frame];
    frame.origin.y += y;
    [self setFrame:frame];
}

- (void)addX:(float)x andY:(float)y
{
    CGRect frame = [self frame];
    frame.origin.y += y;
    frame.origin.x += x;
    [self setFrame:frame];
}
@end
