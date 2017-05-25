//
//  FunctionScrollView.m
//  CustomControls
//
//  Created by mojx on 2017/3/16.
//  Copyright © 2017年 mojiaxun. All rights reserved.
//

#import "FunctionScrollView.h"
#import "ButtonView.h"

@interface FunctionScrollView ()<UIScrollViewDelegate>
{
    NSMutableArray *functionArray;  // 数据
    UIScrollView *myScrollView;       // scrollView
    
    NSUInteger widthCount;          // 横排的个数
    NSUInteger buttonSize;          // 按钮的大小
    
    NSUInteger viewCount;           // page的个数
    float width;                    // view宽度
    float height;                   // view高度
    
    UIColor *buttonColor;           // 按钮字体颜色色
    UIFont *buttonfont;             // 按钮字体大小形式
}
@end

@implementation FunctionScrollView

/**
 * 初始设置参数
 * @param frame 位置和大小
 * @param array 数据数组
 * @param count 一行的数量
 * @param edge 边距
 * @param size 按钮的大小
 * @param style 显示类型：水平或垂直
 * @param color button的颜色
 * @param font button的字体形式大小
 */
- (id)initWithFrame:(CGRect)frame
           andArray:(NSMutableArray *)array
         widthCount:(NSUInteger)count
       edgeDistance:(CGSize)edge
         buttonSize:(NSInteger)size
              style:(enum FunctionScrollStyle)style
        buttonColor:(UIColor*)color
         buttonFont:(UIFont *)font
{
    self = [super initWithFrame:frame];
    if (self)
    {
        functionArray = array;
        widthCount = count;
        buttonSize = size;
        
        width = frame.size.width;
        height = frame.size.height;
        
        buttonColor = color;
        buttonfont = font;
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(width/2-10, height-10, 20, 20)];
        self.pageControl.currentPage = 0;
        [self addSubview: self.pageControl];
        
        myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        myScrollView.pagingEnabled = YES;
        myScrollView.delegate = self;
        myScrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:myScrollView];
        
        switch (style)
        {
            case KFunctionScroll_Horizontal: // 水平排列
                [self creatHorizontalFuction:frame edgeDistance:edge];
                break;
            case KFunctionScroll_Vertical: // 垂直排列
                [self creatVerticalFuction:frame edgeDistance:edge];
                break;
            default:
                break;
        }
    }
    return self;
}

/**
 * 水平排列
 */
- (void)creatHorizontalFuction:(CGRect)frame edgeDistance:(CGSize)edge
{
    self.pageControl.hidden = NO;
    viewCount = (functionArray.count)%(widthCount);// view的个数
    
    if (viewCount ==0)
        viewCount = functionArray.count/widthCount/2;
    else
        viewCount = functionArray.count/widthCount/2 +1;
    
    self.pageControl.numberOfPages = viewCount;
    
    NSMutableArray *buttons = [[NSMutableArray alloc] init];
    for (int i = 0; i < viewCount; i++)
    {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(width * i, 0, width, frame.size.height)];
        [myScrollView addSubview:backView];
        [buttons addObject:backView];
    }
    
    myScrollView.contentSize = CGSizeMake(viewCount*width, frame.size.height);
    
    for (int i = 0; i < functionArray.count; i++)
    {
        ButtonView *btnView;
        
        float x = ((i%(widthCount*2))%widthCount)*((width - edge.width *2)/widthCount) + edge.width + (((width - edge.width *2)/widthCount) - buttonSize)/2;
        float y = (i%(widthCount*2))/widthCount * buttonSize + edge.height;
        
        CGRect frame = CGRectMake(x, y, buttonSize, buttonSize);
        [self creatButton:btnView frame:frame andTag:i andView:buttons[i/widthCount/2]];
    }
}

/**
 * 垂直排列
 */
- (void)creatVerticalFuction:(CGRect)frame edgeDistance:(CGSize)edge
{
    self.pageControl.hidden = YES;
    viewCount = (functionArray.count)%(widthCount);// view的个数
    
    if (viewCount ==0)
        viewCount = functionArray.count/widthCount;
    else
        viewCount = functionArray.count/widthCount +1;
    
    myScrollView.contentSize = CGSizeMake(width, buttonSize*viewCount + edge.height*2);
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, buttonSize*viewCount)];
    [myScrollView addSubview:backView];
    
    for (int i = 0; i < functionArray.count; i++)
    {
        ButtonView *btnView;
        
        float x = (i%widthCount) * ((width - edge.width * 2)/widthCount) + edge.width + (((width - edge.width *2)/widthCount) - buttonSize)/2;
        float y = (i/widthCount) * buttonSize + edge.height;
        
        CGRect frame = CGRectMake(x, y, buttonSize, buttonSize);
        [self creatButton:btnView frame:frame andTag:i andView:backView];
    }
}

/**
 * 创建button
 */
- (void)creatButton:(ButtonView *)btnView frame:(CGRect )frame andTag:(NSUInteger)tag andView:(UIView *)view
{
    NSString *title = [functionArray[tag] objectForKey:@"title"];
    NSString *imageName = [functionArray[tag] objectForKey:@"image"];
    
    btnView = [[ButtonView alloc] initWithFrame:frame title:title imageName:imageName color:buttonColor font:buttonfont];
    btnView.tag = 10+tag;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapButtonView:)];
    [btnView addGestureRecognizer:tap];
    [view addSubview:btnView];
}

/**
 * 点击事件
 */
-(void)OnTapButtonView:(UITapGestureRecognizer *)tap
{
    if (self.functionScrollViewBlock)
        self.functionScrollViewBlock(tap);
}

- (void)chooseButtonViewBlock:(FunctionScrollViewBlock)block
{
    self.functionScrollViewBlock = block;
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollViewW = scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x + scrollViewW/viewCount)/scrollViewW;
    self.pageControl.currentPage = page;
}

@end
