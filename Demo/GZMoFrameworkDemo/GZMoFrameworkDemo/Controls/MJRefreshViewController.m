//
//  MJRefreshViewController.m
//  CustomControls
//
//  Created by mojx on 16/8/31.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import "MJRefreshViewController.h"
#import "MJRefresh.h"

// 自定义的header
#import "MJChiBaoZiHeader.h"
#import "MJChiBaoZiFooter.h"
#import "MJChiBaoZiFooter2.h"
#import "MJDIYHeader.h"
#import "MJDIYAutoFooter.h"
#import "MJDIYBackFooter.h"

static const CGFloat MJDuration = 2.0;

#define kLimitLoadDataCount 5

/**
 * 随机数据
 */
#define MJRandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]

@interface MJRefreshViewController ()

@end

@implementation MJRefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //解决tableview内容下移64像素
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    dataArray = [[NSMutableArray alloc]init];
    
    //下拉刷新 默认
    //[self example01];
    
    //下拉刷新 动画图片
    //[self example02];
    
    //下拉刷新 隐藏时间
    //[self example03];
    
    //上拉刷新 默认
    //[self example11];

    //上拉刷新 动画图片 自定义数据
    [self example22];
}

#pragma mark - 示例代码
#pragma mark UITableView + 下拉刷新 默认
- (void)example01
{
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    
    // 马上进入刷新状态
    [self.myTableView.mj_header beginRefreshing];
}

#pragma mark UITableView + 下拉刷新 动画图片
- (void)example02
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.myTableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 马上进入刷新状态
    [self.myTableView.mj_header beginRefreshing];
}

#pragma mark UITableView + 下拉刷新 隐藏时间
- (void)example03
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 马上进入刷新状态
    [header beginRefreshing];
    
    // 设置header
    self.myTableView.mj_header = header;
}

#pragma mark UITableView + 上拉刷新 默认
- (void)example11
{
    [self example01];
    
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}

#pragma mark UITableView + 上拉刷新 动画图片
- (void)example12
{
    [self example01];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    self.myTableView.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

#pragma mark UITableView + 上拉刷新 隐藏刷新状态的文字
- (void)example13
{
    [self example01];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJChiBaoZiFooter *footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 当上拉刷新控件出现50%时（出现一半），就会自动刷新。这个值默认是1.0（也就是上拉刷新100%出现时，才会自动刷新）
    //    footer.triggerAutomaticallyRefreshPercent = 0.5;
    
    // 隐藏刷新状态的文字
    footer.refreshingTitleHidden = YES;
    
    // 设置footer
    self.myTableView.mj_footer = footer;
}

#pragma mark UITableView + 上拉刷新 动画图片 自定义数据
- (void)example22
{
    [self initDataArray];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJChiBaoZiFooter *footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMyMoreData)];

    // 设置文字
    [footer setTitle:@"点击或上拉加载更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"松开立即加载更多" forState:MJRefreshStatePulling];
    [footer setTitle:@"正在加载更多的数据..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"已经全部加载完毕" forState:MJRefreshStateNoMoreData];
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:15];
    // 设置颜色
    footer.stateLabel.textColor = [UIColor blueColor];
    
    // 设置footer
    self.myTableView.mj_footer = footer;
}

#pragma mark - 数据处理相关
#pragma mark 下拉刷新数据
- (void)loadNewData
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        //[dataArray insertObject:MJRandomData atIndex:0];
        NSString *str = [NSString stringWithFormat:@"数据---%d", i];
        [dataArray insertObject:str atIndex:0];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [_myTableView reloadData];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [_myTableView.mj_header endRefreshing];
    });
}

#pragma mark 上拉加载更多数据
- (void)loadMoreData
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        //[dataArray addObject:MJRandomData];
        NSString *str = [NSString stringWithFormat:@"数据---%d", i];
        [dataArray addObject:str];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [_myTableView reloadData];
        
        // 拿到当前的上拉刷新控件，结束刷新状态
        [_myTableView.mj_footer endRefreshing];
    });
}

#pragma mark 加载最后一份数据
- (void)loadLastData
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        //[self.data addObject:MJRandomData];
        NSString *str = [NSString stringWithFormat:@"数据---%d", i];
        [dataArray addObject:str];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [_myTableView reloadData];
        
        // 拿到当前的上拉刷新控件，变为没有更多数据的状态
        [_myTableView.mj_footer endRefreshingWithNoMoreData];
    });
}

#pragma mark 只加载一次数据
- (void)loadOnceData
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        //[self.data addObject:MJRandomData];
        NSString *str = [NSString stringWithFormat:@"数据---%d", i];
        [dataArray addObject:str];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [_myTableView reloadData];
        
        // 隐藏当前的上拉刷新控件
        _myTableView.mj_footer.hidden = YES;
    });
}

#pragma mark 初始化自定义数据
- (void)initDataArray
{
    allDataArray = [[NSMutableArray alloc]init];
    dataArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<30; i++)
    {
        NSString *str = [NSString stringWithFormat:@"数据---%d", i];
        [allDataArray addObject:str];
        if (i<kLimitLoadDataCount)
            [dataArray addObject:str];
    }
    loadDataCount = kLimitLoadDataCount;
}
#pragma mark 上拉加载更多自定义数据
- (void)loadMyMoreData
{
    //添加假数据
    if (loadDataCount < allDataArray.count - kLimitLoadDataCount)
    {
        for (int i = 0; i<kLimitLoadDataCount; i++,loadDataCount++)
        {
            NSString *str = [allDataArray objectAtIndex:loadDataCount];
            [dataArray addObject:str];
        }
        // 刷新表格
        [_myTableView reloadData];
        // 拿到当前的上拉刷新控件，结束刷新状态
        [_myTableView.mj_footer endRefreshing];
    }
    else
    {
        for (; loadDataCount<allDataArray.count; loadDataCount++)
        {
            NSString *str = [allDataArray objectAtIndex:loadDataCount];
            [dataArray addObject:str];
        }
        // 刷新表格
        [_myTableView reloadData];
        // 拿到当前的上拉刷新控件，变为没有更多数据的状态
        [_myTableView.mj_footer endRefreshingWithNoMoreData];
    }
}

#pragma mark tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if( cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //selectedCell = [indexPath row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"row: %ld", indexPath.row);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
