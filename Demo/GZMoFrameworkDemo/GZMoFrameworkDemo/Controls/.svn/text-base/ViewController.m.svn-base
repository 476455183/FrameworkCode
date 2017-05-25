//
//  ViewController.m
//  GZMoFrameworkDemo
//
//  Created by mojx on 16/8/16.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import "ViewController.h"
#import "ShowViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //解决tableview内容下移64像素
    self.automaticallyAdjustsScrollViewInsets = NO;
    //一句话解决所有TableView的多余cell
    [[UITableView appearance] setTableFooterView:[[UIView alloc]init]];
    
    [self initData];
}

- (void)initData
{
    // 创建自定义的View
    CustomTableViewPlain *customView = [[CustomTableViewPlain alloc] init];
    customView.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //customView.accessoryType = UITableViewCellAccessoryNone;
    customView.selectionStyle = UITableViewCellSelectionStyleDefault;
    customView.selectRowDelegate = self;
    customView.deselectRowAnimated = YES;
    // 设置frame
    customView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64);
    
    // 设置数据
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    [dataArray addObject:@"0-调用公共功能函数示例"];
    [dataArray addObject:@"1-TableView示例：数据展示"];
    [dataArray addObject:@"2-TableView示例：数据展示+图片展示"];
    [dataArray addObject:@"3-TableView示例：不带图标的数据分组展示"];
    [dataArray addObject:@"4-TableView示例：带图标的数据分组展示"];
    [dataArray addObject:@"5-TableView示例：带头像带图标的数据分组展示"];
    [dataArray addObject:@"6-TableView示例：不带图标的账号登录展示"];
    [dataArray addObject:@"7-TableView示例：带图标的账号登录展示"];
    [dataArray addObject:@"8-ScrollView示例：图片滚动展示"];
    [dataArray addObject:@"9-CollectionView示例：图标数据分布式展示"];
    [dataArray addObject:@"10-MoCATransition动画示例"];
    [dataArray addObject:@"11-MBProgressHUD"];
    [dataArray addObject:@"12-MJRefresh"];
    [dataArray addObject:@"13-TableView示例：带属性的数据展示"];
    [dataArray addObject:@"14-TableView示例：带图片带属性的数据展示"];
    [dataArray addObject:@"15-ImagePicker示例：拍照、相册、图库"];
    [dataArray addObject:@"16-ScrollView示例：启动引导图展示"];
    [dataArray addObject:@"17-QRCode：二维码条形码扫描"];
    [dataArray addObject:@"18-DropdownMenu：下拉菜单"];
    [dataArray addObject:@"19-弹出菜单"];
    [dataArray addObject:@"20-WebView示例：访问网页"];
    [dataArray addObject:@"21-WebView示例：webview缓存（离线浏览）"];
    [dataArray addObject:@"22-UUChart示例：图表"];
    [dataArray addObject:@"23-JSON解析"];
    [dataArray addObject:@"24-数据加解密"];
    [dataArray addObject:@"25-网络请求GET、POST等"];
    [dataArray addObject:@"26-SDWebImage图片缓存"];
    [dataArray addObject:@"27-音视频"];
    [dataArray addObject:@"28-日期时间选择"];
    [dataArray addObject:@"29-消息提醒"];
    [customView initData:dataArray color:[UIColor blackColor] font:[UIFont systemFontOfSize:13] cellHieghtOffset:20];
    
    // 添加子控件
    [self.view addSubview:customView];
}

#pragma mark - 实现CustomTableViewPlain中TableViewPlainDidSelectRow协议中的方法
- (void)tableViewPlainDidSelectRowAtIndexPath:(NSIndexPath *)indexPath dataArray:(NSMutableArray *)dataArray
{
    titleText = [dataArray objectAtIndex:indexPath.row];
    selectedCell = indexPath.row;
    NSLog(@"row: %ld; value: %@", indexPath.row, titleText);
    
    if (selectedCell == 10)
        [self performSegueWithIdentifier:@"id_AnimationViewController" sender:self];
    else if (selectedCell == 11)
        [self performSegueWithIdentifier:@"id_MBHudDemoViewController" sender:self];
    else if (selectedCell == 12)
        [self performSegueWithIdentifier:@"id_MJRefreshViewController" sender:self];
    else if (selectedCell == 25)
        [self performSegueWithIdentifier:@"id_NetworkViewController" sender:self];
    else if (selectedCell == 26)
        [self performSegueWithIdentifier:@"id_LoadImageViewController" sender:self];
    else if (selectedCell == 27)
        [self performSegueWithIdentifier:@"id_AudioVideoViewController" sender:self];
    else
        [self performSegueWithIdentifier:@"id_ShowViewController" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    
    if ([segue.identifier isEqualToString:@"id_ShowViewController"])
    {
        ShowViewController *viewc =  segue.destinationViewController;
        viewc.title = @"示例";
        viewc.parentSelectedCell = selectedCell;
    }
}

@end
