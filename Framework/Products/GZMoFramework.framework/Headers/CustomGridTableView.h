//
//  CustomGridTableView.h
//  CustomControls
//
//  Created by mojx on 2016/11/6.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomGridTableView : UIView

@property(nonatomic, strong) UITableView *myTableView;

/** 是否显示item图层边框*/
@property (nonatomic) BOOL isShowLayerBorder;
/** 网格选中回调*/
@property(nonatomic, copy) void(^GridDidSelectBlock)(NSIndexPath *indexPath, NSMutableArray *dataArray);

/**
 *  初始化数据
 *
 *  @param array            数据
 *  @param titleColor       主标题字体颜色
 *  @param titleFont        主标题字体
 *  @param subTitleColor    子标题字体颜色
 *  @param subTitleFont     子标题字体
 *  @param imageSize        cell图片大小
 *  @param cornerRadius     cell图片圆角半径
 *  @param heightForHeader  heightForHeaderInSection高度
 *  @param gridcount        网络数，须为整数
 */
- (void)initData:(NSMutableArray *)array
      titleColor:(UIColor *)titleColor
       titleFont:(UIFont *)titleFont
   subTitleColor:(UIColor *)subTitleColor
    subTitleFont:(UIFont *)subTitleFont
       imageSize:(CGSize)imageSize
    cornerRadius:(CGFloat)cornerRadius
 heightForHeader:(NSInteger)heightForHeader
       gridcount:(CGFloat)gridcount;

/**
 初始化消息提醒视图
 
 @param indexPath 索引路径
 @param fontSize 字体大小
 @param circleSize 消息提醒圆圈大小
 */
- (void)initBadgeView:(NSIndexPath *)indexPath fontSize:(CGFloat)fontSize circleSize:(CGFloat)circleSize;

/**
 设置消息提醒值
 
 @param indexPath 索引路径
 @param value 消息提醒的数字，为0时为不显示
 */
- (void)valueForBadge:(NSIndexPath *)indexPath value:(NSInteger)value;

@end
