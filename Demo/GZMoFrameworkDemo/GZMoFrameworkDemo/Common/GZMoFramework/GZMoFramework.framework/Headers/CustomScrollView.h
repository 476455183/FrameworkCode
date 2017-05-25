//
//  CustomScrollView.h
//  CustomControls
//
//  Created by mojx on 16/7/17.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomScrollView : UIView

/**
 *  初始化数据
 *
 *  @param text            文本数据
 *  @param textFont        文本字体
 *  @param backgroundColor 背景颜色
 *  @param backgroundView  背景图片
 */
- (void)initData:(NSString *)text textFont:(UIFont *)textFont backgroundColor:(UIColor *)backgroundColor backgroundView:(UIView *)backgroundView;

/**
 *  初始化数据
 *
 *  @param keys            数据keys，keys和values中的值必须一一对应
 *  @param values          数据values
 *  @param keyColor        key字体颜色
 *  @param valueColor      value字体颜色
 *  @param font            字体
 *  @param backgroundColor 背景颜色
 *  @param backgroundView  背景图片
 */
- (void)initData:(NSMutableArray *)keys values:(NSMutableArray *)values keyColor:(UIColor *)keyColor valueColor:(UIColor *)valueColor font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor backgroundView:(UIView *)backgroundView;

@end
