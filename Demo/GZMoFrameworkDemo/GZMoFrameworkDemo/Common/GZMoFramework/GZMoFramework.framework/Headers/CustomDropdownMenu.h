//
//  CustomDropdownMenu.h
//  CustomControls
//
//  Created by mojx on 16/8/11.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import <UIKit/UIKit.h>


//定义DropdownMenu协议
@protocol DropdownMenuDelegate

@optional//可选实现的方法

/**
 *  下拉菜单选中事件
 *
 *  @param leftIndex  左边tableview选中索引
 *  @param rightIndex 右边tableview选中索引，没有则为0
 *  @param leftData   左边tableview选中的数据
 *  @param rightData  右边tableview选中的数据，没有则为空""
 */
- (void)dropdownMenuDidSelect:(NSInteger)leftIndex rightIndex:(NSInteger)rightIndex leftData:(NSString *)leftData rightData:(NSString *)rightData;

@end


@interface CustomDropdownMenu : UIView

/** 下拉菜单点击协议*/
//@property (nonatomic, assign) id<DropdownMenuDelegate> dropdownMenuDelegate;

//定义下拉菜单block
typedef void (^dropdownMenuBlock)(NSInteger leftIndex, NSInteger rightIndex, NSString *leftData, NSString *rightData);
/** 回调*/
@property(nonatomic, copy) dropdownMenuBlock myBlock;
/** 选择菜单后是否隐藏菜单*/
@property(nonatomic) BOOL isDidSelectHideMenu;

/**
 *  初始化下拉菜单
 *
 *  @param dataArray           下拉菜单数据
 *  @param type                下拉菜单类型
 *  @param titles              下拉菜单按钮标题
 *  @param titleColor          下拉菜单按钮标题颜色
 *  @param lineColor           下拉菜单底部线条颜色
 *  @param valueColor          下拉菜单数据值颜色
 *  @param font                字体大小
 *  @param cellHieght          高度
 *  @param backgroundColor     下拉菜单按钮背景颜色
 *  @param selectedIndex       默认选中的行
 *  @param selectedIndexEnable 默认选中行是否使能
 *  @param imageAlignment      下拉图像对齐方式：0在标题右边显示；1左边显示；2右边显示；
 */
- (void)initData:(NSMutableArray *)dataArray
dropdownMenuType:(NSInteger)type
          titles:(NSMutableArray *)titles
      titleColor:(UIColor *)titleColor
       lineColor:(UIColor *)lineColor
      valueColor:(UIColor *)valueColor
            font:(UIFont *)font
      cellHieght:(NSInteger)cellHieght
 backgroundColor:(UIColor *)backgroundColor
   selectedIndex:(NSInteger)selectedIndex
selectedIndexEnable:(BOOL)selectedIndexEnable
  imageAlignment:(NSInteger)imageAlignment;

@end
