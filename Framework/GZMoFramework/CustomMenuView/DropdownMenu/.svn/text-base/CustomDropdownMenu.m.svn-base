//
//  CustomDropdownMenu.m
//  CustomControls
//
//  Created by mojx on 16/8/11.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import "CustomDropdownMenu.h"
#import "DropdownButton.h"
#import "GZPublicConst.h"

//下拉菜单类型
enum DropdownMenuType
{
    //单一的
    DropdownMenuType_Single,
    //多个的
    DropdownMenuType_Multiple,
};

@interface CustomDropdownMenu ()<UITableViewDelegate,UITableViewDataSource,showDropdownMenuDelegate>
{
    NSMutableArray *firstArray;
    NSInteger selectedRow1;
    NSMutableArray *secondArray;
    NSInteger selectedRow2;
    NSMutableArray *myDataArray;
    NSMutableArray *titlesArray;
    NSMutableArray *checkedArray;
    
    UITableView *firstTableView;
    UITableView *secondTableView;
    UIView *dataView;
    
    UIFont *textFont_;
    NSInteger cellHieght_;
    NSInteger titleHeight_;
    UIColor *titleColor_;
    UIColor *lineColor_;
    //默认选中行是否使能
    BOOL selectedIndexEnable_;
    
    //下拉菜单按钮
    DropdownButton *dropdownButton;
    //下拉菜单类型
    enum DropdownMenuType dropdownMenuType_;
    //下拉菜单按钮索引
    NSInteger dropdownMenuIndex;
}

@end

