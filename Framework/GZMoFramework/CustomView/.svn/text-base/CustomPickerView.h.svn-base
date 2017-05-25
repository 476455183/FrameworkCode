//
//  CustomPickerView.h
//  CustomControls
//  通用选择器（单列、双列）
//  Created by mojx on 2017/2/15.
//  Copyright © 2017年 mojiaxun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomPickerView : UIView

/**
 确定闭包回调
 content1、content2选择的内容；selectedRow1、selectedRow2选中的行
 */
@property (nonatomic, copy) void(^okBlock)(NSString *content1, NSString *content2, NSInteger selectedRow1, NSInteger selectedRow2);

/**
 取消闭包回调
 */
@property (nonatomic, copy) void(^cancelBlock)();

/**
 初始化
 
 @param frame 框架大小
 @param backgroundColor 背景颜色
 @param contentArray1 内容数组1（必填）
 @param contentArray2 内容数组2（可选，如为nil时，则只显示contentArray1的内容）
 @param showRow1 弹出时默认显示第几行的内容,与contentArray1的内容对应（必填）
 @param showRow2 弹出时默认显示第几行的内容,与contentArray2的内容对应（可选）
 @param titleColor 确定取消按钮标题颜色
 @param titleFontSize 确定取消按钮标题字体大小
 @param inView 加载的视图
 @return 实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame
              backgroundColor:(UIColor *)backgroundColor
                contentArray1:(NSArray *)contentArray1
                contentArray2:(NSArray *)contentArray2
                     showRow1:(NSInteger)showRow1
                     showRow2:(NSInteger)showRow2
                   titleColor:(UIColor *)titleColor
                titleFontSize:(NSInteger)titleFontSize
                       inView:(UIView *)inView;

@end
