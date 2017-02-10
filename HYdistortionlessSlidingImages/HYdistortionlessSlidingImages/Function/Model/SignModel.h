//
//  SignModel.h
//  HYdistortionlessSlidingImages
//
//  Created by henyinsitan on 16/12/7.
//  Copyright © 2016年 刘梦翔. All rights reserved.
//  XHSSignView所用model

#import <Foundation/Foundation.h>

@interface SignModel : NSObject

/**
 标签位置(location.x代表标签白点中心位置x坐标与父视图宽的比例，loacation.y代表标签白点中心位置y坐标与父视图高的比例)
 */
@property (nonatomic, assign) CGPoint loaction;
/**
 标签内容数组
 */
@property (nonatomic, strong) NSArray *infoArray;

@end
