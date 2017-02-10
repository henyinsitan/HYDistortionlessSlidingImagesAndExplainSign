//
//  PageLabel.m
//  XHSImitationScrollDemo
//
//  Created by henyinsitan on 16/12/1.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import "PageLabel.h"

@implementation PageLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textColor = [UIColor whiteColor];
        self.font = [UIFont systemFontOfSize:14.f];
        self.textAlignment = NSTextAlignmentRight;
    }
    return self;
}

@end
