//
//  ShowViewController.m
//  GZMoFrameworkDemo
//
//  Created by mojx on 16/8/16.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import "ShowViewController.h"
#import <CommonCrypto/CommonCryptor.h>//des、3des、aes

#define kNavigationBarbarTintColor 0x17BDDF

/*
   说明：此DEMO为调用通用库范例，请严格按范例进行调用和使用。
*/

@interface ShowViewController ()

@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //解决tableview内容下移64像素
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initData];
    switch (self.parentSelectedCell)
    {
        case 0:
            [self sample0];
            break;
        case 1:
            [self sample1];
            break;
        case 2:
            [self sample2];
            break;
        case 3:
            [self sample3];
            break;
        case 4:
            [self sample4];
            break;
        case 5:
            [self sample5];
            break;
        case 6:
            [self sample6];
            break;
        case 7:
            [self sample7];
            break;
        case 8:
            [self sample8];
            break;
        case 9:
            [self sample9];
            break;
        case 13:
            [self sample13];
            break;
        case 14:
            [self sample14];
            break;
        case 15:
            [self sample15];
            break;
        case 16:
            [self sample16];
            break;
        case 17:
            [self sample_QRCode];
            break;
        case 18:
            [self sample_DropdownMenu];
            break;
        case 19:
            [self sample19];
            break;
        case 20:
            [self sample_Web];
            break;
        case 21:
            [self sample_WebCache];
            break;
        case 22:
            [self sample_UUChart];
            break;
        case 23:
            [self sample_JSON];
            break;
        case 24:
            [self sample_EncryptDecrypt];
            break;
        case 28:
            [self sample_DatePicker];
            break;
        case 29:
            [self sample_badgeValue];
            break;
        default:
            break;
    }
}

- (void)viewWillDisappear:(BOOL)animated;
{
    if (guideView) {
        [guideView stopGuideViewTime];
    }
}

//初始化数据
- (void)initData
{
    // 创建自定义的View
    tableViewPlain = [[CustomTableViewPlain alloc] init];
    //tableViewPlain.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    tableViewPlain.accessoryType = UITableViewCellAccessoryNone;
    tableViewPlain.selectionStyle = UITableViewCellSelectionStyleDefault;
    tableViewPlain.selectRowDelegate = self;
    tableViewPlain.deselectRowAnimated = YES;
    // 设置frame
    tableViewPlain.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64);
    // 添加子控件
    [self.view addSubview:tableViewPlain];
    
    // 创建自定义的View
    tableViewGrouped = [[CustomTableViewGrouped alloc] init];
    tableViewGrouped.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //tableViewGrouped.accessoryType = UITableViewCellAccessoryNone;
    tableViewGrouped.selectRowDelegate = self;
    // 设置frame
    tableViewGrouped.frame = CGRectMake(0, 49, self.view.frame.size.width, self.view.frame.size.height - 49);
    [self.view addSubview:tableViewGrouped];
}

//调用公共功能函数示例
- (void)sample0
{
    NSString *birthdate = @"2000-08-01 8:00:00";
    NSString *age = [GZPublicMethod userAge:birthdate];
    NSString *message = [NSString stringWithFormat:@"您的出生日期为：%@；年龄为：%@岁",birthdate, age];
    [GZPublicMethod showAlertOK:message control:self];
}

//TableView示例：数据展示
- (void)sample1
{
    [tableViewGrouped setHidden:YES];
    
    // 设置数据
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    [dataArray addObject:@"数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据"];
    [dataArray addObject:@"数据数据数据数据"];
    [tableViewPlain initData:dataArray color:[UIColor blackColor] font:[UIFont systemFontOfSize:13] cellHieghtOffset:30];
}

//TableView示例：数据展示+图片展示
- (void)sample2
{
    [tableViewGrouped setHidden:YES];
    
    // 设置数据
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数据数" forKey:@"value"];
    [dic setObject:[UIImage imageNamed:@"000"] forKey:@"image"];
    [dataArray addObject:dic];
    [dataArray addObject:dic];
    
    //图片不带圆角显示
    //[tableViewPlain initData:dataArray color:[UIColor blackColor] font:[UIFont systemFontOfSize:13] imageSize:CGSizeMake(100, 60) cornerRadius:0 cellHieghtOffset:30];
    
    //图片带圆角显示
    [tableViewPlain initData:dataArray color:[UIColor blackColor] font:[UIFont systemFontOfSize:13] imageSize:CGSizeMake(60, 60) cornerRadius:30 cellHieghtOffset:30];
    
    //设置固定cell高度
    //tableViewPlain.isFixedCellHeight = YES;
    //tableViewPlain.fixedCellHeight = 30;
}

