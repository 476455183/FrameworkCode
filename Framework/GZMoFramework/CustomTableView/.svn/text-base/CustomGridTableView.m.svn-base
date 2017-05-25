//
//  CustomGridTableView.m
//  CustomControls
//
//  Created by mojx on 2016/11/6.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import "CustomGridTableView.h"
#import "GridCollectionView.h"

@interface CustomGridTableView ()<UITableViewDelegate,UITableViewDataSource,GridCollectionViewDelegate>
{
    UIFont *titleFont_;
    UIColor *titleColor_;
    NSInteger heightForHeader_;
    NSMutableArray *gridMArray;//数据
}

@end

@implementation CustomGridTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        /* 添加子控件的代码
         在重新构造方法的时候,我们只需要把控件放进去,暂时先不用考虑他们在什么位置,而是在layoutSubViews方法里面布局子控件
         */
        //self.myTableView = [[UITableView alloc]init];
        //self.myTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        self.myTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        self.myTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        self.myTableView.dataSource = self;
        self.myTableView.delegate = self;
        //一句话解决所有TableView的多余cell
        [self.myTableView setTableFooterView:[[UIView alloc]init]];
        [self addSubview:self.myTableView];
        
        //解决cell设置imageView时分割线短15像素的处理
        [self.myTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    return self;
}

//在layoutSubViews方法里面布局子控件
- (void)layoutSubviews
{
    // 一定要调用super的方法
    [super layoutSubviews];
    
    // 确定子控件的frame（这里得到的self的frame/bounds才是准确的）
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    self.myTableView.frame = CGRectMake(0, 0, width, height);
}

/**
 *  初始化数据
 *
 *  @param array            数据
 *  @param titleColor       主标题字体颜色
 *  @param titleFont        主标题字体
 *  @param subTitleColor    子标题字体颜色
 *  @param subTitleFont     子标题字体
 *  @param imageSize        cell图片大小
 *  @param cornerRadius     cell图片圆角半径
 *  @param heightForHeader  heightForHeaderInSection高度
 *  @param gridcount        网络数，须为整数
 */
- (void)initData:(NSMutableArray *)array
      titleColor:(UIColor *)titleColor
       titleFont:(UIFont *)titleFont
   subTitleColor:(UIColor *)subTitleColor
    subTitleFont:(UIFont *)subTitleFont
       imageSize:(CGSize)imageSize
    cornerRadius:(CGFloat)cornerRadius
 heightForHeader:(NSInteger)heightForHeader
       gridcount:(CGFloat)gridcount
{
    if (array.count < 1 || cornerRadius < 0)
    {
        gridMArray = [[NSMutableArray alloc]init];
        [self.myTableView reloadData];
        return;
    }
    
    //网格补全处理, dataArray和imageArray数据个数须与网格一一对应，相同
    for (int i= 0; i<array.count; i++)
    {
        NSMutableDictionary *gridMDic = [array objectAtIndex:i];
        NSMutableArray *dataArray = [gridMDic objectForKey:@"data"];
        NSMutableArray *imageArray = [gridMDic objectForKey:@"images"];
        int count = dataArray.count % (int)gridcount;
        if (count > 0)
        {
            for (int ii= count; ii<gridcount; ii++)
            {
                [dataArray addObject:@""];
                [imageArray addObject:@""];
            }
            //重置数据
            [gridMDic setObject:dataArray forKey:@"data"];
            [gridMDic setObject:imageArray forKey:@"images"];
            [array replaceObjectAtIndex:i withObject:gridMDic];
        }
    }

    //设置新的数据
    CGRect frame = self.frame;
    frame.origin.y = 0;
    gridMArray = [[NSMutableArray alloc]init];
    for (int i=0; i<array.count; i++)
    {
        NSMutableDictionary *gridMDic = [array objectAtIndex:i];
        NSMutableArray *dataArray = [gridMDic objectForKey:@"data"];
        NSMutableArray *imageArray = [gridMDic objectForKey:@"images"];
        
        //ceil(x)返回不小于x的最小整数值（然后转换为double型）,向上取整。如NSLog(@"%d",  (int)ceil(10 / 3.0));输出结果是：4。
        frame.size.height = ceil((dataArray.count/gridcount)) * (self.frame.size.width/gridcount);
        
        GridCollectionView *customView = [[GridCollectionView alloc]initWithFrame:frame rowGridCount:gridcount titleFont:subTitleFont titleColor:subTitleColor cornerRadius:cornerRadius];
        customView.isShowLayerBorder = self.isShowLayerBorder;
        customView.selectRowDelegate = self;
        customView.dataArray = dataArray;
        customView.imageArray = imageArray;
        customView.imageSize = imageSize;
        customView.tag = i;
        
        NSMutableDictionary *mdic = [[NSMutableDictionary alloc]init];
        [mdic setObject:[gridMDic objectForKey:@"title"] forKey:@"title"];
        [mdic setObject:customView forKey:@"data"];
        [gridMArray addObject:mdic];
    }

    titleFont_ = titleFont;
    titleColor_ = titleColor,
    heightForHeader_ = heightForHeader;
    [self.myTableView reloadData];
}

