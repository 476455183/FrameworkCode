//
//  CustomTableViewPlain.h
//  GZMoFramework
//
//  Created by mojx on 16/7/19.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import <UIKit/UIKit.h>

//定义TableViewPlainDidSelectRow协议
@protocol TableViewPlainDidSelectRow

@optional//可选实现的方法
- (void)tableViewPlainDidSelectRowAtIndexPath:(NSIndexPath *)indexPath dataArray:(NSMutableArray *)dataArray;

@end


@interface CustomTableViewPlain : UIView

@property(nonatomic, strong) UITableView *myTableView;
@property(nonatomic) NSMutableArray *dataMArray;//数据
@property (nonatomic, assign) id<TableViewPlainDidSelectRow> selectRowDelegate;//协议

/** cell类型*/
@property(nonatomic) UITableViewCellAccessoryType accessoryType;
/** cell选择类型*/
@property(nonatomic) UITableViewCellSelectionStyle selectionStyle;
/** 取消选择时是否显示动画效果*/
@property(nonatomic) BOOL deselectRowAnimated;
/** 是否固定cell高度*/
@property(nonatomic) BOOL isFixedCellHeight;
/** 固定的cell高度*/
@property(nonatomic) CGFloat fixedCellHeight;

/**
 *  初始化数据
 *
 *  @param array            数据
 *  @param titleColor       标题字体颜色
 *  @param valueColor       value字体颜色
 *  @param font             字体
 *  @param spacing          段间距
 *  @param cellHieghtOffset cell偏置高度
 */
- (void)initData:(NSMutableArray *)array titleColor:(UIColor *)titleColor valueColor:(UIColor *)valueColor font:(UIFont *)font spacing:(CGFloat)spacing cellHieghtOffset:(NSInteger)cellHieghtOffset;

/**
 *  初始化数据
 *
 *  @param array            数据
 *  @param titleColor       主标题字体颜色
 *  @param titleFont        主标题字体
 *  @param subTitleColor    子标题字体颜色
 *  @param subTitleFont     子标题字体
 *  @param spacing          段间距
 *  @param imageSize        cell图片大小
 *  @param cornerRadius     cell图片圆角半径
 *  @param cellHieghtOffset cell偏置高度
 */
- (void)initData:(NSMutableArray *)array
      titleColor:(UIColor *)titleColor
       titleFont:(UIFont *)titleFont
   subTitleColor:(UIColor *)subTitleColor
    subTitleFont:(UIFont *)subTitleFont
         spacing:(CGFloat)spacing
       imageSize:(CGSize)imageSize
    cornerRadius:(CGFloat)cornerRadius
cellHieghtOffset:(NSInteger)cellHieghtOffset;

/**
 *  初始化数据
 *
 *  @param array            数据
 *  @param color            颜色
 *  @param font             字体大小
 *  @param cellHieghtOffset cell偏置高度
 */
- (void)initData:(NSMutableArray *)array color:(UIColor *)color font:(UIFont *)font cellHieghtOffset:(NSInteger)cellHieghtOffset;

/**
 *  初始化数据
 *
 *  @param array            数据
 *  @param color            颜色
 *  @param font             字体大小
 *  @param imageSize        cell图片大小
 *  @param cornerRadius     cell图片圆角半径
 *  @param cellHieghtOffset cell偏置高度
 */
- (void)initData:(NSMutableArray *)array color:(UIColor *)color font:(UIFont *)font imageSize:(CGSize)imageSize cornerRadius:(CGFloat)cornerRadius cellHieghtOffset:(NSInteger)cellHieghtOffset;

/**
 *  插入数据
 *
 *  @param object 数据
 *  @param index  索引位置
 */
- (void)insertData:(id)object index:(NSInteger)index;

@end
