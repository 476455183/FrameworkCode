//
//  CustomDropDownListView.h
//  CustomControls
//
//  Created by mojx on 2016/11/24.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomDropDownListView : UIView

/**
 闭包回调
 @param row 数据行
 @param title 标题
 */
@property (nonatomic, copy) void(^myBlock)(NSInteger row, NSString *title);

/**
 初始化
 
 @param frame 框架大小
 @param marginSize 边缘大小
 @param dataArray 数据
 @param textColor 内容颜色
 @param textFont 内容字体
 @param inView 加载的视图
 @return 实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame
                   marginSize:(CGFloat)marginSize
                    dataArray:(NSArray *)dataArray
                    textColor:(UIColor *)textColor
                     textFont:(UIFont *)textFont
                       inView:(UIView *)inView;

@end
