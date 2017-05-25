//
//  CustomGuideView.m
//  CustomControls
//
//  Created by mojx on 16/7/10.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import "CustomGuideView.h"
#import "GZPublicConst.h"

@interface CustomGuideView ()
{
    //滚动视图对象
    UIScrollView *myScrollView;
    //视图中小圆点，对应视图的页码
    UIPageControl *pageControl;
    
    //拖动前的起始坐标
    CGFloat startContentOffsetX;
    //拖动后的结束坐标
    CGFloat endContentOffsetX;
    
    //引导定时器
    NSTimer *guideViewTimer;
    CGFloat timeInterval_;
    //当前滚动页
    NSInteger currentPage;
    //当前滚动页计数值，用于scrollview拖动滚动时计数
    NSInteger currentPageCount;
    
    //视图控制器
    UIViewController *viewControl_;
    
    //位移
    CGFloat oldContentOffsetX;
    //宽、高
    CGFloat scrollViewWidth;
    CGFloat scrollViewHeight;
}

@end


@implementation CustomGuideView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/**
 *  初始化引导图片（引导图片或广告图片）
 *
 *  @param imageArray             图片数组
 *  @param isShowExperienceButton 是否显示立即体验按钮, 如显示则viewControl不能为空
 *  @param experienceButtonSize   立即体验按钮大小
 *  @param viewControl            视图控制器
 *  @param color1                 选中页的圆点颜色
 *  @param color2                 非选中页的圆点颜色
 */
- (void)initGuideView:(NSMutableArray *)imageArray
isShowExperienceButton:(BOOL)isShowExperienceButton
 experienceButtonSize:(CGSize)experienceButtonSize
          viewControl:(UIViewController *)viewControl
    pageSelectedColor:(UIColor *)color1
 pageNonSelectedColor:(UIColor *)color2
{
    viewControl_ = viewControl;
    if (isShowExperienceButton && viewControl)
        [viewControl_.navigationController.navigationBar setHidden:YES];
    
    [self initScrollView];
    [self initPageControl:imageArray.count pageSelectedColor:color1 pageNonSelectedColor:color2];
    
    //以下判断是否允许左右循环拖动
    if (self.isCycleDragging)
    {
        for (int i = 0; i < pageControl.numberOfPages + 1; i++)
        {
            UIImageView *pImageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * scrollViewWidth, 0, scrollViewWidth, scrollViewHeight)];
            pImageView.tag = i;
            pImageView.backgroundColor =[UIColor redColor];
            
            if (i == imageArray.count)
                pImageView.image = [imageArray objectAtIndex:0];
            else
                pImageView.image = [imageArray objectAtIndex:i];
            
            //点击手势
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
            [tap setNumberOfTapsRequired:1];
            [pImageView addGestureRecognizer:tap];
            pImageView.userInteractionEnabled = YES;
            
            //把视图添加到当前的滚动视图中
            [myScrollView addSubview:pImageView];
            
            if (i == pageControl.numberOfPages && isShowExperienceButton)//添加立即体验按钮
            {
                UIButton *experienceButton = [[UIButton alloc]init];
                [experienceButton setTitle:@"立即体验" forState:UIControlStateNormal];
                experienceButton.titleLabel.font = [UIFont systemFontOfSize:24];
                experienceButton.layer.cornerRadius = 10;
                experienceButton.layer.borderColor = [UIColor whiteColor].CGColor;
                experienceButton.layer.borderWidth = 1;
                //experienceButton.frame = CGRectMake((kScreenWidth - 206)/2, pageControl.frame.origin.y - 70, 206, 50);
                //experienceButton.frame = CGRectMake((kScreenWidth - 190)/2, pageControl.frame.origin.y - 70, 190, 40);
                experienceButton.frame = CGRectMake((kScreenWidth - experienceButtonSize.width)/2, pageControl.frame.origin.y - 70, experienceButtonSize.width, experienceButtonSize.height);
                
                [experienceButton addTarget:self action:@selector(experienceButtonAction) forControlEvents:UIControlEventTouchUpInside];
                [pImageView addSubview:experienceButton];
                pImageView.userInteractionEnabled = YES;
            }
        }
        //设置滚动视图的位置
        myScrollView.contentSize = CGSizeMake(scrollViewWidth * (pageControl.numberOfPages + 1), 0);
    }
    else
    {
        //标志
        NSUInteger tagflag = 0;
        //用来记录scrollView的x坐标
        int originX = 0;
        for(UIImage *image in imageArray)
        {
            //创建一个视图
            UIImageView *pImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
            //设置视图的背景色
            //pImageView.backgroundColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
            //设置imageView的背景图
            [pImageView setImage:image];
            //给imageView设置区域
            CGRect rect = myScrollView.frame;
            rect.origin.x = originX;
            rect.origin.y = 0;
            rect.size.width = myScrollView.frame.size.width;
            rect.size.height = myScrollView.frame.size.height;
            pImageView.frame = rect;
            //设置图片内容的显示模式(自适应模式)
            //pImageView.contentMode = UIViewContentModeScaleAspectFill;
            
            //点击手势
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
            [tap setNumberOfTapsRequired:1];
            [pImageView addGestureRecognizer:tap];
            pImageView.tag = tagflag++;
            pImageView.userInteractionEnabled = YES;
            
            //把视图添加到当前的滚动视图中
            [myScrollView addSubview:pImageView];
            //下一张视图的x坐标
            originX += myScrollView.frame.size.width;
            
            if (tagflag == imageArray.count && isShowExperienceButton)//添加立即体验按钮
            {
                UIButton *experienceButton = [[UIButton alloc]init];
                [experienceButton setTitle:@"立即体验" forState:UIControlStateNormal];
                experienceButton.titleLabel.font = [UIFont systemFontOfSize:24];
                experienceButton.layer.cornerRadius = 10;
                experienceButton.layer.borderColor = [UIColor whiteColor].CGColor;
                experienceButton.layer.borderWidth = 1;
                experienceButton.frame = CGRectMake((kScreenWidth - experienceButtonSize.width)/2, pageControl.frame.origin.y - 70, experienceButtonSize.width, experienceButtonSize.height);
                
                [experienceButton addTarget:self action:@selector(experienceButtonAction) forControlEvents:UIControlEventTouchUpInside];
                [pImageView addSubview:experienceButton];
                pImageView.userInteractionEnabled = YES;
            }
        }
        
        //设置滚动视图的位置
        [myScrollView setContentSize:CGSizeMake(originX, myScrollView.bounds.size.height)];
        self.backgroundColor = [UIColor redColor];
    }
}