#pragma mark - 数据源方法
#pragma mark 一共有多少组（section == 区域\组）
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return gridMArray.count;
}

#pragma mark 第section组一共有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark 返回每一行显示的内容(每一行显示怎样的cell)
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    NSMutableDictionary *mdic = gridMArray[indexPath.section];
    GridCollectionView *customView = [mdic objectForKey:@"data"];
    [cell addSubview:customView];
    return cell;
}

#pragma mark 第section组显示的头部标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSMutableDictionary *mdic = gridMArray[section];
    return [mdic objectForKey:@"title"];
}

#pragma mark 设置行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *mdic = gridMArray[indexPath.section];
    GridCollectionView *customView = [mdic objectForKey:@"data"];
    return customView.frame.size.height;
}

#pragma mark section头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return heightForHeader_;
}
#pragma mark 自定义section头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSMutableDictionary *mdic = gridMArray[section];
    NSString *key = [mdic objectForKey:@"title"];
    
    // create the parent view that will hold header Label
    CGFloat height = 22;
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, height)];
    customView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //customView.backgroundColor = [UIColor colorWithRed:0.10 green:0.68 blue:0.94 alpha:0.7];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    headerLabel.textAlignment = NSTextAlignmentLeft;
    headerLabel.textColor = titleColor_;//[UIColor blackColor];
    headerLabel.highlightedTextColor = [UIColor whiteColor];
    headerLabel.font = titleFont_;//[UIFont italicSystemFontOfSize:14];
    //设置位置居中
    headerLabel.frame = CGRectMake(10, (heightForHeader_-height)/2, tableView.frame.size.width, height);
    headerLabel.text = key;
    
    [customView addSubview:headerLabel];
    
    return customView;
}

#pragma mark - 实现GridCollectionView中GridCollectionViewDelegate协议中的方法
- (void)gridCollectionViewDidSelect:(NSIndexPath *)indexPath dataArray:(NSMutableArray *)dataArray
{
    //NSLog(@"section: %ld; row: %ld; name: %@", indexPath.section, indexPath.row, [dataArray objectAtIndex:indexPath.row]);
    //使用Block传值
    if (self.GridDidSelectBlock)
        self.GridDidSelectBlock(indexPath, dataArray);
}

#pragma mark - 消息提醒

/**
 初始化消息提醒视图
 
 @param indexPath 索引路径
 @param fontSize 字体大小
 @param circleSize 消息提醒圆圈大小
 */
- (void)initBadgeView:(NSIndexPath *)indexPath fontSize:(CGFloat)fontSize circleSize:(CGFloat)circleSize
{
    if (gridMArray.count > 0)
    {
        NSMutableDictionary *mdic = gridMArray[indexPath.section];
        GridCollectionView *customView = [mdic objectForKey:@"data"];
        [customView initBadgeView:indexPath fontSize:fontSize circleSize:circleSize];
        
        [mdic setObject:customView forKey:@"data"];
        [gridMArray replaceObjectAtIndex:indexPath.section withObject:mdic];
        [self.myTableView reloadData];
    }
}

/**
 设置消息提醒值
 
 @param indexPath 索引路径
 @param value 消息提醒的数字，为0时为不显示
 */
- (void)valueForBadge:(NSIndexPath *)indexPath value:(NSInteger)value
{
    if (gridMArray.count > 0)
    {
        NSMutableDictionary *mdic = gridMArray[indexPath.section];
        GridCollectionView *customView = [mdic objectForKey:@"data"];
        [customView valueForBadge:value];
        
        [mdic setObject:customView forKey:@"data"];
        [gridMArray replaceObjectAtIndex:indexPath.section withObject:mdic];
        [self.myTableView reloadData];
    }
}

@end
