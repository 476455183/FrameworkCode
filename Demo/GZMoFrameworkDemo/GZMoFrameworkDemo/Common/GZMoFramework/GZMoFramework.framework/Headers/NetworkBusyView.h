//
//  NetworkBusyView.h
//  ihuikou
//
//  Created by Horson on 14/11/18.
//  Copyright (c) 2014年 Horson. All rights reserved.
//


/*
 显示状态忙的一个单例类。继承UIView，是一个视图
 这个类会从HorsonFunction获取到当前屏幕的尺寸，作为自己的尺寸。
 背景的半透明黑色，中间有黑色的圆角提示，这个提示位置，会自己根据计算。
 */

#import <UIKit/UIKit.h>


@interface NetworkBusyView : UIView
{
    UILabel * HUDlabel;//提示label，设置提示文字用的
}

/**
 *	@brief	实例化遮挡页面的单例
 *
 *	@return  返回自己本身
 *
 */
+(NetworkBusyView *)shareInstance;


/**
 *	@brief	显示遮挡界面，遮挡整个屏幕
 *
 *	@param 	prompt 	提示内容，告诉用户，在忙什么。
 *	@param 	aSuperView 	一个父类。
 *
 */
-(void)showBusyViewWithPrompt:(NSString *)prompt superView:(UIView *)aSuperView;

/**
 *	@brief	移除遮挡界面
 *	@param 	aSuperView 	一个父类。
 *
 */
-(void)removeBusyViewFromSuperView:(UIView *)aSuperView;

/**
 *	@brief	设置提示内容
 *
 *	@param 	notice 	字符串，提示内容。
 */
-(void)setShowString:(NSString *)notice;


@end