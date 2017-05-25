//
//  FunctionScrollView.h
//  CustomControls
//
//  Created by mojx on 2017/3/16.
//  Copyright © 2017年 mojiaxun. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 排列显示类型 */
enum FunctionScrollStyle
{
    /** 水平排列显示 */
    KFunctionScroll_Horizontal,
    /** 垂直排列显示 */
    KFunctionScroll_Vertical
};

@interface FunctionScrollView : UIView

typedef void(^FunctionScrollViewBlock)(UITapGestureRecognizer *tap);

/** 设置block */
@property(nonatomic, strong)FunctionScrollViewBlock functionScrollViewBlock;
/** pageControl */
@property(nonatomic, strong)UIPageControl *pageControl;

/**
 * 初始设置参数
 * @param frame 位置和大小
 * @param array 数据数组
 * @param count 一行的数量
 * @param edge 边距
 * @param size 按钮的大小
 * @param style 排列显示类型：水平或垂直
 * @param color button的颜色
 * @param font button的字体形式大小
 */
- (id)initWithFrame:(CGRect)frame
           andArray:(NSMutableArray *)array
         widthCount:(NSUInteger)count
       edgeDistance:(CGSize)edge
         buttonSize:(NSInteger)size
              style:(enum FunctionScrollStyle)style
        buttonColor:(UIColor*)color
         buttonFont:(UIFont *)font;

/**
 选择button后的回调

 @param block 回调
 */
- (void)chooseButtonViewBlock:(FunctionScrollViewBlock)block;

@end