//TableView示例：不带图标的数据分组展示
- (void)sample3
{
    [tableViewPlain setHidden:YES];
    
    // 设置数据
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    
    //0
    NSMutableArray *group = [[NSMutableArray alloc]init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"问题反馈" forKey:@"value"];
    [group addObject:dic];
    dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"关于我们" forKey:@"value"];
    [group addObject:dic];
    [dataArray addObject:group];
    
    //1
    group = [[NSMutableArray alloc]init];
    dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"退出登录" forKey:@"value"];
    [group addObject:dic];
    [dataArray addObject:group];
    
    [tableViewGrouped initData:dataArray];
}

//TableView示例：带图标的数据分组展示
- (void)sample4
{
    [tableViewPlain setHidden:YES];
    tableViewGrouped.isShowImage = YES;
    
    // 设置数据
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    
    //0
    NSMutableArray *group = [[NSMutableArray alloc]init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[UIImage imageNamed:@"setting"] forKey:@"image"];
    [dic setObject:@"问题反馈" forKey:@"value"];
    [group addObject:dic];
    dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[UIImage imageNamed:@"setting"] forKey:@"image"];
    [dic setObject:@"关于我们" forKey:@"value"];
    [group addObject:dic];
    [dataArray addObject:group];
    
    //1
    group = [[NSMutableArray alloc]init];
    dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[UIImage imageNamed:@"setting"] forKey:@"image"];
    [dic setObject:@"退出登录" forKey:@"value"];
    [group addObject:dic];
    [dataArray addObject:group];
    
    [tableViewGrouped initData:dataArray];
}

//TableView示例：带头像带图标的数据分组展示
- (void)sample5
{
    [tableViewPlain setHidden:YES];
    tableViewGrouped.isShowImage = YES;
    tableViewGrouped.isShowHeadImage = YES;
    //tableViewGrouped.headImageAccessoryType = UITableViewCellAccessoryNone;
    tableViewGrouped.headImageAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // 设置数据
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    
    //0
    NSMutableArray *group = [[NSMutableArray alloc]init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[UIImage imageNamed:@"000"] forKey:@"image"];
    [dic setObject:@"客服：陈好好\r\n\n工号：123456" forKey:@"value"];
    [group addObject:dic];
    [dataArray addObject:group];
    
    //1
    group = [[NSMutableArray alloc]init];
    dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[UIImage imageNamed:@"setting"] forKey:@"image"];
    [dic setObject:@"问题反馈" forKey:@"value"];
    [group addObject:dic];
    dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[UIImage imageNamed:@"setting"] forKey:@"image"];
    [dic setObject:@"关于我们" forKey:@"value"];
    [group addObject:dic];
    [dataArray addObject:group];
    
    //2
    group = [[NSMutableArray alloc]init];
    dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[UIImage imageNamed:@"setting"] forKey:@"image"];
    [dic setObject:@"退出登录" forKey:@"value"];
    [group addObject:dic];
    [dataArray addObject:group];
    
    [tableViewGrouped initData:dataArray];
}

//TableView示例：不带图标的账号登录展示
- (void)sample6
{
    [tableViewPlain setHidden:YES];
    tableViewGrouped.accessoryType = UITableViewCellAccessoryNone;
    //tableViewGrouped.myTableView.scrollEnabled = NO; //设置tableview不能滚动

    //初始化登录数据
    [tableViewGrouped initLoginData];
    //设置转默认的账号和密码
    [tableViewGrouped.accountInfoDic setObject:@"haha" forKey:@"name"];
    [tableViewGrouped.accountInfoDic setObject:@"123456" forKey:@"password"];
}

