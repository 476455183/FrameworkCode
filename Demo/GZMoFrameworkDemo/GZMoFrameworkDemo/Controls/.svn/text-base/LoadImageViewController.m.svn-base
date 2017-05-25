//
//  LoadImageViewController.m
//  CustomControls
//
//  Created by mojx on 16/9/29.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import "LoadImageViewController.h"
#import "UIImageView+WebCache.h"//图片缓存

@implementation LoadImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initData];
}

-(void)initData
{
    dataArray = [[NSMutableArray alloc]init];
    NSURL *imageUrl = [NSURL URLWithString:@"http://s15.sinaimg.cn/middle/9914f9fdhbc6170891ebe&690"];
    for (int i=0; i<20; i++)
    {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setObject:@"图片图片图片" forKey:@"value"];
        [dic setObject:imageUrl forKey:@"imageUrl"];
        [dataArray addObject:dic];
    }
    //解决tableview内容下移64像素
    self.automaticallyAdjustsScrollViewInsets = NO;
}

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
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    NSMutableDictionary *dic = [dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [dic objectForKey:@"value"];
    
    //设置image
    CGSize newsize = CGSizeMake(60, 60);
    cell.imageView.layer.cornerRadius = 30;
    cell.imageView.layer.masksToBounds = YES;
    //图片缓存,使用SDWebImage下载网络图片,下载成功则显示网络图片，否则显示默认的图片
    [cell.imageView sd_setImageWithURL:[dic objectForKey:@"imageUrl"] placeholderImage:[UIImage imageNamed:@"girl_001"]];
    cell.imageView.image = [GZPublicMethod scaleToSize:cell.imageView.image newsize:newsize];
    
    return cell;
}

//设置行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

@end
