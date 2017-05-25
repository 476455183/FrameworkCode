//
//  CustomDatePickerView.h
//  CustomControls
//  日期与时间选择器
//  Created by mojx on 2017/2/15.
//  Copyright © 2017年 mojiaxun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomDatePickerView : UIView

/**
 确定闭包回调
 content 选择的内容
 */
@property (nonatomic, copy) void(^okBlock)(NSString *content);

/**
 取消闭包回调
 */
@property (nonatomic, copy) void(^cancelBlock)();

/**
 初始化
 
 @param frame 框架大小
 @param backgroundColor 背景颜色
 @param showDate    弹出时默认显示的日期或时间
 @param mode        显示的模式: UIDatePickerModeDate、UIDatePickerModeTime、UIDatePickerModeDateAndTime
 @param format      显示的格式
     showDate、mode、format三者须保持一致。如
     showDate为2016-12-01，则mode为UIDatePickerModeDate，format为yyyy-MM-dd；
     showDate为12:01:01，则mode为UIDatePickerModeTime，format为HH:mm:ss
     showDate为2016-12-01 12:01:01，则mode为UIDatePickerModeDateAndTime，format为yyyy-MM-dd HH:mm:ss；
 @param isMaximumDateLimit 最大日期显示限制
 @param titleColor 确定取消按钮标题颜色
 @param titleFontSize 确定取消按钮标题字体大小
 @param inView 加载的视图
 @return 实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame
              backgroundColor:(UIColor *)backgroundColor
                     showDate:(NSString *)showDate
                         mode:(UIDatePickerMode)mode
                       format:(NSString *)format
           isMaximumDateLimit:(BOOL)isMaximumDateLimit
                   titleColor:(UIColor *)titleColor
                titleFontSize:(NSInteger)titleFontSize
                       inView:(UIView *)inView;

@end
