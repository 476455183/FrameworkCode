//
//  DropdownButton.h
//  CustomControls
//
//  Created by mojx on 16/8/14.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import <UIKit/UIKit.h>

//显示下拉菜单的协议
@protocol showDropdownMenuDelegate <NSObject>

@optional//可选实现的方法
- (void)showDropdownMenu:(NSInteger)index;
- (void)hideDropdownMenu:(NSInteger)index;

@end


//下拉菜单图像对齐方式
enum DropdownMenuImageAlignment
{
    //在标题右边显示
    DropdownMenuImageAlignment_TitleRight = 0,
    //左边显示
    DropdownMenuImageAlignment_Left = 1,
    //右边显示
    DropdownMenuImageAlignment_Right = 2,
};


@interface DropdownButton : UIView

/** 下拉菜单图像对齐方式*/
@property (nonatomic)enum DropdownMenuImageAlignment imageAlignment;
/** 协议*/
@property (nonatomic, assign) id<showDropdownMenuDelegate> delegate;

/**
 *  初始化下拉菜单按钮
 *
 *  @param titles          按钮标题
 *  @param titleColor      标题颜色
 *  @param lineColor       底部线条颜色
 *  @param font            字体
 *  @param backgroundColor 抱背景颜色
 */
- (void)initDropdownButtonWithTitles:(NSMutableArray *)titles titleColor:(UIColor *)titleColor lineColor:(UIColor *)lineColor font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor;

/**
 *  修改按钮标题
 *
 *  @param index 索引
 *  @param title 修改的标题
 */
- (void)changeButtonWithIndex:(NSInteger)index title:(NSString *)title;

/**
 *  修改按钮旋转角度
 *
 *  @param index         索引
 *  @param rotationAngle 旋转的角度
 */
- (void)changeButtonAngle:(NSInteger)index rotationAngle:(CGFloat)rotationAngle;

@end