//TableView示例：带图标的账号登录展示
- (void)sample7
{
    [tableViewPlain setHidden:YES];
    tableViewGrouped.accessoryType = UITableViewCellAccessoryNone;
    //tableViewGrouped.myTableView.scrollEnabled = NO; //设置tableview不能滚动
    
    //初始化登录数据
    [tableViewGrouped initLoginData];
    //设置转默认的账号和密码
    [tableViewGrouped.accountInfoDic setObject:@"haha" forKey:@"name"];
    [tableViewGrouped.accountInfoDic setObject:@"123456" forKey:@"password"];
    [tableViewGrouped.accountInfoDic setObject:[UIImage imageNamed:@"setting"] forKey:@"name_image"];
    [tableViewGrouped.accountInfoDic setObject:[UIImage imageNamed:@"setting"] forKey:@"password_image"];
    tableViewGrouped.isShowAccountIcon = YES;
}

//ScrollView示例：图片滚动展示
- (void)sample8
{
    [tableViewPlain setHidden:YES];
    [tableViewGrouped setHidden:YES];
    [guideView removeFromSuperview];
    
    // 创建自定义的View
    guideView = [[CustomGuideView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 160)];
    guideView.imageTapDelegate = self;
    //是否允许左右循环拖动
    guideView.isCycleDragging = YES;
    //初始化数组，存储滚动视图的图片
    NSMutableArray *imageArray = [[NSMutableArray alloc]init];
    [imageArray addObject:[UIImage imageNamed:@"000"]];
    [imageArray addObject:[UIImage imageNamed:@"000"]];
    [imageArray addObject:[UIImage imageNamed:@"000"]];
    
    UIColor *color1 = [UIColor colorWithRed:0.2 green:0.8 blue:0.8 alpha:1.0];
    UIColor *color2 = [UIColor whiteColor];
    
    [guideView initGuideView:imageArray isShowExperienceButton:NO experienceButtonSize:CGSizeZero viewControl:nil pageSelectedColor:color1 pageNonSelectedColor:color2];
    //定时改变引导图片，如不使用时可注释掉此项
    [guideView changeGuideViewWithTimeInterval:5.0];
    
    // 添加子控件
    [self.view addSubview:guideView];
}

//CollectionView示例：图标数据分布式展示
- (void)sample9
{
    [tableViewPlain setHidden:YES];
    [tableViewGrouped setHidden:YES];
    
    NSArray *myDataArray = [[NSArray alloc]initWithObjects:@"数据数据",@"数据数据",@"数据数据",@"数据数据",@"数据数据",@"数据数据",@"数据数据",@"数据数据",@"数据数据",@"数据数据",@"数据数据",@"数据数据",@"数据数据",@"数据数据",@"数据数据",@"数据数据",nil];
    NSArray *myImageArray = [[NSArray alloc]initWithObjects:@"setting",@"setting",@"setting",@"setting",@"setting",@"setting",@"setting",@"setting",@"setting",@"setting",@"setting",@"setting",@"setting",@"setting",@"setting",@"setting",nil];
    
    CustomCollectionView *customView = [[CustomCollectionView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
    //设置CollectionView背景
    //UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"000"]];
    //imageView.alpha = 0.1;
    //customView.myCollectionView.backgroundView = imageView;
    customView.selectRowDelegate = self;
    customView.dataArray = myDataArray;
    customView.imageArray = myImageArray;
    [self.view addSubview:customView];
}

//TableView示例：带属性的数据展示（AttributedText）
- (void)sample13
{
    [tableViewGrouped setHidden:YES];
    
    // 设置数据
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"参保基本信息" forKey:@"title"];
    
    NSMutableArray *data = [[NSMutableArray alloc]init];
    [data addObject:@"姓      名：陈好好"];
    [data addObject:@"性      别：女"];
    [data addObject:@"民      族：汉"];
    [data addObject:@"身份证号：441228888888888888"];
    [data addObject:@"联系电话：15900000000"];
    [data addObject:@"单位名称：广州东风汽车有限公司"];
    [data addObject:@"人员状态：在职"];
    [data addObject:@"社保卡号：24899988"];
    [data addObject:@"参保状态：正在参保"];
    
    NSString *text = @"";
    for (int i=0; i< data.count; i++)
    {
        NSString *str = [NSString stringWithFormat:@"%@\r\n", [data objectAtIndex:i]];
        text = [text stringByAppendingString:str];
    }
    text = [text stringByAppendingString:@"\r\n"];
    
    [dic setObject:text forKey:@"value"];
    [dataArray addObject:dic];
    [dataArray addObject:dic];
    [dataArray addObject:dic];
    
    UIColor *color = UIColorFromRGB(0x17BDDF);
    [tableViewPlain initData:dataArray titleColor:color valueColor:[UIColor blackColor] font:[UIFont systemFontOfSize:13] spacing:2.0 cellHieghtOffset:50];
}

//image and AttributedText
- (void)sample14
{
    [tableViewGrouped setHidden:YES];
    
    // 设置数据
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"李珊珊" forKey:@"title"];
    [dic setObject:@"主任医师\r\n擅长：坐骨神经、风湿骨疼、手脚麻等" forKey:@"sub_title"];
    [dic setObject:[UIImage imageNamed:@"girl_001"] forKey:@"image"];
    [dataArray addObject:dic];
    [dataArray addObject:dic];
    
    [tableViewPlain initData:dataArray titleColor:[UIColor blackColor] titleFont:[UIFont systemFontOfSize:15] subTitleColor:[UIColor grayColor] subTitleFont:[UIFont systemFontOfSize:13] spacing:2 imageSize:CGSizeMake(60, 60) cornerRadius:30 cellHieghtOffset:30];
}

