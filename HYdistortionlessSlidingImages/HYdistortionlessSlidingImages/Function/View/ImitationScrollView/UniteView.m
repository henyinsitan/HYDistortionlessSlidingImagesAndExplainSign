//
//  UniteView.m
//  XHSImitationScrollDemo
//
//  Created by henyinsitan on 16/11/29.
//  Copyright © 2016年 刘梦翔. All rights reserved.
//

#import "UniteView.h"

@interface UniteView()

@property (nonatomic, strong) ImgModel *model;

@end

@implementation UniteView

- (instancetype)initWithModel:(ImgModel *)model {
    self = [super init];
    if (self) {
        self.model = model;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [self loadSubViews];
    }
    return self;
}

- (void)loadSubViews {
    self.imgV = [[XHSImgView alloc] initWithModel:_model];
    [self addSubview:self.imgV];
    //所有图片初始都是靠左约束，关键逻辑是滑动过程中约束靠左或靠右的变化
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.imgV attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.imgV attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    _leftConstraint = [NSLayoutConstraint constraintWithItem:self.imgV attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    _rightConstraint = [NSLayoutConstraint constraintWithItem:self.imgV attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    
    [self addConstraints:@[topConstraint, bottomConstraint, _leftConstraint]];
}

@end
