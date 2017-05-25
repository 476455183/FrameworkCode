//
//  MoCATransition.m
//  CustomControls
//
//  Created by mojx on 16/8/21.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import "MoCATransition.h"

@implementation MoCATransition

#pragma CATransition动画实现

/**
 *  设置CATransition动画
 *
 *  @param type     动画类型
 *  @param subType  动画子类类型
 *  @param view     添加动画的view
 *  @param duration 动画持续时间
 */
+ (void)transitionWithType:(NSString *)type withSubtype:(NSString *)subType forView:(UIView *)view duration:(NSTimeInterval)duration
{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = duration;
    
    //设置运动type
    animation.type = type;
    if (subType != nil)
    {
        //设置子类
        animation.subtype = subType;
    }
    
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [view.layer addAnimation:animation forKey:@"animation"];
}


#pragma UIView实现动画

/**
 *  设置view动画
 *
 *  @param view       需要设置动画的view
 *  @param transition 转换类型
 *  @param duration   动画持续时间
 */
+ (void)animationWithView:(UIView *)view withAnimationTransition:(UIViewAnimationTransition)transition duration:(NSTimeInterval)duration
{
    [UIView animateWithDuration:duration animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:view cache:YES];
    }];
}

@end