//ImagePicker示例：拍照、相册、图库
- (void)sample15
{
    [tableViewPlain setHidden:YES];
    [tableViewGrouped setHidden:YES];
    
    [CustomImagePicker sharedSingleton].viewControl = self;
    [[CustomImagePicker sharedSingleton] takeAPhoto];
    //回调
    [CustomImagePicker sharedSingleton].ImagePickerBlock = ^(UIImage *image)
    {
        NSLog(@"%f, %f", image.size.width, image.size.height);
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
        imageview.image = image;
        [self.view addSubview:imageview];
    };
}

//ScrollView示例：启动引导图展示
- (void)sample16
{
    [tableViewPlain setHidden:YES];
    [tableViewGrouped setHidden:YES];
    [guideView removeFromSuperview];
    
    // 创建自定义的View
    //guideView = [[CustomGuideView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 160)];
    guideView = [[CustomGuideView alloc] initWithFrame:self.view.frame];
    guideView.imageTapDelegate = self;
    //初始化数组，存储滚动视图的图片
    NSMutableArray *imageArray = [[NSMutableArray alloc]init];
    [imageArray addObject:[UIImage imageNamed:@"000"]];
    [imageArray addObject:[UIImage imageNamed:@"000"]];
    [imageArray addObject:[UIImage imageNamed:@"000"]];
    
    UIColor *color1 = [UIColor colorWithRed:0.2 green:0.8 blue:0.8 alpha:1.0];
    UIColor *color2 = [UIColor whiteColor];
    
    [guideView initGuideView:imageArray isShowExperienceButton:YES experienceButtonSize:CGSizeMake(206, 50) viewControl:self pageSelectedColor:color1 pageNonSelectedColor:color2];
    
    // 添加子控件
    [self.view addSubview:guideView];
}

//QRCode：二维码条形码扫描
- (void)sample_QRCode
{
    // 创建自定义的View
    QRCodeView *customView = [[QRCodeView alloc] initWithFrame:CGRectMake(0, 49, self.view.frame.size.width, self.view.frame.size.height - 49) controller:self];
    //customView.isShowQrcodeButton = NO;
    [self.view addSubview:customView];
}

//DropdownMenu：下拉菜单
- (void)sample_DropdownMenu
{
    // 创建自定义的View
    CustomDropdownMenu *customView = [[CustomDropdownMenu alloc] init];
    customView.isDidSelectHideMenu = YES;
    // 设置frame
    customView.frame = CGRectMake(0, 64, self.view.frame.size.width, 250);
    
    NSMutableArray *titles = [[NSMutableArray alloc]init];
    [titles addObject:@"附近"];
    // 设置数据
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    [dataArray addObject:@"附近"];
    [dataArray addObject:@"熱門商區"];
    [dataArray addObject:@"香洲區"];
    [dataArray addObject:@"斗門區"];
    [dataArray addObject:@"金灣區"];
    [customView initData:dataArray dropdownMenuType:0 titles:titles titleColor:[UIColor blackColor] lineColor:[UIColor whiteColor] valueColor:[UIColor blackColor] font:[UIFont systemFontOfSize:13] cellHieght:44 backgroundColor:[UIColor orangeColor] selectedIndex:0 selectedIndexEnable:YES imageAlignment:0];
    // 添加子控件
    [self.view addSubview:customView];
    customView.myBlock = ^(NSInteger leftIndex, NSInteger rightIndex, NSString *leftData, NSString *rightData)
    {
        NSLog(@"%ld, %ld, %@, %@", leftIndex,rightIndex, leftData, rightData);
    };
    
    // 添加子控件
    [self.view addSubview:customView];
}

