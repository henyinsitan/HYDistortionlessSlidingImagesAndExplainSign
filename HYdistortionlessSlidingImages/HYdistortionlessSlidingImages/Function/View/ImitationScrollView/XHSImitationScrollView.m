//
//  XHSImitationScrollView.m
//  XHSImitationScrollDemo
//
//  Created by henyinsitan on 16/11/29.
//  Copyright © 2016年 刘梦翔. All rights reserved.
//

#import "XHSImitationScrollView.h"
#import "ImgModel.h"
#import "XHSImgView.h"
#import "UniteView.h"
#import "PageLabel.h"
#import "UIImageView+WebCache.h"

@interface XHSImitationScrollView () <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray<ImgModel *> *modelArray;
@property (nonatomic, strong) UIScrollView *lScrollView;
//scrollView额外加一层view（原因：UIScrollView的size依赖于subviews。如果subviews的size再依赖于UIScrollView，则布局引擎就混乱了）
@property (nonatomic, strong) UIView *scrollContentView;
//当前添加UniteView自动布局依赖的view(每次加完一个此view就会变成此时加的UniteView)
@property (nonatomic, strong) UniteView *currentRelyOnView;
//用来装载所有的uniteView
@property (nonatomic, strong) NSMutableArray<UniteView *> *uniteViewsArray;
//当前页
@property (nonatomic, assign) int currentPage;
//用来显示当前页数
@property (nonatomic, strong) UILabel *pageLabel;

@end

@implementation XHSImitationScrollView

- (instancetype)initWithFrame:(CGRect)frame imgModel:(NSArray *)modelArray {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor orangeColor];
        [self loadSubViews];
        if (modelArray) {
            self.modelArray = modelArray;
        }
    }
    return self;
}

- (void)loadSubViews {
    _lScrollView = [[UIScrollView alloc] init];
    _lScrollView.pagingEnabled = YES;
    _lScrollView.showsVerticalScrollIndicator = NO;
    _lScrollView.showsHorizontalScrollIndicator = NO;
    _lScrollView.delegate = self;
    _lScrollView.bounces = NO;
    [self addSubview: _lScrollView];
    
    _scrollContentView = [[UIView alloc] init];
    [_lScrollView addSubview:_scrollContentView];
}

- (void)setModelArray:(NSArray<ImgModel *> *)modelArray {
    _uniteViewsArray = [[NSMutableArray alloc] init];
    _modelArray = modelArray;
    ImgModel *firstImgModel = [modelArray firstObject];
    _lScrollView.frame = CGRectMake(0, 0, self.w, self.w / firstImgModel.width * firstImgModel.height);
    _scrollContentView.frame = CGRectMake(0, 0, _lScrollView.w * modelArray.count, _lScrollView.h);
    
    for (int i = 0; i < modelArray.count; i ++) {
        UniteView *uniteView = [[UniteView alloc] initWithModel:modelArray[i]];
        [_scrollContentView addSubview:uniteView];
        [self addLayout:uniteView index:i];
        [_uniteViewsArray addObject:uniteView];
        _currentRelyOnView = uniteView;
    }
    _lScrollView.contentSize = CGSizeMake(_lScrollView.w * _modelArray.count, 0);
    [self loadPageLabel];
}

- (void)loadPageLabel {
    _pageLabel = [[PageLabel alloc] initWithFrame:CGRectMake(10, _lScrollView.H - 26, self.w - 20, 21)];
    _pageLabel.text = [NSString stringWithFormat:@"1/%lu",(unsigned long)_modelArray.count];
    [self addSubview:_pageLabel];
}

/**
 UniteView约束在scrllContentView上
 */
