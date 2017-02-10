//
//  UniteView.h
//  XHSImitationScrollDemo
//
//  Created by henyinsitan on 16/11/29.
//  Copyright © 2016年 刘梦翔. All rights reserved.
//  XHSImitationScrollView的单元View

#import <UIKit/UIKit.h>
#import "XHSImgView.h"
#import "ImgModel.h"

@interface UniteView : UIView

@property (nonatomic, strong) XHSImgView *imgV;
@property (nonatomic, strong) NSLayoutConstraint *leftConstraint;
@property (nonatomic, strong) NSLayoutConstraint *rightConstraint;

- (instancetype)initWithModel:(ImgModel *)model;

@end