//初始化滚动view
- (void)initScrollView
{
    CGRect frame = self.frame;
    frame.origin.y = 0;
    scrollViewWidth = frame.size.width;
    scrollViewHeight = frame.size.height;
    myScrollView = [[UIScrollView alloc]initWithFrame:frame];
    
    //设置委托
    myScrollView.delegate = self;
    //隐藏滚动条（水平方向）
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.showsVerticalScrollIndicator = NO;
    //翻页使能
    myScrollView.pagingEnabled = YES;
    
    //以下判断是否允许左右循环拖动
    if (!self.isCycleDragging)
    {
        //取消scrollView的弹簧效果(默认为YES)
        myScrollView.bounces = NO;
    }
    
    [self addSubview:myScrollView];
}

/**
 *  初始化翻页控制器
 *
 *  @param pages  总页数
 *  @param color1 选中页的圆点颜色
 *  @param color2 非选中页的圆点颜色
 */
- (void)initPageControl:(NSInteger)pages pageSelectedColor:(UIColor *)color1 pageNonSelectedColor:(UIColor *)color2
{
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 20, self.frame.size.width, 20)];
    //设置页码控制器的响应方法
    //[pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    //设置总页数
    pageControl.numberOfPages = pages;
    //默认当前页为第一页
    pageControl.currentPage = 0;
    //为页码控制器设置标签
    pageControl.tag = 110;
    //设置非选中页的圆点颜色
    //pageControl.pageIndicatorTintColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
    pageControl.pageIndicatorTintColor = color2;
    //设置选中页的圆点颜色
    //pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageControl.currentPageIndicatorTintColor = color1;
    
    self.backgroundColor = [UIColor redColor];
    [self addSubview:pageControl];
}

- (void)initGuideViewWithButton:(NSMutableArray *)viewArray titleArray:(NSMutableArray *)titleArray;
{
    
}

//按下立即体验按钮
- (void)experienceButtonAction
{
    [viewControl_.navigationController.navigationBar setHidden:NO];
    [viewControl_.navigationController popViewControllerAnimated:YES];
}