- (void)addLayout:(UniteView *)uniteView index:(NSInteger)index{
    //uniteView上下左约束
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:uniteView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_scrollContentView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:uniteView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_scrollContentView attribute:NSLayoutAttributeBottom  multiplier:1 constant:0];
    //当加第一个uniteView时约束基准为_scrollContentView
    NSLayoutConstraint *leftConstraint;
    if (index == 0) {
        ImgModel *imgModel = _modelArray[0];
        //第一张图片马上加载
        [uniteView.imgV sd_setImageWithURL:[NSURL URLWithString:imgModel.url]];
        leftConstraint = [NSLayoutConstraint constraintWithItem:uniteView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_scrollContentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    } else {
        leftConstraint = [NSLayoutConstraint constraintWithItem:uniteView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_currentRelyOnView attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    }
    [_scrollContentView addConstraints:@[topConstraint, bottomConstraint, leftConstraint]];
    //uniteView宽度约束
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint  constraintWithItem:uniteView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1  constant:_lScrollView.w];
    [uniteView addConstraint:widthConstraint];
}

#pragma mark-- UIScrollView delegate methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //当前页数
    _currentPage = scrollView.contentOffset.x / scrollView.w;
    _pageLabel.text = [NSString stringWithFormat:@"%i/%lu",_currentPage + 1,(unsigned long)_modelArray.count];

    //滑到边界控制
    if (scrollView.contentOffset.x >= (_modelArray.count- 1) * scrollView.w) {
        return;
    }
    
    //动态改变约束,不管向左还是向右滑动，当前图约束向右，当前图下一张图的约束向左
    UniteView *currentUniteView = _uniteViewsArray[_currentPage];
    UniteView *nextUniteView = _uniteViewsArray[_currentPage + 1];
    if (!nextUniteView.imgV.image) {//将开始滑动到下个图才加载下个图以节约内存和流量
        ImgModel *model = _modelArray[_currentPage + 1];
        [nextUniteView.imgV sd_setImageWithURL:[NSURL URLWithString:model.url]];
    }
    [currentUniteView removeConstraint:currentUniteView.leftConstraint];
    [currentUniteView addConstraint:currentUniteView.rightConstraint];
    [nextUniteView removeConstraint:nextUniteView.rightConstraint];
    [nextUniteView addConstraint:nextUniteView.leftConstraint];
    
    CGFloat RoffsetX;//当前图的偏移
    ImgModel *currentImgModel;
    ImgModel *nextImgModel;
    static CGFloat newx = 0;
    static CGFloat oldx = 0;
    newx = scrollView.contentOffset.x;
    //左右滑动判断
    if (newx > oldx) {//左滑动以右边出现的图为基准改变scrollView的高度
        nextImgModel = _modelArray[_currentPage + 1];
        currentImgModel = _modelArray[_currentPage];
        RoffsetX = scrollView.contentOffset.x - _currentPage * scrollView.w;
    }else {//右滑动以左边出现的图为基准改变scrollView的高度
        nextImgModel = _modelArray[_currentPage];
        currentImgModel = _modelArray[_currentPage + 1];
        RoffsetX = (_currentPage + 1) * scrollView.w - scrollView.contentOffset.x;
    }
    oldx = newx;
    
    //切换前scrollView的高度
    CGFloat currentHeight = scrollView.w / currentImgModel.width * currentImgModel.height;
    //切换完成时scrollView的高度
    CGFloat nextHeight = scrollView.w / nextImgModel.width * nextImgModel.height;
    //每单位移动高度的变化量
     CGFloat unitIncrease = (nextHeight - currentHeight) / scrollView.w;
    //scrollView变化中的高度
    CGFloat moveHeight = currentHeight + unitIncrease * RoffsetX;
    scrollView.frame = CGRectMake(scrollView.x, scrollView.y, scrollView.w, moveHeight);
    _scrollContentView.frame = CGRectMake(_scrollContentView.x, _scrollContentView.y, _scrollContentView.w, moveHeight);
    _pageLabel.frame = CGRectMake(_pageLabel.x, scrollView.H - 26, _pageLabel.w, _pageLabel.h);
}

@end