@implementation CustomDropdownMenu

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
        dataView = [[UIView alloc]init];
        
        firstTableView = [[UITableView alloc]init];
        firstTableView.dataSource = self;
        firstTableView.delegate = self;
        firstTableView.tag = 0;
        //[self addSubview:firstTableView];
        //解决cell设置imageView时分割线短15像素的处理
        [firstTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        [dataView addSubview:firstTableView];
        
        secondTableView = [[UITableView alloc]init];
        secondTableView.dataSource = self;
        secondTableView.delegate = self;
        secondTableView.tag = 1;
        //[self addSubview:secondTableView];
        //解决cell设置imageView时分割线短15像素的处理
        [secondTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        [dataView addSubview:secondTableView];
        
        [self addSubview:dataView];
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
    CGFloat height = self.frame.size.height - titleHeight_ - 1;
    dataView.frame = CGRectMake(0, titleHeight_, width, height);
    if (dropdownMenuType_ == DropdownMenuType_Single)
    {
        firstTableView.frame = CGRectMake(0, 0, width, height);
        [secondTableView setHidden:YES];
        [dataView setHidden:YES];
    }
    else if (dropdownMenuType_ == DropdownMenuType_Multiple)
    {
        firstTableView.frame = CGRectMake(0, 0, width/2, height);
        secondTableView.frame = CGRectMake(width/2, 0, width/2, height);
        [dataView setHidden:YES];
    }
}

/**
 *  初始化下拉菜单
 *
 *  @param dataArray           下拉菜单数据
 *  @param type                下拉菜单类型
 *  @param titles              下拉菜单按钮标题
 *  @param titleColor          下拉菜单按钮标题颜色
 *  @param lineColor           下拉菜单底部线条颜色
 *  @param valueColor          下拉菜单数据值颜色
 *  @param font                字体大小
 *  @param cellHieght          高度
 *  @param backgroundColor     下拉菜单按钮背景颜色
 *  @param selectedIndex       默认选中的行
 *  @param selectedIndexEnable 默认选中行是否使能
 *  @param imageAlignment      下拉图像对齐方式：0在标题右边显示；1左边显示；2右边显示；
 */
- (void)initData:(NSMutableArray *)dataArray
dropdownMenuType:(NSInteger)type
          titles:(NSMutableArray *)titles
      titleColor:(UIColor *)titleColor
       lineColor:(UIColor *)lineColor
      valueColor:(UIColor *)valueColor
            font:(UIFont *)font
      cellHieght:(NSInteger)cellHieght
 backgroundColor:(UIColor *)backgroundColor
   selectedIndex:(NSInteger)selectedIndex
selectedIndexEnable:(BOOL)selectedIndexEnable
  imageAlignment:(NSInteger)imageAlignment
{
    if (dataArray.count < 1)
        return;
    
    dropdownMenuType_ = (enum DropdownMenuType)type;
    textFont_ = font;
    cellHieght_ = cellHieght;
    titleColor_ = titleColor;
    lineColor_ = lineColor;
    selectedIndexEnable_ = selectedIndexEnable;
    
    myDataArray = dataArray;
    titleHeight_ = 35;
    CGRect frame = CGRectMake(0, 0, self.frame.size.width, titleHeight_);
    
    dropdownButton = [[DropdownButton alloc] initWithFrame:frame];
    dropdownButton.imageAlignment = (enum DropdownMenuImageAlignment)imageAlignment;//DropdownMenuImageAlignment_Right;
    dropdownButton.delegate = self;
    [dropdownButton initDropdownButtonWithTitles:titles titleColor:titleColor lineColor:lineColor font:font backgroundColor:backgroundColor];
    [self addSubview:dropdownButton];
    
    if (dropdownMenuType_ == DropdownMenuType_Single)
    {
        firstArray = dataArray;
        //初始化选中项处理
        checkedArray = [[NSMutableArray alloc]init];
        for (int i=0; i< dataArray.count; i++)
        {
            [checkedArray addObject:[NSNumber numberWithBool:NO]];
        }
        
        //默认选中行
        if (selectedIndexEnable)
            [checkedArray replaceObjectAtIndex:selectedIndex withObject:[NSNumber numberWithBool:YES]];
    }
    else if (dropdownMenuType_ == DropdownMenuType_Multiple)
    {
        firstArray = [[NSMutableArray alloc]init];
        NSMutableArray *data = [dataArray objectAtIndex:0];
        for (int i=0; i< data.count; i++)
        {
            NSMutableDictionary *dic = [data objectAtIndex:i];
            [firstArray addObject:[dic objectForKey:@"title"]];
        }
        NSMutableDictionary *dic = [data objectAtIndex:0];
        secondArray = [dic objectForKey:@"value"];
        
        //设置tableview背景颜色
        firstTableView.backgroundColor = UIColorFromRGB(kTableViewBackgroundColor);
        if (selectedIndexEnable)
        {
            //默认选中第1行
            NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
            [firstTableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
    }
}


#pragma mark - showDropdownMenuDelegate

- (void)showDropdownMenu:(NSInteger)index
{
    if (dropdownMenuType_ == DropdownMenuType_Multiple)
    {
        firstArray = [[NSMutableArray alloc]init];
        NSMutableArray *data = [myDataArray objectAtIndex:index];
        for (int i=0; i<data.count; i++)
        {
            NSMutableDictionary *dic = [data objectAtIndex:i];
            [firstArray addObject:[dic objectForKey:@"title"]];
        }
        NSMutableDictionary *dic = [data objectAtIndex:0];
        secondArray = [dic objectForKey:@"value"];
        
        [firstTableView reloadData];
        [secondTableView reloadData];
        
        //默认选中行
        NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectedRow1 inSection:0];
        [firstTableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    dropdownMenuIndex = index;
    [dataView setHidden:NO];
    [self transitionWithType:kCATransitionReveal withSubtype:kCATransitionFromBottom forView:dataView];
}
- (void)hideDropdownMenu:(NSInteger)index
{
    dropdownMenuIndex = index;
    [dataView setHidden:YES];
}

#pragma CATransition动画实现
- (void)transitionWithType:(NSString *)type withSubtype:(NSString *)subtype forView:(UIView *)view
{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    //设置运动时间
    animation.duration = 0.7;
    //设置运动type
    animation.type = type;
    if (subtype != nil)
    {
        //设置子类
        animation.subtype = subtype;
    }
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    [view.layer addAnimation:animation forKey:@"animation"];
}

#pragma mark - tableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 0)
        return firstArray.count;
    else
        return secondArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 0)
    {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"first_cell"];
        cell.textLabel.text = [firstArray objectAtIndex:indexPath.row];
        cell.textLabel.font = textFont_;
        cell.textLabel.numberOfLines = 0;
        
        if (dropdownMenuType_ == DropdownMenuType_Single && selectedIndexEnable_)
        {
            BOOL check = [[checkedArray objectAtIndex:indexPath.row]boolValue];
            if (check)
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            else
                cell.accessoryType = UITableViewCellAccessoryNone;
        }
        else if (dropdownMenuType_ == DropdownMenuType_Multiple)
        {
            UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
            cell.selectedBackgroundView = backView;
            cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
            cell.backgroundColor = tableView.backgroundColor;
        }
        
        return cell;
    }
    else
    {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"second_cell"];
        cell.textLabel.text = [secondArray objectAtIndex:indexPath.row];
        cell.textLabel.font = textFont_;
        cell.textLabel.numberOfLines = 0;
        cell.backgroundColor = tableView.backgroundColor;
        
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (dropdownMenuType_ == DropdownMenuType_Single)
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView.tag == 0)
    {
        selectedRow1 = indexPath.row;
        if (dropdownMenuType_ == DropdownMenuType_Single)
        {
            if (selectedIndexEnable_)
            {
                //点击选中处理
                for (int i=0; i< checkedArray.count; i++)
                {
                    if (i == indexPath.row)
                        [checkedArray replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:YES]];
                    else
                        [checkedArray replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:NO]];
                }
                [firstTableView reloadData];
            }
            
            [dropdownButton changeButtonWithIndex:0 title:[firstArray objectAtIndex:indexPath.row]];
            //隐藏菜单
            if (self.isDidSelectHideMenu)
                [self hideDropdownMenu:0];
            
            //处理block回调
            if (self.myBlock)
                self.myBlock(selectedRow1,0 ,[firstArray objectAtIndex:indexPath.row],@"");
        }
        if (dropdownMenuType_ == DropdownMenuType_Multiple)
        {
            NSMutableArray *data = [myDataArray objectAtIndex:dropdownMenuIndex];
            NSMutableDictionary *dic = [data objectAtIndex:indexPath.row];
            secondArray = [dic objectForKey:@"value"];
            [secondTableView reloadData];
            NSLog(@"%@", [dic objectForKey:@"title"]);
        }
    }
    else
    {
        selectedRow2 = indexPath.row;
        //隐藏菜单
        if (self.isDidSelectHideMenu)
        {
            [self hideDropdownMenu:dropdownMenuIndex];
            [dropdownButton changeButtonAngle:dropdownMenuIndex rotationAngle:0];
        }
        
        //处理block回调
        if (self.myBlock)
            self.myBlock(selectedRow1,selectedRow2,[firstArray objectAtIndex:selectedRow1],[secondArray objectAtIndex:selectedRow2]);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHieght_;
}

@end
