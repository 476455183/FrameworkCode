//
//  ShowViewController.h
//  GZMoFrameworkDemo
//
//  Created by mojx on 16/8/16.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GZMoFramework/GZMoFramework.h>

@interface ShowViewController : UIViewController<TableViewPlainDidSelectRow, TableViewGroupedDidSelectRow, CollectionViewDidSelectRow, GuideViewDidTap, UUChartDataSource>
{
    CustomTableViewPlain *tableViewPlain;
    CustomTableViewGrouped *tableViewGrouped;
    CustomGuideView *guideView;
    
    /** 消息记录值*/
    long myBadgeValue;
    /** 显示消息的view*/
    RKNotificationHub *hub_badgeView;
    /** 显示消息的view*/
    UIView *badgeView;
}

@property (nonatomic) NSInteger parentSelectedCell;

@end