//改变页码的方法实现
- (void)changePage:(id)sender
{
    //NSLog(@"指示器的当前索引值为:%li",(long)pageControl.currentPage);
    //获取当前视图的页码
    CGRect rect = myScrollView.frame;
    //设置视图的横坐标，一幅图为320*460，横坐标一次增加或减少320像素
    rect.origin.x = pageControl.currentPage * myScrollView.frame.size.width;
    //设置视图纵坐标为0
    rect.origin.y = 0;
    //scrollView可视区域
    [myScrollView scrollRectToVisible:rect animated:YES];
    
    if (guideViewTimer)
        [self.imageTapDelegate guideViewTimerEvent:pageControl.currentPage];
}


#pragma mark-----UIScrollViewDelegate---------

//开始拖拽视图
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //拖动前的起始坐标
    startContentOffsetX = scrollView.contentOffset.x;
    //停止启计时器
    [self stopGuideViewTime];
}

//将结束拖拽视图
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (timeInterval_ > 0)//重新开启计时器
        [self changeGuideViewWithTimeInterval:timeInterval_];
}

//scrollerview 的滚动方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //以下判断是否允许左右循环拖动
    if (self.isCycleDragging)
    {
        CGPoint point = scrollView.contentOffset;
        BOOL isRight = oldContentOffsetX < point.x;
        oldContentOffsetX = point.x;
        
        // 开始显示最后一张图片的时候切换到第二个图
        if (point.x > scrollViewWidth * (pageControl.numberOfPages - 1) + scrollViewWidth * 0.5 && !guideViewTimer)
        {
            //从最后一个图片转到第一个图片
            pageControl.currentPage = 0;
        }
        else if (point.x > scrollViewWidth * (pageControl.numberOfPages - 1) && guideViewTimer && isRight)
            pageControl.currentPage = 0;
        else
            pageControl.currentPage = (point.x + scrollViewWidth * 0.5) / scrollViewWidth;
        
        // 开始显示第一张图片的时候切换到倒数第二个图
        if (point.x >= scrollViewWidth * pageControl.numberOfPages)
            [myScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        else if (point.x < 0)
            [scrollView setContentOffset:CGPointMake(point.x + scrollViewWidth * pageControl.numberOfPages, 0) animated:NO];
        currentPageCount = pageControl.currentPage;
    }
    else
    {
        NSUInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
        //切换改变页码，小圆点
        pageControl.currentPage = page;
        currentPageCount = page;
    }
}

//点击手势响应的事件
- (void)tapGesture:(UIGestureRecognizer*)gestureRecognizer
{
    if(gestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        //NSLog(@"-----singleTap-----: %ld", gestureRecognizer.view.tag);
        //UIImageView *view = (UIImageView*)[(UITapGestureRecognizer *)gestureRecognizer view];
        if (self.imageTapDelegate)
            [self.imageTapDelegate guideViewImageTap:gestureRecognizer.view.tag];
    }
}

/**
 *  定时改变引导图片（引导图片或广告图片），不使用时须调用stopGuideViewTime
 *
 *  @param timeInterval 定时时间，单位为秒，须>=1秒
 */
- (void)changeGuideViewWithTimeInterval:(CGFloat)timeInterval
{
    if (timeInterval < 1)
        return;
    
    //使用timer定时，每timeInterval秒触发一次
    timeInterval_ = timeInterval;
    guideViewTimer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(guideViewTimerMethod:) userInfo:nil repeats:YES];
    self.isStartGuideViewTime = YES;
}

/**
 *  停止引导定时器
 */
- (void)stopGuideViewTime
{
    if (guideViewTimer)
    {
        //取消定时器
        [guideViewTimer invalidate];
        guideViewTimer = nil;
    }
}

//定时器的事件
- (void)guideViewTimerMethod:(NSTimer*)theTimer
{
    //以下判断是否允许左右循环拖动
    if (self.isCycleDragging)
    {
        [myScrollView setContentOffset:CGPointMake((pageControl.currentPage + 1) * scrollViewWidth, 0) animated:YES];
        
        currentPageCount++;
        if (currentPageCount > pageControl.numberOfPages - 1)
            currentPageCount = 0;
        if (self.imageTapDelegate && guideViewTimer)
            [self.imageTapDelegate guideViewTimerEvent:currentPageCount];
    }
    else
    {
        pageControl.currentPage++;
        currentPageCount++;
        if (currentPageCount > pageControl.numberOfPages - 1)
        {
            pageControl.currentPage = 0;
            currentPageCount = 0;
        }
        [self changePage: nil];
    }
}

@end
