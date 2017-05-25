//
//  GridCollectionView.h
//  CustomControls
//
//  Created by mojx on 2016/11/5.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import <UIKit/UIKit.h>

//定义GridCollectionViewDelegate协议
@protocol GridCollectionViewDelegate

@optional//可选实现的方法
- (void)gridCollectionViewDidSelect:(NSIndexPath *)indexPath dataArray:(NSMutableArray *)dataArray;

@end


@interface GridCollectionView : UIView<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *myCollectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *imageArray;
/** CollectionView选中的item索引*/
@property (nonatomic) NSInteger selectedCell;
/** CollectionView中item图片大小*/
@property (nonatomic) CGSize imageSize;
/** 是否显示CollectionView中item图层边框*/
@property (nonatomic) BOOL isShowLayerBorder;
@property (nonatomic, assign) id<GridCollectionViewDelegate> selectRowDelegate;//协议

/**
 *  初始化
 *
 *  @param frame            位置和大小
 *  @param rowGridCount     每一行网格个数
 *  @param titleFont        标题字体
 *  @param titleColor       标题颜色
 *  @param cornerRadius     图片圆角半径
 */
- (instancetype)initWithFrame:(CGRect)frame
                 rowGridCount:(CGFloat)rowGridCount
                    titleFont:(UIFont *)titleFont
                   titleColor:(UIColor *)titleColor
                 cornerRadius:(CGFloat)cornerRadius;

/**
 初始化消息提醒视图
 
 @param indexPath 索引路径
 @param fontSize 字体大小
 @param circleSize 消息提醒圆圈大小
 */
- (void)initBadgeView:(NSIndexPath *)indexPath fontSize:(CGFloat)fontSize circleSize:(CGFloat)circleSize;

/**
 设置消息提醒
 
 @param value 消息提醒的数字，为0时为不显示
 */
- (void)valueForBadge:(NSInteger)value;

@end
