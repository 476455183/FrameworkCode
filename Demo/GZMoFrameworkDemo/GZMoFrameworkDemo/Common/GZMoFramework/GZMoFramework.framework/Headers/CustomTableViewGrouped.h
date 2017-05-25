//
//  CustomTableViewGrouped.h
//  GZMoFramework
//
//  Created by mojx on 16/8/18.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import <UIKit/UIKit.h>

//定义TableViewGroupedDidSelectRow协议
@protocol TableViewGroupedDidSelectRow

@optional//可选实现的方法
/**
 *  tableview cell选项事件
 *
 *  @param indexPath 索引
 *  @param dataArray 数据
 */
- (void)tableViewGroupedDidSelectRowAtIndexPath:(NSIndexPath *)indexPath dataArray:(NSMutableArray *)dataArray;

/**
 *  tableview cell选项事件，点击登录时处理
 *
 *  @param indexPath   索引
 *  @param dataArray   数据
 *  @param accountInfo 账号信息
 */
- (void)tableViewGroupedLoginDidSelectRowAtIndexPath:(NSIndexPath *)indexPath
                                           dataArray:(NSMutableArray *)dataArray
                                         accountInfo:(NSMutableDictionary *)accountInfo;

@end


@interface CustomTableViewGrouped : UIView

@property(nonatomic, strong) UITableView *myTableView;

/** 账号字典数据，用于储存账号和密码，使用登录时才有效*/
@property(nonatomic, strong) NSMutableDictionary *accountInfoDic;

/** 是否显示图标，YES显示，NO不显示*/
@property(nonatomic) BOOL isShowImage;
/** 第一个section是否显示头像，YES显示，NO不显示*/
@property(nonatomic) BOOL isShowHeadImage;
/** 是否显示账号图标，YES显示，NO不显示*/
@property(nonatomic) BOOL isShowAccountIcon;
/** cell类型*/
@property(nonatomic) UITableViewCellAccessoryType accessoryType;
/** head image cell类型*/
@property(nonatomic) UITableViewCellAccessoryType headImageAccessoryType;
/** 是否固定cell高度*/
@property(nonatomic) BOOL isFixedCellHeight;
/** 固定的cell高度*/
@property(nonatomic) CGFloat fixedCellHeight;

@property (nonatomic, assign) id<TableViewGroupedDidSelectRow> selectRowDelegate;//协议

/**
 *  初始化数据
 *
 *  @param dataArr 数据
 */
- (void)initData:(NSMutableArray *)dataArr;

/**
 *  初始化登录数据，特有的，只有账号、密码、登录三个数据
 */
- (void)initLoginData;

@end
