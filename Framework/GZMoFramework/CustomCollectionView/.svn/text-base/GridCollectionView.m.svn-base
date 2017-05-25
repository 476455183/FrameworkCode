//
//  GridCollectionView.m
//  CustomControls
//
//  Created by mojx on 2016/11/5.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import "GridCollectionView.h"
#import "GridCollectionViewCell.h"
#import "RKNotificationHub.h"

static NSString * const reuseIdentifier = @"id_GridCollectionViewCell";

@interface GridCollectionView ()
{
    UIFont *titleFont_;
    UIColor *titleColor_;
    CGFloat cornerRadius_;
    /** 显示消息的view*/
    RKNotificationHub *hub_badgeView;
}

@end

@implementation GridCollectionView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

/**
 *  初始化
 *
 *  @param frame            位置和大小
 *  @param rowGridCount     每一行网格个数
 *  @param titleFont        标题字体
 *  @param titleColor       标题颜色
 *  @param cornerRadius     图片圆角半径
 */
- (instancetype)initWithFrame:(CGRect)frame
                 rowGridCount:(CGFloat)rowGridCount
                    titleFont:(UIFont *)titleFont
                   titleColor:(UIColor *)titleColor
                 cornerRadius:(CGFloat)cornerRadius
{
    if (self = [super initWithFrame:frame])
    {
        /* 添加子控件的代码
         */
        [self initCollectionView:frame rowGridCount:rowGridCount titleFont:titleFont titleColor:titleColor cornerRadius:cornerRadius];
    }
    return self;
}

//在layoutSubViews方法里面布局子控件
- (void)layoutSubviews
{
    // 一定要调用super的方法
    [super layoutSubviews];
}

- (void)initCollectionView:(CGRect)frame rowGridCount:(NSInteger)rowGridCount titleFont:(UIFont *)titleFont titleColor:(UIColor *)titleColor cornerRadius:(CGFloat)cornerRadius
{
    //获取字体
    titleFont_ = titleFont;
    titleColor_ = titleColor;
    cornerRadius_ = cornerRadius;
    //创建流水布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    //定义每个UICollectionView 的大小
    flowLayout.itemSize = CGSizeMake(frame.size.width/rowGridCount, frame.size.width/rowGridCount);

    //定义每个UICollectionView 横向的间距(行距)
    flowLayout.minimumLineSpacing = 0;//5;
    //定义每个UICollectionView 纵向的间距(cell之间间距)
    flowLayout.minimumInteritemSpacing = 0;
    //定义每个UICollectionView 的边距距
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//上左下右
    //设置位置与大小
    self.myCollectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:flowLayout];
    //设置代理
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
    
    //注册cell
    [self.myCollectionView registerClass:[GridCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    //背景颜色
    self.myCollectionView.backgroundColor = [UIColor clearColor];
    //self.myCollectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //自适应大小
    self.myCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self addSubview:self.myCollectionView];
}

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GridCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (self.isShowLayerBorder)
    {
        //设置图层边框和背景颜色
        cell.layer.borderWidth = 0.5;
        cell.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    }
    
    NSString *title = [self.dataArray objectAtIndex:indexPath.row];
    cell.titleLabel.text = title;
    cell.titleLabel.font = titleFont_;
    cell.titleLabel.textColor = titleColor_;
    
    cell.functionButton.tag = indexPath.row;
    [cell.functionButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.functionImageView.image = [UIImage imageNamed:[self.imageArray objectAtIndex:indexPath.row]];
    cell.functionImageView.layer.cornerRadius = cornerRadius_;//10;
    cell.functionImageView.layer.masksToBounds = YES;
    if (self.imageSize.width > 0)//重置图片位置与大小
    {
        CGRect frame = CGRectMake((cell.frame.size.width-self.imageSize.width)/2, (cell.frame.size.height-self.imageSize.height-cell.titleLabel.frame.size.height)/2, self.imageSize.width, self.imageSize.height);
        cell.functionImageView.frame = frame;
    }
    
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedCell = indexPath.row;
}

- (void)buttonAction:(UIButton *)button
{
    self.selectedCell = button.tag;
    //NSLog(@"button: %ld", self.selectedCell);
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:button.tag inSection:self.tag];
    NSString *title = [self.dataArray objectAtIndex:indexPath.row];
    if ([title isEqualToString:@""])
        return;
    
    [self.selectRowDelegate gridCollectionViewDidSelect:indexPath dataArray:self.dataArray];
    
    //按钮点击时改变背景颜色
    for (int i=0; i<_myCollectionView.visibleCells.count; i++)
    {
        GridCollectionViewCell *cell = (GridCollectionViewCell *)[_myCollectionView.visibleCells objectAtIndex:i];
        if (cell.functionButton.tag == indexPath.row)
        {
            cell.functionImageView.alpha = 0.8;
            cell.functionBkgImageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [UIView animateWithDuration:0.5 animations:^{
                cell.functionImageView.alpha = 1;
                cell.functionBkgImageView.backgroundColor = [UIColor clearColor];
            } completion:^(BOOL finished) {}];
            break;
        }
    }
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
    //设置消息视图
    for (int i=0; i<_myCollectionView.visibleCells.count; i++)
    {
        GridCollectionViewCell *cell = (GridCollectionViewCell *)[_myCollectionView.visibleCells objectAtIndex:i];
        if (cell.functionButton.tag == indexPath.row)
        {
            [self initBadgeValue:cell.badgeView fontSize:fontSize circleSize:circleSize];
            break;
        }
    }
}

/**
 消息提醒值初始化
 
 @param badgeView 用于显示消息提醒的视图
 @param fontSize 字体大小
 @param circleSize 消息提醒圆圈大小
 */
- (void)initBadgeValue:(UIView *)badgeView fontSize:(CGFloat)fontSize circleSize:(CGFloat)circleSize
{
    //设置消息提醒
    hub_badgeView = [[RKNotificationHub alloc] initWithView: badgeView];
    CGRect frame = hub_badgeView.hubView.frame;
    frame.origin.x = frame.size.width - (circleSize*2/3);
    frame.origin.y = -(circleSize/3);
    frame.size = CGSizeMake(circleSize, circleSize);
    hub_badgeView.fontOfSize = fontSize;
    [hub_badgeView setCircleAtFrame:frame];
    [hub_badgeView setCount:0];
}

/**
 设置消息提醒
 
 @param value 消息提醒的数字，为0时为不显示
 */
- (void)valueForBadge:(NSInteger)value
{
    if (hub_badgeView) {
        [hub_badgeView setCount:value];
    }
}

@end
