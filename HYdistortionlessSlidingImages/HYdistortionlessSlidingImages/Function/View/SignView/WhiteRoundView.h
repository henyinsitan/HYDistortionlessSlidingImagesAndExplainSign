//
//  WhiteRoundView.h
//  HYdistortionlessSlidingImages
//
//  Created by henyinsitan on 16/12/6.
//  Copyright © 2016年 刘梦翔. All rights reserved.
//  标签原白点

#import <UIKit/UIKit.h>

typedef void(^roundViewCompleteAnimation)();

@interface WhiteRoundView : UIView

@property (nonatomic, strong) roundViewCompleteAnimation roudViewCompleteAnimationBlock;

- (void)runAnimation:(roundViewCompleteAnimation)block;

@end
