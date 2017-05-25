//
//  CustomCollectionView.m
//  CustomControls
//
//  Created by mojx on 16/7/6.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import "CustomCollectionView.h"
#import "CustomCollectionViewCell.h"

static NSString * const reuseIdentifier = @"CustomCollectionViewCell";

@implementation CustomCollectionView

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
        [self initCollectionView:frame];
    }
    return self;
}

//在layoutSubViews方法里面布局子控件
- (void)layoutSubviews
{
    // 一定要调用super的方法
    [super layoutSubviews];
}

- (void)initCollectionView:(CGRect)frame
{
    //创建流水布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //头部大小
    //flowLayout.headerReferenceSize = CGSizeMake(frame.size.width, 150);
    //设置水平滚动
    //flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //定义每个UICollectionView 的大小
    //flowLayout.itemSize = CGSizeMake((fDeviceWidth-20)/2, (fDeviceWidth-20)/2+50);
    flowLayout.itemSize = CGSizeMake((frame.size.width-20)/2, (frame.size.width-20)/2+50);
    //定义每个UICollectionView 横向的间距(行距)
    flowLayout.minimumLineSpacing = 5;
    //定义每个UICollectionView 纵向的间距(cell之间间距)
    flowLayout.minimumInteritemSpacing = 0;
    //定义每个UICollectionView 的边距距
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 5, 5);//上左下右
    //设置位置与大小
    self.myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:flowLayout];
    //设置代理
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
    
    //隐藏水平滚动条
    //self.myCollectionView.showsHorizontalScrollIndicator = NO;
    //取消弹簧效果
    //self.myCollectionView.bounces = NO;
    //注册cell
    [self.myCollectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    //背景颜色
    self.myCollectionView.backgroundColor = [UIColor clearColor];
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
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSString *title = [self.dataArray objectAtIndex:indexPath.row];
    cell.titleLabel.text = title;
    
    cell.functionButton.layer.cornerRadius = 10;
    cell.functionButton.layer.masksToBounds = YES;
    cell.functionButton.tag = indexPath.row;
    [cell.functionButton setBackgroundImage:[UIImage imageNamed:[self.imageArray objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
    [cell.functionButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    //cell.functionImageView.image = [UIImage imageNamed:[self.imageArray objectAtIndex:indexPath.row]];
    //[cell.functionImageView setHidden:YES];
    cell.functionBkgImageView.backgroundColor = [UIColor whiteColor];
    //cell.functionBkgImageView.backgroundColor = UIColorFromRGB(0xf8f8f8);
    cell.functionBkgImageView.layer.cornerRadius = 10;
    [cell.functionBkgImageView setUserInteractionEnabled:YES];
    
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(90, 122);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGFloat offset = (collectionView.frame.size.width-90*3)/4;
    return UIEdgeInsetsMake(offset, offset, offset, offset);
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
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:button.tag inSection:1];
    [self.selectRowDelegate collectionViewDidSelectRowAtIndexPath:indexPath dataArray:self.dataArray];
}

@end
