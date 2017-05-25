//
//  CustomAlertView.h
//  CustomDialog
//  自定义弹出对话框
//  Created by mojx on 2017/4/11.
//  Copyright © 2017年 mojiaxun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAlertView : UIView

/** 按钮点击回调*/
@property(nonatomic, copy) void(^buttonBlock)(UIButton *button);
/** 富文本*/
@property(nonatomic) NSMutableAttributedString *mAttributeString;

/**
 初始化对话框
 
 @param frame 位置、大小
 @param backgroundColor 背景颜色
 @param imageName 提示图片名称
 @param imageSize 提示图片大小
 @param imageTopEdge 提示图片顶部边缘大小
 @param title 对话框主标题
 @param titleColor 对话框主标题颜色
 @param titleFontSize 对话框主标题字体大小
 @param subtitle 对话框副标题
 @param subtitleColor 对话框副标题颜色
 @param subtitleFontSize 对话框副标题字体大小
 @param buttonTitles 对话框按钮，按钮个数目前限制<3个
 @return 实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame
              backgroundColor:(UIColor *)backgroundColor
                    imageName:(NSString *)imageName
                    imageSize:(CGSize)imageSize
                 imageTopEdge:(CGFloat)imageTopEdge
                        title:(NSString *)title
                   titleColor:(UIColor *)titleColor
                titleFontSize:(CGFloat)titleFontSize
                     subtitle:(NSString *)subtitle
                subtitleColor:(UIColor *)subtitleColor
             subtitleFontSize:(CGFloat)subtitleFontSize
                 buttonTitles:(NSMutableArray *)buttonTitles;

/**
 更新对话框富文本标签的富文本
 
 @param attributedString 富文本
 */
- (void)updateTextLabelAttributedText:(NSMutableAttributedString *)attributedString;

@end
