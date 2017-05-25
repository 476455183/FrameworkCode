//
//  MJRefreshViewController.h
//  CustomControls
//
//  Created by mojx on 16/8/31.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJRefreshViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataArray, *allDataArray;
    NSInteger loadDataCount;
}

@property (nonatomic,weak) IBOutlet UITableView *myTableView;

@end
