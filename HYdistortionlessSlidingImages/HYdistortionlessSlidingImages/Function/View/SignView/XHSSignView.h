//
//  XHSSignView.h
//  HYdistortionlessSlidingImages
//
//  Created by henyinsitan on 16/12/6.
//  Copyright © 2016年 刘梦翔. All rights reserved.
//  整个标签父视图

#import <UIKit/UIKit.h>
#import "SignModel.h"

typedef void(^CompleteBlock)();

@interface XHSSignView : UIView

- (instancetype)initWithModel:(SignModel *)model;

- (void)runAnimation:(CompleteBlock)block;

@end
