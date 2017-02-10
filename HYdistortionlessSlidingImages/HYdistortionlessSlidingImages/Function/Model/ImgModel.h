//
//  ImgModel.h
//  XHSImitationScrollDemo
//
//  Created by henyinsitan on 16/11/29.
//  Copyright © 2016年 刘梦翔. All rights reserved.
//  XHSImgView所用model

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SignModel.h"

@interface ImgModel : NSObject

@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

/**
标签信息数组
 */
@property (nonatomic, strong) NSArray<SignModel *> *signInfoArray;

@end
