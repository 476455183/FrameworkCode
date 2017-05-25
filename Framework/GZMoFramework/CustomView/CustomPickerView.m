//
//  CustomPickerView.m
//  CustomControls
//  通用选择器（单列、双列）
//  Created by mojx on 2017/2/15.
//  Copyright © 2017年 mojiaxun. All rights reserved.
//

#import "CustomPickerView.h"

@interface CustomPickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>
{
    /** 内容数组*/
    NSArray *contentArray1_, *contentArray2_;
    /** 选中的行*/
    NSInteger selectedRow1, selectedRow2;
    /** 覆盖遮罩的视图*/
    UIView *coverView_;
    /** 加载的视图*/
    UIView *inView_;
    /** 是否显示*/
    BOOL isShow;
}

@end


@implementation CustomPickerView

/**
 初始化
 
 @param frame 框架大小
 @param backgroundColor 背景颜色
 @param contentArray1 内容数组1（必填）
 @param contentArray2 内容数组2（可选，如为nil时，则只显示contentArray1的内容）
 @param showRow1 弹出时默认显示第几行的内容,与contentArray1的内容对应（必填）
 @param showRow2 弹出时默认显示第几行的内容,与contentArray2的内容对应（可选）
 @param titleColor 确定取消按钮标题颜色
 @param titleFontSize 确定取消按钮标题字体大小
 @param inView 加载的视图
 @return 实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame
              backgroundColor:(UIColor *)backgroundColor
                contentArray1:(NSArray *)contentArray1
                contentArray2:(NSArray *)contentArray2
                     showRow1:(NSInteger)showRow1
                     showRow2:(NSInteger)showRow2
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
        
        contentArray1_ = contentArray1;
        contentArray2_ = contentArray2;
        
        //选择器初始化
        UIPickerView *picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, frame.size.width, frame.size.height-40)];
        picker.delegate = self;
        picker.dataSource = self;
        picker.backgroundColor = [UIColor whiteColor];
        selectedRow1 = showRow1;
        selectedRow2 = showRow2;
        [picker selectRow:showRow1 inComponent:0 animated:YES];
        if (contentArray2)
            [picker selectRow:showRow2 inComponent:1 animated:YES];
        
        [self addSubview:picker];
        
        //创建确定按钮
        UIButton *okButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        okButton.frame = CGRectMake(frame.size.width-60, 5, 40, 30);
        [okButton setTitle:@"确定" forState:UIControlStateNormal];
        okButton.titleLabel.font=[UIFont systemFontOfSize:titleFontSize];
        [okButton setTitleColor:titleColor forState:UIControlStateNormal];
        [okButton addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:okButton];
        
        //创建取消按钮
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(20, 5, 40, 30);
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

#pragma mark - UIPickerViewDelegate

//UIPickerViewDataSource中定义的方法，该方法的返回值决定该控件包含多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (contentArray1_ && contentArray2_)
        return 2;
    return 1;
}

//UIPickerViewDataSource中定义的方法，该方法的返回值决定该控件指定列包含多少个列表项
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (contentArray1_ && contentArray2_)
    {
        if (component == 0)
            return contentArray1_.count;
        else
            return contentArray2_.count;
    }
    return contentArray1_.count;
}

//UIPickerViewDelegate中定义的方法，该方法返回的NSString将作为UIPickerView中指定列和列表项上显示的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (contentArray1_ && contentArray2_)
    {
        if (component == 0)
            return [contentArray1_ objectAtIndex:row];
        else
            return [contentArray2_ objectAtIndex:row];
    }
    return [contentArray1_ objectAtIndex:row];
}

//当用户选中UIPickerViewDataSource中指定列和列表项时激发该方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (contentArray1_ && contentArray2_)
    {
        if (component == 0)
            selectedRow1 = row;
        else
            selectedRow2 = row;
    }
    else
        selectedRow1 = row;
}

/**
 确定按钮点击事件
 */
- (void)okAction
{
    //获取滚动选择的内容
    NSString *selectedContent1, *selectedContent2;
    if (contentArray1_ && contentArray2_)
    {
        selectedContent1 = [contentArray1_ objectAtIndex:selectedRow1];
        selectedContent2 = [contentArray2_ objectAtIndex:selectedRow2];
    }
    else
        selectedContent1 = [contentArray1_ objectAtIndex:selectedRow1];
    
    if (self.okBlock)
        self.okBlock(selectedContent1, selectedContent2, selectedRow1, selectedRow2);
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
