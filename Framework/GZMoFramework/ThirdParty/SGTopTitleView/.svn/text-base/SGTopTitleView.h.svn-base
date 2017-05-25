//
//  SGTopTitleView.h
//  SGTopTitleViewExample
//
//  Created by Sorgle on 16/8/24.
//  Copyright © 2016年 Sorgle. All rights reserved.
//  modified by mojiaxun 2016/12/01

#import <UIKit/UIKit.h>

@class SGTopTitleView;

@protocol SGTopTitleViewDelegate <NSObject>
// delegate 方法
- (void)SGTopTitleView:(SGTopTitleView *)topTitleView didSelectTitleAtIndex:(NSInteger)index;

@end


@interface SGTopTitleView : UIScrollView

/** 标题Label */
@property (nonatomic, strong) NSMutableArray *allTitleLabel;
@property (nonatomic, weak) id<SGTopTitleViewDelegate> delegate_SG;

/**
 初始化
 
 @param frame 位置和大小
 @param titleFontSize 标题字体大小
 @param titleDefalutColor 标题默认的颜色
 @param titleSelectedColor 标题选中时的颜色
 @param lineSelectedColor 滑动线条选中时的颜色
 @param lineSelectedImage 滑动线条选中时的图像
 @param isShowBottomLine 是否显示底部线条
 @return 实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame
                titleFontSize:(CGFloat)titleFontSize
            titleDefalutColor:(UIColor *)titleDefalutColor
           titleSelectedColor:(UIColor *)titleSelectedColor
            lineSelectedColor:(UIColor *)lineSelectedColor
            lineSelectedImage:(UIImage *)lineSelectedImage
             isShowBottomLine:(BOOL)isShowBottomLine;

/** 初始化静止标题*/
- (void)initStaticTitleArr:(NSArray *)staticTitleArr;
/** 初始化滚动标题*/
- (void)initScrollTitleArr:(NSArray *)scrollTitleArr;

/** 静止标题选中颜色改变以及指示器位置变化 */
- (void)staticTitleLabelSelecteded:(UILabel *)label;
/** 滚动标题选中颜色改变以及指示器位置变化 */
- (void)scrollTitleLabelSelecteded:(UILabel *)label;
/** 滚动标题选中居中 */
- (void)scrollTitleLabelSelectededCenter:(UILabel *)centerLabel;


@end