//弹出菜单
- (void)sample19
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(20, 164, 150, 40);
    button.backgroundColor = [UIColor greenColor];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitle:@"菜单选择" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)showMenu:(UIButton *)sender
{
    NSMutableArray *menuItems = [[NSMutableArray alloc]init];
    KxMenuItem *menu = [KxMenuItem menuItem:@"请选择菜单"
                                      image:nil
                                     target:nil
                                     action:NULL];
    menu.alignment = NSTextAlignmentCenter;
    [menuItems addObject:menu];
    
    for (int i=0; i<3; i++)
    {
        NSString *str_menu = [NSString stringWithFormat:@"girl%d", i];
        menu = [KxMenuItem menuItem:str_menu
                              image:[UIImage imageNamed:@"girl_001"]
                             target:self
                             action:@selector(pushMenuItem:)];
        menu.tag = i;
        [menuItems addObject:menu];
    }
    
    //设置弹出菜单
    [KxMenu setTintColor:UIColorFromRGB(kNavigationBarbarTintColor)];
    [KxMenu showMenuInView:self.view fromRect:sender.frame menuItems:menuItems menuOriginYOffset:0];
    //[KxMenu dismissMenu];
}

//菜单选择事件
- (void)pushMenuItem:(id)sender
{
    KxMenuItem *menu = (KxMenuItem *)sender;
    NSLog(@"title: %@; tag: %ld", menu.title, menu.tag);
}

