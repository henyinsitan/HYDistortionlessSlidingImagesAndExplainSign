//
//  XHSImgView.m
//  XHSImitationScrollDemo
//
//  Created by henyinsitan on 16/11/29.
//  Copyright © 2016年 刘梦翔. All rights reserved.
//

#import "XHSImgView.h"
#import "XHSSignView.h"
#import "SignModel.h"

@interface XHSImgView () 

@property (nonatomic, strong) ImgModel *model;
@property (nonatomic, strong) NSMutableArray *signViewArray;

@end

@implementation XHSImgView

- (instancetype)initWithModel:(ImgModel *)model {
    self = [super init];
    if (self) {
        self.signViewArray = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor lightGrayColor];
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.userInteractionEnabled = YES;
        self.model = model;
        //超出部分不显示
        self.layer.masksToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setModel:(ImgModel *)model {
    _model = model;
    //自身宽高比约束
    NSLayoutConstraint *aseptConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:_model.width / _model.height constant:0];
    [self addConstraint:aseptConstraint];
    [self loadSubViews];
}

- (void)loadSubViews {
    for (SignModel *signModel in _model.signInfoArray) {
        XHSSignView *signView = [[XHSSignView alloc] initWithModel:signModel];
        [self addSubview:signView];
        [_signViewArray addObject:signView];
        //X轴比例约束
        NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:signView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:signModel.loaction.y constant:0];
        if (signModel.loaction.x <= 0.5) {//标签朝右
            NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:signView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:signModel.loaction.x constant:0];
             [self addConstraints:@[leftConstraint, centerYConstraint]];
        } else {//标签朝左
            NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:signView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:signModel.loaction.x constant:0];
            [self addConstraints:@[rightConstraint, centerYConstraint]];
        }
    }
}

- (void)tapAction:(UITapGestureRecognizer *)sender {
    //动画开始时不能再触发点击手势了
    self.userInteractionEnabled = NO;
    for (XHSSignView *signView in _signViewArray) {
        [signView runAnimation:^{
            //动画完成后能触发点击手势了
            self.userInteractionEnabled = YES;
        }];
    }
}



@end
