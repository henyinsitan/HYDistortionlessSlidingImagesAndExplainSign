//
//  ViewController.m
//  HYdistortionlessSlidingImages
//
//  Created by henyinsitan on 16/12/2.
//  Copyright © 2016年 刘梦翔. All rights reserved.
//

#import "HYMainViewController.h"
#import "XHSImitationScrollView.h"
#import "ImgModel.h"
#import "SignModel.h"

@interface HYMainViewController ()

@property (nonatomic, strong) XHSImitationScrollView *imitationScrollView;

@end

@implementation HYMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imitationScrollView = [[XHSImitationScrollView alloc] initWithFrame:self.view.bounds imgModel:[self makeData]];
    [self.view addSubview:_imitationScrollView];
}

//测试model数据制作
- (NSMutableArray *)makeData {
    //多张图片
    NSArray *imageArray = @[
                            @"http://g.hiphotos.baidu.com/image/w%3D310/sign=6f9ce22079ec54e741ec1c1f89399bfd/9d82d158ccbf6c81cea943f6be3eb13533fa4015.jpg",
                            @"http://b.hiphotos.baidu.com/image/pic/item/4bed2e738bd4b31cc6476eb985d6277f9e2ff8bd.jpg",
                            @"http://c.hiphotos.baidu.com/image/pic/item/94cad1c8a786c9174d18e030cb3d70cf3bc7579b.jpg",
                            @"http://e.hiphotos.baidu.com/image/w%3D310/sign=79bc1b1a950a304e5222a6fbe1c9a7c3/d1160924ab18972b50a46fd4e4cd7b899e510a15.jpg",
                            @"http://c.hiphotos.baidu.com/image/w%3D310/sign=05e2c867272dd42a5f0907aa333a5b2f/7dd98d1001e93901f3f7103079ec54e737d196c3.jpg",
                            @"http://g.hiphotos.baidu.com/image/w%3D310/sign=6f9ce22079ec54e741ec1c1f89399bfd/9d82d158ccbf6c81cea943f6be3eb13533fa4015.jpg",
                            @"http://b.hiphotos.baidu.com/image/pic/item/4bed2e738bd4b31cc6476eb985d6277f9e2ff8bd.jpg",
                            @"http://c.hiphotos.baidu.com/image/pic/item/94cad1c8a786c9174d18e030cb3d70cf3bc7579b.jpg",
                            @"http://e.hiphotos.baidu.com/image/w%3D310/sign=79bc1b1a950a304e5222a6fbe1c9a7c3/d1160924ab18972b50a46fd4e4cd7b899e510a15.jpg",
                            @"http://c.hiphotos.baidu.com/image/w%3D310/sign=05e2c867272dd42a5f0907aa333a5b2f/7dd98d1001e93901f3f7103079ec54e737d196c3.jpg",
                            @"http://g.hiphotos.baidu.com/image/w%3D310/sign=6f9ce22079ec54e741ec1c1f89399bfd/9d82d158ccbf6c81cea943f6be3eb13533fa4015.jpg",
                            @"http://b.hiphotos.baidu.com/image/pic/item/4bed2e738bd4b31cc6476eb985d6277f9e2ff8bd.jpg",
                            @"http://c.hiphotos.baidu.com/image/pic/item/94cad1c8a786c9174d18e030cb3d70cf3bc7579b.jpg",
                            @"http://e.hiphotos.baidu.com/image/w%3D310/sign=79bc1b1a950a304e5222a6fbe1c9a7c3/d1160924ab18972b50a46fd4e4cd7b899e510a15.jpg",
                            @"http://g.hiphotos.baidu.com/image/w%3D310/sign=6f9ce22079ec54e741ec1c1f89399bfd/9d82d158ccbf6c81cea943f6be3eb13533fa4015.jpg",
                            @"http://c.hiphotos.baidu.com/image/w%3D310/sign=05e2c867272dd42a5f0907aa333a5b2f/7dd98d1001e93901f3f7103079ec54e737d196c3.jpg"
                            ];
    NSArray *imageWidthArray = @[@310.f,@583,@680,@310,@310,@310.f,@583,@680,@310,@310,@310.f,@583,@680,@310,@310.f,@310];
    NSArray *imageHeightArray = @[@413,@480,@694,@465,@465,@413,@480,@694,@465,@465,@413,@480,@694,@465,@413,@465];
    
    //    //只有一张图片
    //    NSArray *imageArray = @[@"http://g.hiphotos.baidu.com/image/w%3D310/sign=6f9ce22079ec54e741ec1c1f89399bfd/9d82d158ccbf6c81cea943f6be3eb13533fa4015.jpg"];
    //    NSArray *imageWidthArray = @[@310.f];
    //    NSArray *imageHeightArray = @[@413];
    
    NSMutableArray *imgModelArrray = [[NSMutableArray alloc] init];
    for (int i=0; i < imageArray.count; i ++) {
        //标签数组，一个页面上展示多个或者一个标签
        NSArray *signModelArray;
        if (i == 0) {
            SignModel *signModel = [[SignModel alloc] init];
             //标签的原点的位置（根据占父视图宽高比计算的）
            signModel.loaction = CGPointMake(0.3, 0.7);
             //标签信息数组
            signModel.infoArray = @[@"我是标签栏A1"];
            
            signModelArray = @[signModel];
        } else if (i == 1) {
            SignModel *signModel = [[SignModel alloc] init];
            signModel.loaction = CGPointMake(0.6, 0.5);
            signModel.infoArray = @[@"我是标签栏A1",@"我是标签栏A2我比A1长哈哈"];
            
            SignModel *signModelB = [[SignModel alloc] init];
            signModelB.loaction = CGPointMake(0.3, 0.3);
            signModelB.infoArray = @[@"我是标签栏B1",@"我是标签栏B2我比B1长嘿嘿嘿嘿"];
            
            signModelArray = @[signModel, signModelB];
        } else {
            SignModel *signModel = [[SignModel alloc] init];
            signModel.loaction = CGPointMake(0.5, 0.3);
            signModel.infoArray = @[@"我是标签栏A1",@"我是标签栏A2我比A1长哈哈",@"我是标签栏A3我比A2长嘿嘿嘿嘿嘿嘿嘿嘿嘿"];
            
            SignModel *signModelB = [[SignModel alloc] init];
            signModelB.loaction = CGPointMake(0.7, 0.6);
            signModelB.infoArray = @[@"我是标签栏B1",@"我是标签栏B2我比B1长哈哈",@"我是标签栏B3我比B2长嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿黑"];
            
            SignModel *signModelC = [[SignModel alloc] init];
            signModelC.loaction = CGPointMake(0.3, 0.8);
            signModelC.infoArray = @[@"我是标签栏C1",@"我是标签栏C2我比C1长哈哈",@"我是标签栏C3我比C2长嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿黑呵呵"];
            
            signModelArray = @[signModel, signModelB, signModelC];
        }
        
        ImgModel *model = [[ImgModel alloc] init];
        model.url = imageArray[i];
        model.width = [imageWidthArray[i] floatValue];
        model.height = [imageHeightArray[i] floatValue];
        model.signInfoArray = signModelArray;
        [imgModelArrray addObject:model];
    }
    
    return imgModelArrray;
}


@end
