//
//  XHSSignView.m
//  HYdistortionlessSlidingImages
//
//  Created by henyinsitan on 16/12/6.
//  Copyright © 2016年 刘梦翔. All rights reserved.
//

#import "XHSSignView.h"
#import "InfoLabel.h"
#import "WhiteRoundView.h"
#import "SignShapeLayer.h"

@interface XHSSignView ()

@property (nonatomic, strong) WhiteRoundView *roundView;

@property (nonatomic, strong) InfoLabel *centerLabel;
@property (nonatomic, strong) InfoLabel *topLabel;
@property (nonatomic, strong) InfoLabel *bottomLabel;

@property (nonatomic, strong) SignShapeLayer *shapeLayerCenter;
@property (nonatomic, strong) SignShapeLayer *shapeLayerTop;
@property (nonatomic, strong) SignShapeLayer *shapeLayerBottom;

@property (nonatomic, strong) CompleteBlock block;
@property (nonatomic, strong) SignModel *model;


/**
 默认 = NO， YES代表标签已经显示出来了
 */
@property (nonatomic, assign) BOOL signShow;

@end

@implementation XHSSignView

- (instancetype)initWithModel:(SignModel *)model{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.translatesAutoresizingMaskIntoConstraints = NO;
        //定宽约束
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:kScreenWidth];
        [self addConstraint:widthConstraint];
        //定高约束
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:kSignViewHeight];
        [self addConstraint:heightConstraint];
        
        self.model = model;
        if (model && model.infoArray && model.infoArray.count > 0) {
            [self loadSubViews];
            [self loadShapLayer];
        }
    }
    return self;
}

- (void)loadShapLayer {
    switch (_model.infoArray.count) {
        case 1:
        {
            _shapeLayerCenter = [[SignShapeLayer alloc] init];
            [self.layer addSublayer:_shapeLayerCenter];
        }
            break;
            
        case 2:
        {
            _shapeLayerTop = [[SignShapeLayer alloc] init];
            _shapeLayerBottom = [[SignShapeLayer alloc] init];
            [self.layer addSublayer:_shapeLayerTop];
            [self.layer addSublayer:_shapeLayerBottom];
        }
            break;
            
        case 3:
        {
            _shapeLayerCenter = [[SignShapeLayer alloc] init];
            _shapeLayerTop = [[SignShapeLayer alloc] init];
            _shapeLayerBottom = [[SignShapeLayer alloc] init];
            [self.layer addSublayer:_shapeLayerCenter];
            [self.layer addSublayer:_shapeLayerTop];
            [self.layer addSublayer:_shapeLayerBottom];
        }
            break;
            
        default:
            break;
    }
}

- (void)loadSubViews {
    switch (_model.infoArray.count) {
        case 1:
        {
            _centerLabel = [[InfoLabel alloc] init];
            [self addSubview:_centerLabel];
            _centerLabel.text = _model.infoArray[0];
            [_centerLabel sizeToFit];
        }
            break;
            
        case 2:
        {
            //topLabel
            _topLabel = [[InfoLabel alloc] init];
            [self addSubview:_topLabel];
            _topLabel.text = _model.infoArray[0];
            [_topLabel sizeToFit];
           
            //bottomLabel
            _bottomLabel = [[InfoLabel alloc] init];
            [self addSubview:_bottomLabel];
            _bottomLabel.text = _model.infoArray[1];
            [_bottomLabel sizeToFit];
        }
            break;
            
        case 3:
        {
            //topLabel
            _topLabel = [[InfoLabel alloc] init];
            [self addSubview:_topLabel];
            _topLabel.text = _model.infoArray[0];
            [_topLabel sizeToFit];
           
            //centerLabel
            _centerLabel = [[InfoLabel alloc] init];
            [self addSubview:_centerLabel];
            _centerLabel.text = _model.infoArray[1];
            [_centerLabel sizeToFit];
            
            //bottomLabel
            _bottomLabel = [[InfoLabel alloc] init];
            [self addSubview:_bottomLabel];
            _bottomLabel.text = _model.infoArray[2];
            [_bottomLabel sizeToFit];
        }
            break;
            
        default:
            break;
    }
    
    //添加白圆点
    _roundView = [[WhiteRoundView alloc] initWithFrame:CGRectMake(NSNotFound, NSNotFound, kRoundViewSize, kRoundViewSize)];
    [self addSubview:_roundView];
   
}