//WebView示例：访问网页
- (void)sample_Web
{
    //创建自定义的View
    CustomWebView *webview = [[CustomWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
    //添加子控件
    [self.view addSubview:webview];
    
    //加载url
    NSString *url = @"http://www.baidu.com";
    [webview loadWebRequestWithUrl:url];
}

- (void)sample_WebCache
{
    //注册用于webview缓存的类
    [NSURLProtocol registerClass:[TURLSessionProtocol class]];
    
    NSString *urlstring = @"http://jingyan.baidu.com/article/335530da74ac4f19cb41c3b2.html";
    //NSString *urlstring = @"http://www.baidu.com";
    //NSString *urlstring = @"http://www.cankaoxiaoxi.com/roll10/bd/20160728/1248545.shtml";
    //NSString *urlstring = @"http://yiyuguancha.baijia.baidu.com/article/560322";
    NSURL *webUrl=[[NSURL alloc] initWithString:[urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //NSURL *webUrl=[[NSURL alloc] initWithString:urlstring];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:webUrl];
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
    [webView loadRequest:request];
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
}

- (void)sample_UUChart
{
    UUChart *chartView = [[UUChart alloc]initWithFrame:CGRectMake(10, 89, [UIScreen mainScreen].bounds.size.width-20, 250)dataSource:self style:UUChartStyleLine];
    [chartView showInView:self.view];
    
    UUChart *chartView2 = [[UUChart alloc]initWithFrame:CGRectMake(10, 360, [UIScreen mainScreen].bounds.size.width-20, 250)dataSource:self style:UUChartStyleBar];
    [chartView2 showInView:self.view];
}

//----------------------
#pragma mark - 图表

- (NSArray *)getXTitles:(int)num
{
    NSMutableArray *xTitles = [NSMutableArray array];
    for (int i=0; i<num; i++) {
        NSString * str = [NSString stringWithFormat:@"R-%d",i];
        [xTitles addObject:str];
    }
    return xTitles;
}


#pragma mark - @required

//横坐标标题数组
- (NSArray *)chartConfigAxisXLabel:(UUChart *)chart
{
    return [self getXTitles:10];
}

//数值多重数组（图表显示多少组数据）
- (NSArray *)chartConfigAxisYValue:(UUChart *)chart
{
    NSArray *ary1 = @[@"22",@"54",@"15",@"30",@"42",@"77",@"43"];
    NSArray *ary2 = @[@"76",@"34",@"54",@"23",@"16",@"32",@"17"];
    
    //return @[ary1];//显示一组数据
    return @[ary1,ary2];//显示两组数据
}


#pragma mark - @optional

//颜色数组
- (NSArray *)chartConfigColors:(UUChart *)chart
{
    return @[[UUColor green],[UUColor red],[UUColor brown]];
}

//纵坐标显示数值范围
- (CGRange)chartRange:(UUChart *)chart
{
    //return CGRangeZero;
    return CGRangeMake(100, 10);//数值范围从高到低
}


#pragma mark 折线图专享功能

//标记数值区域（数据区域填充背景）
- (CGRange)chartHighlightRangeInLine:(UUChart *)chart
{
    //return CGRangeMake(22, 50);
    return CGRangeZero;
}

//判断显示横线条
- (BOOL)chart:(UUChart *)chart showHorizonLineAtIndex:(NSInteger)index
{
    return YES;
}

//判断是否显示数据的最大和最小值
- (BOOL)chart:(UUChart *)chart showMaxMinAtIndex:(NSInteger)index
{
    return YES;
}
//------------------------

//JSON解析
- (void)sample_JSON
{
    //1.字典转json字符串
    NSMutableDictionary *jsonDic = [[NSMutableDictionary alloc]init];
    [jsonDic setObject:@"aa" forKey:@"person_name"];//姓名
    [jsonDic setObject:@"1" forKey:@"sex"];//性别：1男 0女
    [jsonDic setObject:@"15900000000" forKey:@"contact_phone"];//联系电话
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [array addObject:@"info1"];
    [array addObject:@"info2"];
    [jsonDic setObject:array forKey:@"remark"];
    
    NSString *json = [GZPublicMethod jsonStringWithDictionary:jsonDic];
    NSLog(@"json: %@", json);
    /*
     2016-09-18 10:51:13.927 CustomControls[31752:1433091] json: {"sex":"1","person_name":"aa","contact_phone":"15900000000","remark":["info1","info2"]}
     即：
     {
     "sex": "1",
     "person_name": "aa",
     "contact_phone": "15900000000",
     "remark": [
     "info1",
     "info2"
     ]
     }
     */
    
    //2.json字符串转字典
    jsonDic = [[NSMutableDictionary alloc]init];
    jsonDic = [GZPublicMethod jsonDictionaryWithString:json];
    NSLog(@"jsonDic: %@", jsonDic);
    /*
     2016-09-18 11:14:50.269 CustomControls[31942:1451807] jsonDic: {
     "contact_phone" = 15900000000;
     "person_name" = aa;
     remark =     (
     info1,
     info2
     );
     sex = 1;
     }
     */
    
    //3.json字符串与nsdata相互转换，nsdata转字典
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding]; //NSString转NSData
    json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];//NSData转NSString
    NSLog(@"json: %@",json);
    
    NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSLog(@"dic: %@",dic);
    /*
     2016-09-18 11:25:06.180 CustomControls[31998:1457743] dic: {
     "contact_phone" = 15900000000;
     "person_name" = aa;
     remark =     (
     info1,
     info2
     );
     sex = 1;
     }
     */
    
    //4.jsonkit json字符串转字典
    //NSMutableDictionary *result = [json objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    //NSLog(@"result: %@",result);
}

//数据加解密
- (void)sample_EncryptDecrypt
{
    //MD5字符串加密
    NSString *md5Str = [MySecurity md5String:@"我爱你" encryptionLength:16 isLowerCase:NO];
    NSLog(@"md5Str is %@", md5Str);//Log is 4F2016C6B934D55BD7120E5D0E62CCE3
    //base64编码字符串
    NSString *base64Str = [MySecurity base64StringFromText:@"我爱你"];
    NSLog(@"base64Str is %@",base64Str);//Log is 5oiR54ix5L2g
    //base64反编码
    NSString *originalBase64Str = [MySecurity textFromBase64String:base64Str];
    NSLog(@"originalBase64Str is %@",originalBase64Str);//Log is  我爱你
    //DES加密
    NSString *desEncryptStr = [MySecurity encryptWithDESSting:@"我爱你" key:@"521" andDesiv:@"521"];
    NSLog(@"desEncryptStr is %@",desEncryptStr);//Log is  389280aa791ee933
    //DES解密
    NSString *desDecryptStr =[MySecurity decryptWithDESString:desEncryptStr key:@"521" andiV:@"521"];
    NSLog(@"desDecryptStr is %@",desDecryptStr);//Log is  我爱你
    //AES128加密
    NSData *aesEncryptData = [MySecurity AES128EncryptWithKey:@"521" iv:@"521" withNSData:[@"我爱你" dataUsingEncoding:NSUTF8StringEncoding]];
    //AES128解密
    NSData *aesDecryptData = [MySecurity AES128DecryptWithKey:@"521" iv:@"521" withNSData:aesEncryptData];
    //NSData转NSString
    NSString *aesDecryptStr = [[NSString alloc] initWithData:aesDecryptData encoding:NSUTF8StringEncoding];
    NSLog(@"aesDecryptStr: %@",aesDecryptStr);//Log is  我爱你
    
    //将AES加密后的数据转base64编码字符串
    NSString *aesEncryptBase64Str = [MySecurity base64EncodedStringFrom:aesEncryptData];
    NSLog(@"aesEncryptBase64Str is %@",aesEncryptBase64Str);//Log is HZKhnRLlQ8XjMjpelOAwsQ==
    
    aesDecryptStr = [MySecurity base64EncodedStringFrom:aesDecryptData];
    NSString *result = [MySecurity textFromBase64String:aesDecryptStr];
    NSLog(@"aesDEStr is %@ and result is %@",aesDecryptStr,result);//Log is aesDEStr is 5oiR54ix5L2gAAAAAAAAAA== and result is 我爱你
    
    //AES256加密
    NSData *aes256EncryptData = [MySecurity AES256EncryptWithKey:@"521" encryptData:[@"我爱你" dataUsingEncoding:NSUTF8StringEncoding]];
    //将AES256加密后的数据转base64编码字符串
    NSString *aes256EncryptStr = [MySecurity base64EncodedStringFrom:aes256EncryptData];
    NSLog(@"aes256EncryptStr: %@",aes256EncryptStr);//Log is  iEvCbwiAEaqZOnCx4ERkCQ==
    //AES256解密
    NSData *aes256DecryptData = [MySecurity AES256DecryptWithKey:@"521" decryptData:aes256EncryptData];
    //NSData转NSString
    NSString *aes256DecryptStr = [[NSString alloc] initWithData:aes256DecryptData encoding:NSUTF8StringEncoding];
    NSLog(@"aes256DecryptStr: %@",aes256DecryptStr);//Log is  我爱你
    
    //3des加密
    NSString *des3EncryptStr = [MySecurity tripleDES:@"我爱你" encryptOrDecrypt:kCCEncrypt key:@"512"];
    NSLog(@"des3EncryptStr: %@",des3EncryptStr);//Log is  QUnVqApvPoyCmy/P2GZbRw==
    //3des解密
    NSString *des3DecryptStr = [MySecurity tripleDES:des3EncryptStr encryptOrDecrypt:kCCDecrypt key:@"512"];
    NSLog(@"des3DecryptStr: %@",des3DecryptStr);//Log is  我爱你
}

//日期时间选择
- (void)sample_DatePicker
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.tag = 0;
    button.frame = CGRectMake(10, 164, 100, 40);
    button.backgroundColor = [UIColor greenColor];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitle:@"日期选择" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showDatePicker:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.tag = 1;
    button.frame = CGRectMake(120, 164, 100, 40);
    button.backgroundColor = [UIColor greenColor];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitle:@"时间选择" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showDatePicker:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.tag = 2;
    button.frame = CGRectMake(230, 164, 100, 40);
    button.backgroundColor = [UIColor greenColor];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitle:@"日期和时间选择" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showDatePicker:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

//显示日期时间
- (void)showDatePicker:(UIButton *)sender
{
    if (sender.tag == 0)
    {
        [GZPublicMethod showSelectDatePicker:@"请选择日期" showDate:@"2016-12-01" mode:UIDatePickerModeDate format:@"yyyy-MM-dd" viewControl:self selectedDate:^(NSString *myDate)
         {
             NSLog(@"myDate: %@", myDate);
         }];
    }
    else if (sender.tag == 1)
    {
        [GZPublicMethod showSelectDatePicker:@"请选择时间" showDate:@"12:01:01" mode:UIDatePickerModeTime format:@"HH:mm:ss" viewControl:self selectedDate:^(NSString *myDate)
         {
             NSLog(@"myDate: %@", myDate);
         }];
    }
    else if (sender.tag == 2)
    {
        [GZPublicMethod showSelectDatePicker:@"请选择日期和时间" showDate:@"2016-12-01 12:01:01" mode:UIDatePickerModeDateAndTime format:@"yyyy-MM-dd HH:mm:ss" viewControl:self selectedDate:^(NSString *myDate)
         {
             NSLog(@"myDate: %@", myDate);
         }];
    }
}

//消息提醒
- (void)sample_badgeValue
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.tag = 0;
    button.frame = CGRectMake(10, 164, 100, 40);
    button.backgroundColor = [UIColor greenColor];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitle:@"消息提醒" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(changeBadgeValue:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    //设置消息提醒
    badgeView = [[UIView alloc]initWithFrame:CGRectMake(120, 164, 100, 40)];
    badgeView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:badgeView];
    hub_badgeView = [[RKNotificationHub alloc] initWithView:badgeView];
    [hub_badgeView setCount:0];
}

//修改消息提醒
- (void)changeBadgeValue:(UIButton *)sender
{
    myBadgeValue++;
    if (myBadgeValue > 10)
        myBadgeValue = 0;
    [hub_badgeView setCount:myBadgeValue];
}

#pragma mark - 实现CustomTableViewPlain中TableViewPlainDidSelectRow协议中的方法
- (void)tableViewPlainDidSelectRowAtIndexPath:(NSIndexPath *)indexPath dataArray:(NSMutableArray *)dataArray
{
    NSLog(@"row: %ld; value: %@", indexPath.row, [dataArray objectAtIndex:indexPath.row]);
}

#pragma mark - 实现CustomTableViewGrouped中TableViewGroupedDidSelectRow协议中的方法
- (void)tableViewGroupedDidSelectRowAtIndexPath:(NSIndexPath *)indexPath dataArray:(NSMutableArray *)dataArray
{
    NSMutableArray *array = dataArray[indexPath.section];
    NSMutableDictionary *dic = [array objectAtIndex:indexPath.row];
    NSLog(@"row: %ld; value: %@", indexPath.row, [dic objectForKey:@"value"]);
}

#pragma mark - 实现CustomTableViewGrouped中tableViewGroupedLoginDidSelectRowAtIndexPath协议中的方法
- (void)tableViewGroupedLoginDidSelectRowAtIndexPath:(NSIndexPath *)indexPath
                                    dataArray:(NSMutableArray *)dataArray
                                  accountInfo:(NSMutableDictionary *)accountInfo
{
    NSMutableArray *array = dataArray[indexPath.section];
    NSMutableDictionary *dic = [array objectAtIndex:indexPath.row];
    NSLog(@"row: %ld; value: %@; accountInfo: %@", indexPath.row, [dic objectForKey:@"value"], accountInfo);
}

#pragma mark - 实现CustomCollectionView中CollectionViewDidSelectRow协议中的方法
- (void)collectionViewDidSelectRowAtIndexPath:(NSIndexPath *)indexPath dataArray:(NSArray *)dataArray
{
    NSLog(@"row: %ld; value: %@", indexPath.row, [dataArray objectAtIndex:indexPath.row]);
}

#pragma mark - 实现CustomGuideView中GuideViewDidTap协议中的方法
- (void)guideViewImageTap:(NSInteger)tag
{
    NSLog(@"tag: %ld", tag);
}

#pragma mark - 实现CustomGuideView中guideViewTimerEvent协议中的方法(引导定时器事件)
- (void)guideViewTimerEvent:(NSInteger)tag
{
    NSLog(@"tagT: %ld", tag);
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
