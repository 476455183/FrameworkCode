//
//  CustomDropDownListView.m
//  CustomControls
//
//  Created by mojx on 2016/11/24.
//  Copyright © 2016年 mojiaxun. All rights reserved.s
//

#import "CustomDropDownListView.h"

@interface CustomDropDownListView ()<UITableViewDelegate,UITableViewDataSource>
{
    /** 数据表视图*/
    UITableView *myTableView;
    /** 数据数组*/
    NSArray *dataArray_;
    /** 边缘大小*/
    CGFloat marginSize_;
    /** 字体大小*/
    UIFont *textFont_;
    /** 字体颜色*/
    UIColor *textColor_;
    /** 覆盖遮罩的视图*/
    UIView *coverView_;
    /** 加载的视图*/
    UIView *inView_;
}

@end


@implementation CustomDropDownListView

/**
 初始化

 @param frame 框架大小
 @param marginSize 边缘大小
 @param dataArray 数据
 @param textColor 内容颜色
 @param textFont 内容字体
 @param inView 加载的视图
 @return 实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame
                   marginSize:(CGFloat)marginSize
                    dataArray:(NSArray *)dataArray
                    textColor:(UIColor *)textColor
                     textFont:(UIFont *)textFont
                       inView:(UIView *)inView
{
    self = [super initWithFrame:frame];
    if (self)
    {
        marginSize_ = marginSize;
        dataArray_ = dataArray;
        textFont_ = textFont;
        textColor_ = textColor;
        inView_ = inView;
        
        myTableView = [[UITableView alloc]init];
        myTableView.delegate = self;
        myTableView.dataSource = self;
        myTableView.frame = CGRectMake(0, marginSize_, self.bounds.size.width, self.bounds.size.height - marginSize_);
        myTableView.layer.cornerRadius = 10;
        myTableView.clipsToBounds = YES;
        [self addSubview:myTableView];
        self.backgroundColor = [UIColor clearColor];
        [myTableView reloadData];
        
        coverView_ = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        coverView_.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        //[coverView_ setUserInteractionEnabled:YES];
        [coverView_ addSubview:self];
        
        //添加点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
        [tap setNumberOfTapsRequired:1];
        [coverView_ addGestureRecognizer:tap];
        coverView_.userInteractionEnabled = YES;
        
        //解决UITapGestureRecognizer手势与UITableView的点击事件的冲突
        tap.delegate = (id<UIGestureRecognizerDelegate>)self;
        
        [inView_ addSubview:coverView_];
    }
    return self;
}

//点击手势响应的事件
- (void)tapGesture:(UIGestureRecognizer*)gestureRecognizer
{
    if(gestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        if (coverView_)
            [coverView_ removeFromSuperview];
    }
}

//截获所点击的视图，并决定是否手势继续向下响应: 解决UITapGestureRecognizer手势与UITableView的点击事件的冲突
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"])
    {
        return NO;
    }
    return YES;
}


#pragma mark - tableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray_.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cell_id = @"id_dropDownListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_id];
    
    cell.textLabel.text = dataArray_[indexPath.row];
    cell.textLabel.textColor = textColor_;
    cell.textLabel.font = textFont_;
    
    //添加按钮，避免控件之间的手势冲突
    UIButton *button = [[UIButton alloc]initWithFrame:cell.frame];
    button.tag = indexPath.row;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:button];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.myBlock)
        self.myBlock(indexPath.row, dataArray_[indexPath.row]);
    [coverView_ removeFromSuperview];
}

- (void)buttonAction:(UIButton *)button
{
    if (self.myBlock)
        self.myBlock(button.tag, dataArray_[button.tag]);
    [coverView_ removeFromSuperview];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    // 背景色
    [[UIColor whiteColor] set];
    // 获取视图
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    // 开始绘制
    CGContextBeginPath(contextRef);
    CGContextMoveToPoint(contextRef, self.bounds.size.width - 40, myTableView.frame.origin.y);
    CGContextAddLineToPoint(contextRef, self.bounds.size.width - 20, myTableView.frame.origin.y);
    CGContextAddLineToPoint(contextRef, self.bounds.size.width - 20 * 1.5, myTableView.frame.origin.y - marginSize_);
    // 结束绘制
    CGContextClosePath(contextRef);
    // 填充色
    [[UIColor whiteColor] setFill];
    // 边框颜色
    [[UIColor whiteColor] setStroke];
    // 绘制路径
    CGContextDrawPath(contextRef, kCGPathFillStroke);
}

@end
