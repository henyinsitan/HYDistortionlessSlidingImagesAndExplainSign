//
//  InfoLabel.h
//  HYdistortionlessSlidingImages
//
//  Created by henyinsitan on 16/12/7.
//  Copyright © 2016年 刘梦翔. All rights reserved.
//  标签label

#import <UIKit/UIKit.h>

typedef void(^completeBlock)();

@interface InfoLabel : UILabel

- (void)fadeIn:(completeBlock)block;

- (void)fadeOut:(completeBlock)block;

@end
