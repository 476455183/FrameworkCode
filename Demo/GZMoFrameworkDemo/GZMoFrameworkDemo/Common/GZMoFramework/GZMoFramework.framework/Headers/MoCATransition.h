//
//  MoCATransition.h
//  CustomControls
//
//  Created by mojx on 16/8/21.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    Fade = 1,                   //淡入淡出
    Push,                       //推挤
    Reveal,                     //揭开
    MoveIn,                     //覆盖
    Cube,                       //立方体
    SuckEffect,                 //吮吸
    OglFlip,                    //翻转
    RippleEffect,               //波纹
    PageCurl,                   //翻页
    PageUnCurl,                 //反翻页
    CameraIrisHollowOpen,       //开镜头
    CameraIrisHollowClose,      //关镜头
    CurlDown,                   //下翻页
    CurlUp,                     //上翻页
    FlipFromLeft,               //左翻转
    FlipFromRight,              //右翻转
    
} AnimationType;

@interface MoCATransition : NSObject

/**
 *  设置CATransition动画
 *
 *  @param type     动画类型
 *  @param subType  动画子类类型
 *  @param view     添加动画的view
 *  @param duration 动画持续时间
 */
+ (void)transitionWithType:(NSString *)type withSubtype:(NSString *)subType forView:(UIView *)view duration:(NSTimeInterval)duration;

/**
 *  设置view动画
 *
 *  @param view       需要设置动画的view
 *  @param transition 转换类型
 *  @param duration   动画持续时间
 */
+ (void)animationWithView:(UIView *)view withAnimationTransition:(UIViewAnimationTransition)transition duration:(NSTimeInterval)duration;

@end
