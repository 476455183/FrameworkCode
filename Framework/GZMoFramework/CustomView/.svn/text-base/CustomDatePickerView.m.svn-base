//
//  CustomDatePickerView.m
//  CustomControls
//  日期与时间选择器
//  Created by mojx on 2017/2/15.
//  Copyright © 2017年 mojiaxun. All rights reserved.
//

#import "CustomDatePickerView.h"

@interface CustomDatePickerView ()
{
    /** 日期选择器*/
    UIDatePicker *datePicker;
    /** 日期格式*/
    NSString *dateFormatString;
    /** 覆盖遮罩的视图*/
    UIView *coverView_;
    /** 加载的视图*/
    UIView *inView_;
    /** 是否显示*/
    BOOL isShow;
}

@end

@implementation CustomDatePickerView

/**
 初始化
 
 @param frame 框架大小
 @param backgroundColor 背景颜色
 @param showDate    弹出时默认显示的日期或时间
 @param mode        显示的模式: UIDatePickerModeDate、UIDatePickerModeTime、UIDatePickerModeDateAndTime
 @param format      显示的格式
 showDate、mode、format三者须保持一致。如
 showDate为2016-12-01，则mode为UIDatePickerModeDate，format为yyyy-MM-dd；
 showDate为12:01:01，则mode为UIDatePickerModeTime，format为HH:mm:ss
 showDate为2016-12-01 12:01:01，则mode为UIDatePickerModeDateAndTime，format为yyyy-MM-dd HH:mm:ss；
 @param isMaximumDateLimit 最大日期显示限制
 @param titleColor 确定取消按钮标题颜色
 @param titleFontSize 确定取消按钮标题字体大小
 @param inView 加载的视图
 @return 实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame
              backgroundColor:(UIColor *)backgroundColor
                     showDate:(NSString *)showDate
                         mode:(UIDatePickerMode)mode
                       format:(NSString *)format
           isMaximumDateLimit:(BOOL)isMaximumDateLimit
                   titleColor:(UIColor *)titleColor
                titleFontSize:(NSInteger)titleFontSize
                       inView:(UIView *)inView
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = backgroundColor;
        if (backgroundColor == [UIColor whiteColor])
        {
            //分割线
            UIView *seperatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 39, frame.size.width, 1)];
            seperatorView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [self addSubview:seperatorView];
        }
        dateFormatString = format;
        
        //日期选择器初始化
        datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 40, frame.size.width, frame.size.height-40)];
        datePicker.datePickerMode = mode;
        datePicker.backgroundColor = [UIColor whiteColor];
        //最大日期显示限制
        if (isMaximumDateLimit)
            datePicker.maximumDate = [NSDate date];
        [datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
        //设置UIDatePicker默认显示时间, [NSDate date]为当前日期
        //datePicker.date = [NSDate date];
        //设置格式
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat: format];
        NSDate *destDate = [dateFormatter dateFromString:showDate];
        //设置UIDatePicker默认显示时间
        datePicker.date = destDate;
        [self addSubview:datePicker];
        
        //创建确定按钮
        UIButton *okButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        okButton.frame = CGRectMake(frame.size.width-60, 5, 40, 30);
        [okButton setTitle:@"确定" forState:UIControlStateNormal];
        okButton.titleLabel.font = [UIFont systemFontOfSize:titleFontSize];
        [okButton setTitleColor:titleColor forState:UIControlStateNormal];
        [okButton addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:okButton];
        
        //创建取消按钮
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame=CGRectMake(20, 5, 40, 30);
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:titleFontSize];
        [cancelButton setTitleColor:titleColor forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelButton];
        
        //创建覆盖遮罩的视图
        coverView_ = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        coverView_.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        coverView_.userInteractionEnabled = YES;
        [coverView_ addSubview:self];
        
        //添加点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
        [tap setNumberOfTapsRequired:1];
        [coverView_ addGestureRecognizer:tap];
        
        [inView addSubview:coverView_];
        
        //加载显示动画
        inView_ = inView;
        [self showAnimate:inView];
    }
    return self;
}

//点击手势响应的事件
- (void)tapGesture:(UIGestureRecognizer*)gestureRecognizer
{
    if(gestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        if (coverView_)
        {
            [self cancelAction];
        }
    }
}

/**
 确定按钮点击事件
 */
- (void)okAction
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    //实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:dateFormatString];//设定格式
    NSString *dateString = [dateFormat stringFromDate:datePicker.date];
    if (self.okBlock)
        self.okBlock(dateString);
    [self dismissAnimate:inView_];
}

/**
 取消按钮点击事件
 */
- (void)cancelAction
{
    if (self.cancelBlock)
        self.cancelBlock();
    [self dismissAnimate:inView_];
}

/**
 显示动画
 
 @param inView 加载的view
 */
- (void)showAnimate:(UIView *)inView
{
    self.frame = CGRectMake(0, inView.frame.size.height, inView.frame.size.width, self.frame.size.height);
    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame = CGRectMake(0, inView.frame.size.height-self.frame.size.height, inView.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        isShow = YES;
    }];
}

/**
 消失动画
 
 @param inView 加载的view
 */
- (void)dismissAnimate:(UIView *)inView
{
    self.frame = CGRectMake(0, inView.frame.size.height-self.frame.size.height, inView.frame.size.width, self.frame.size.height);
    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame = CGRectMake(0, inView.frame.size.height, inView.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        isShow = NO;
        [coverView_ removeFromSuperview];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