/**
 用了约束，在layoutSuviews方法里能获取父视图的frame
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutIfNeeded];
    
    if (_model.loaction.x <= 0.5) {//朝向左
        switch (_model.infoArray.count) {
            case 1:
            {
                 _centerLabel.frame = CGRectMake(kChangeLineFirstAnimationWidth, kSignViewHeight / 2 - _centerLabel.h - 3, _centerLabel.w, _centerLabel.H);
            }
                break;
                
            case 2:
            {
                _topLabel.frame = CGRectMake(kChangeLineFirstAnimationWidth, kSignViewHeight / 2 - _topLabel.h - kSignTwoLineSpace - 3, _topLabel.w, _topLabel.H);
                _bottomLabel.frame = CGRectMake(kChangeLineFirstAnimationWidth, kSignViewHeight / 2 - _bottomLabel.h + kSignTwoLineSpace - 3, _bottomLabel.w, _bottomLabel.H);
            }
                break;
                
            case 3:
            {
                _topLabel.frame = CGRectMake(kChangeLineFirstAnimationWidth, kSignViewHeight / 2 - _topLabel.h - kSignThreeLineSpace - 3, _topLabel.w, _topLabel.H);
                _centerLabel.frame = CGRectMake(kChangeLineFirstAnimationWidth, kSignViewHeight / 2 - _centerLabel.h - 3, _centerLabel.w, _centerLabel.H);
                _bottomLabel.frame = CGRectMake(kChangeLineFirstAnimationWidth, kSignViewHeight / 2 - _bottomLabel.h + kSignThreeLineSpace - 3, _bottomLabel.w, _bottomLabel.H);
            }
                break;
                
            default:
                break;
        }
        
        //添加白圆点
        _roundView.frame = CGRectMake(-kRoundViewSize / 2, (kSignViewHeight - kRoundViewSize) / 2, kRoundViewSize, kRoundViewSize);
    } else {//朝向右
        switch (_model.infoArray.count) {
            case 1:
            {
                _centerLabel.frame = CGRectMake(self.w - (kChangeLineFirstAnimationWidth + _centerLabel.w), kSignViewHeight / 2 - _centerLabel.h - 3, _centerLabel.w, _centerLabel.H);
            }
                break;
                
            case 2:
            {
                _topLabel.frame = CGRectMake(self.w - (kChangeLineFirstAnimationWidth + _topLabel.w), kSignViewHeight / 2 - _topLabel.h - kSignTwoLineSpace - 3, _topLabel.w, _topLabel.H);
                _bottomLabel.frame = CGRectMake(self.w - (kChangeLineFirstAnimationWidth + _bottomLabel.w), kSignViewHeight / 2 - _bottomLabel.h + kSignTwoLineSpace - 3, _bottomLabel.w, _bottomLabel.H);
            }
                break;
                
            case 3:
            {
                _topLabel.frame = CGRectMake(self.w - (kChangeLineFirstAnimationWidth + _topLabel.w), kSignViewHeight / 2 - _topLabel.h - kSignThreeLineSpace - 3, _topLabel.w, _topLabel.H);
                _centerLabel.frame = CGRectMake(self.w - (kChangeLineFirstAnimationWidth + _centerLabel.w), kSignViewHeight / 2 - _centerLabel.h - 3, _centerLabel.w, _centerLabel.H);
                _bottomLabel.frame = CGRectMake(self.w - (kChangeLineFirstAnimationWidth + _bottomLabel.w), kSignViewHeight / 2 - _bottomLabel.h + kSignThreeLineSpace - 3, _bottomLabel.w, _bottomLabel.H);
            }
                break;
                
            default:
                break;
        }
        
        //添加白圆点
        _roundView.frame = CGRectMake(self.w - kRoundViewSize / 2, (kSignViewHeight - kRoundViewSize) / 2, kRoundViewSize, kRoundViewSize);
    }
}

//先执行白原点动画，然后执行线条动画
- (void)runAnimation:(CompleteBlock)block {
    _block = block;
    [_roundView runAnimation:^{
        [self lineAndLabelAnimationRun];
    }];
}

//线条动画
- (void)lineAndLabelAnimationRun {
    switch (_model.infoArray.count) {
        case 1://执行单线动画
        {
            if (!_signShow) {//动画顺序：线条增长动画 -> 文字渐显动画
                [self oneLineAnmation];
            }
            else {//文字渐失
                [_centerLabel fadeOut:^{
                }];
                //动画线条变短动画
                [self oneLineAnmation];
            }
        }
            break;
            
        case 2://顶部线条和底部线条同时执行动画
        {
            if (!_signShow) {
                [self twoLineAnimation];
            } else {
                [_topLabel fadeOut:^{
                }];
                [_bottomLabel fadeOut:^{
                }];
                [self twoLineAnimation];
            }
            
        }
            break;
            
        case 3://顶部线条，中间线条，底部线条同时执行动画
        {
            if (!_signShow) {
                [self threeLineAnimation];
            } else {
                [_topLabel fadeOut:^{
                }];
                [_centerLabel fadeOut:^{
                }];
                [_bottomLabel fadeOut:^{
                }];
                [self threeLineAnimation];
            }
        }
            break;
            
        default:
            break;
    }
}

//一个标签栏的动画
- (void)oneLineAnmation {
    CGPoint pointA;
    CGPoint pointB;
    CGPoint pointC;
    if (_model.loaction.x <= 0.5) {
        pointA = CGPointMake(0, kSignViewHeight / 2);
        pointB = CGPointMake(kChangeLineFirstAnimationWidth, kSignViewHeight / 2);
        pointC = CGPointMake(_centerLabel.w + kChangeLineFirstAnimationWidth, kSignViewHeight / 2);
    } else {
        pointA = CGPointMake(self.w, kSignViewHeight / 2);
        pointB = CGPointMake(self.w - kChangeLineFirstAnimationWidth, kSignViewHeight / 2);
        pointC = CGPointMake(self.w - (_centerLabel.w + kChangeLineFirstAnimationWidth), kSignViewHeight / 2);
    }
    
    __weak typeof(self) weakSelf = self;
    [_shapeLayerCenter addPathAnimationPointA:pointA pointB:pointB pointC:pointC isForward:!_signShow completeAnimation:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf.signShow) {
            [strongSelf.centerLabel fadeIn:^{
                strongSelf.signShow = YES;
                strongSelf.block();
            }];
        } else {
            //延迟0.15秒隐藏roudView，看起来好些
            [strongSelf performSelector:@selector(hideRoundView) withObject:nil afterDelay:0.15];
        }
    }];
}

//两个标签栏的动画
- (void)twoLineAnimation {
    CGPoint pointA;
    CGPoint pointTopB;
    CGPoint pointTopC;
    CGPoint pointBottomB;
    CGPoint pointBottomC;
    if (_model.loaction.x <= 0.5) {
        pointA = CGPointMake(0, kSignViewHeight / 2);
        pointTopB = CGPointMake(0, kSignViewHeight / 2 - kSignTwoLineSpace);
        pointTopC = CGPointMake(_topLabel.w + kChangeLineFirstAnimationWidth, kSignViewHeight / 2 - kSignTwoLineSpace);
        pointBottomB = CGPointMake(0, kSignViewHeight / 2 + kSignTwoLineSpace);
        pointBottomC = CGPointMake(_bottomLabel.w + kChangeLineFirstAnimationWidth, kSignViewHeight / 2 + kSignTwoLineSpace);
    } else {
        pointA = CGPointMake(self.w, kSignViewHeight / 2);
        pointTopB = CGPointMake(self.w, kSignViewHeight / 2 - kSignTwoLineSpace);
        pointTopC = CGPointMake(self.w - (_topLabel.w + kChangeLineFirstAnimationWidth), kSignViewHeight / 2 - kSignTwoLineSpace);
        pointBottomB = CGPointMake(self.w, kSignViewHeight / 2 + kSignTwoLineSpace);
        pointBottomC = CGPointMake(self.w - (_bottomLabel.w + kChangeLineFirstAnimationWidth), kSignViewHeight / 2 + kSignTwoLineSpace);
    }
    
    __weak typeof(self) weakSelf = self;
    [_shapeLayerTop addPathAnimationPointA:pointA pointB:pointTopB pointC:pointTopC isForward:!_signShow completeAnimation:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf.signShow) {
            [strongSelf.topLabel fadeIn:^{
            }];
        }
    }];
    
    [_shapeLayerBottom addPathAnimationPointA:pointA pointB:pointBottomB pointC:pointBottomC isForward:!_signShow completeAnimation:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf.signShow) {
            [strongSelf.bottomLabel fadeIn:^{
                strongSelf.signShow = YES;
                strongSelf.block();
            }];
        } else {
            //延迟0.15秒隐藏roudView，看起来好些
            [strongSelf performSelector:@selector(hideRoundView) withObject:nil afterDelay:0.15];
        }
    }];
}

//三个标签栏的动画
- (void)threeLineAnimation {
    CGPoint pointA;
    CGPoint pointTopB;
    CGPoint pointTopC;
    CGPoint pointCenterB;
    CGPoint pointCenterC;
    CGPoint pointBottomB;
    CGPoint pointBottomC;
    
    if (_model.loaction.x <= 0.5) {
        pointA = CGPointMake(0, kSignViewHeight / 2);
        pointTopB = CGPointMake(0, kSignViewHeight / 2 - kSignThreeLineSpace);
        pointTopC = CGPointMake(_topLabel.w + kChangeLineFirstAnimationWidth, kSignViewHeight / 2 - kSignThreeLineSpace);
        pointBottomB = CGPointMake(0, kSignViewHeight / 2 + kSignThreeLineSpace);
        pointCenterB = CGPointMake(kChangeLineFirstAnimationWidth, kSignViewHeight / 2);
        pointCenterC = CGPointMake(_centerLabel.w + kChangeLineFirstAnimationWidth, kSignViewHeight / 2);
        pointBottomC = CGPointMake(_bottomLabel.w + kChangeLineFirstAnimationWidth, kSignViewHeight / 2 + kSignThreeLineSpace);
    } else {
        pointA = CGPointMake(self.w, kSignViewHeight / 2);
        pointTopB = CGPointMake(self.w, kSignViewHeight / 2 - kSignThreeLineSpace);
        pointTopC = CGPointMake(self.w - (_topLabel.w + kChangeLineFirstAnimationWidth), kSignViewHeight / 2 - kSignThreeLineSpace);
        pointCenterB = CGPointMake(self.w - kChangeLineFirstAnimationWidth, kSignViewHeight / 2);
        pointCenterC = CGPointMake(self.w - (_centerLabel.w + kChangeLineFirstAnimationWidth), kSignViewHeight / 2);
        pointBottomB = CGPointMake(self.w, kSignViewHeight / 2 + kSignThreeLineSpace);
        pointBottomC = CGPointMake(self.w - (_bottomLabel.w + kChangeLineFirstAnimationWidth), kSignViewHeight / 2 + kSignThreeLineSpace);
    }
    
    __weak typeof(self) weakSelf = self;
    [_shapeLayerTop addPathAnimationPointA:pointA pointB:pointTopB pointC:pointTopC isForward:!_signShow completeAnimation:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf.signShow) {
            [strongSelf.topLabel fadeIn:^{
            }];
        }
    }];
    
    [_shapeLayerCenter addPathAnimationPointA:pointA pointB:pointCenterB pointC:pointCenterC isForward:!_signShow completeAnimation:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf.signShow) {
            [strongSelf.centerLabel fadeIn:^{
            }];
        }
    }];
    
    [_shapeLayerBottom addPathAnimationPointA:pointA pointB:pointBottomB pointC:pointBottomC isForward:!_signShow completeAnimation:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf.signShow) {
            [strongSelf.bottomLabel fadeIn:^{
                strongSelf.signShow = YES;
                strongSelf.block();
            }];
        } else {
            //延迟0.15秒隐藏roudView，看起来好些
            [strongSelf performSelector:@selector(hideRoundView) withObject:nil afterDelay:0.15];
        }
    }];
}

- (void)hideRoundView {
    _roundView.hidden = YES;
    _signShow = NO;
    _block();
}

@end
