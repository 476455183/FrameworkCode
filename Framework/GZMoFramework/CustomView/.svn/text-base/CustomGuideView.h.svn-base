//
//  CustomGuideView.h
//  CustomControls
//
//  Created by mojx on 16/7/10.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import <UIKit/UIKit.h>

//定义GuideViewDidTap协议
@protocol GuideViewDidTap

@optional//可选实现的方法

/**
 *  引导图片点击
 *
 *  @param tag 点击标志
 */
- (void)guideViewImageTap:(NSInteger)tag;

/**
 *  引导定时器事件（定时器开启时才有效）
 *
 *  @param tag 页码标志
 */
- (void)guideViewTimerEvent:(NSInteger)tag;

@end


@interface CustomGuideView : UIView<UIScrollViewDelegate>

/** 图片点击协议*/
@property (nonatomic, assign) id<GuideViewDidTap> imageTapDelegate;
/** 是否允许左右循环拖动*/
@property (nonatomic) BOOL isCycleDragging;
/** 是否启动引导定时标志*/
@property (nonatomic) BOOL isStartGuideViewTime;

/**
 *  初始化引导图片（引导图片或广告图片）
 *
 *  @param imageArray             图片数组
 *  @param isShowExperienceButton 是否显示立即体验按钮, 如显示则viewControl不能为空
 *  @param experienceButtonSize   立即体验按钮大小
 *  @param viewControl            视图控制器
 *  @param color1                 选中页的圆点颜色
 *  @param color2                 非选中页的圆点颜色
 */
- (void)initGuideView:(NSMutableArray *)imageArray
isShowExperienceButton:(BOOL)isShowExperienceButton
 experienceButtonSize:(CGSize)experienceButtonSize
          viewControl:(UIViewController *)viewControl
    pageSelectedColor:(UIColor *)color1
 pageNonSelectedColor:(UIColor *)color2;

/**
 *  定时改变引导图片（引导图片或广告图片），不使用时须调用stopGuideViewTime
 *
 *  @param timeInterval 定时时间，单位为秒，须>=1秒
 */
- (void)changeGuideViewWithTimeInterval:(CGFloat)timeInterval;

/**
 *  停止引导定时器
 */
- (void)stopGuideViewTime;

@end
