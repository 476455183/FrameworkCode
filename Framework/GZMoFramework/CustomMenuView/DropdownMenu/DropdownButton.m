//
//  DropdownButton.m
//  CustomControls
//
//  Created by mojx on 16/8/14.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import "DropdownButton.h"

//下拉按钮标志
static const NSInteger kDropdownButtonTag = 100;

@interface DropdownButton ()
{
    NSMutableArray *buttonsArray;
    NSMutableArray *chooseArray;
    UIFont *titleFont_;
}

@end

@implementation DropdownButton

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

/**
 *  初始化下拉菜单按钮
 *
 *  @param titles          按钮标题
 *  @param titleColor      标题颜色
 *  @param lineColor       底部线条颜色
 *  @param font            字体
 *  @param backgroundColor 抱背景颜色
 */
- (void)initDropdownButtonWithTitles:(NSMutableArray *)titles titleColor:(UIColor *)titleColor lineColor:(UIColor *)lineColor font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor
{
    CGFloat width = self.frame.size.width/titles.count;
    CGFloat height = self.frame.size.height;
    titleFont_ = font;
    buttonsArray = [[NSMutableArray alloc]init];
    chooseArray = [[NSMutableArray alloc]init];
    for (int i=0; i<titles.count; i++)
    {
        CGRect frame = CGRectMake(width * i, 0, width, height);
        UIButton *button = [self addButton:[titles objectAtIndex:i] titleColor:titleColor frame:frame backgroundColor:backgroundColor tag:kDropdownButtonTag+i];
        [buttonsArray addObject:button];
        [self addSubview:button];
        if (i > 0)
        {
            frame = CGRectMake(frame.origin.x, 0, 1, height);
            [self addLine:frame backgroundColor:lineColor];
        }
        [chooseArray addObject:[NSNumber numberWithBool:NO]];
    }
}

//添加按钮
- (UIButton *)addButton:(NSString *)title titleColor:(UIColor *)titleColor frame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor tag:(NSInteger)tag
{
    UIButton *button = [[UIButton alloc]init];
    //UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    button.tag = tag;
    button.titleLabel.font = titleFont_;
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor = backgroundColor;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *image = [UIImage imageNamed:@"GZMoFramework.bundle/images/expandableImage"];
    [button setImage:image forState:UIControlStateNormal];
    
    //设置标题显示位置
    float padding = (frame.size.width - (image.size.width + [title sizeWithFont:titleFont_].width)) / 2;
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, image.size.width + 5)];
    //设置图像显示位置
    if (self.imageAlignment == DropdownMenuImageAlignment_Left)
    {
        //图像左边显示
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, frame.size.width - (image.size.width + [title sizeWithFont:titleFont_].width) - 20)];
    }
    if (self.imageAlignment == DropdownMenuImageAlignment_Right)
    {
        //图像右边显示
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, padding * 2 + 5, 0, 0)];
    }
    if (self.imageAlignment == DropdownMenuImageAlignment_TitleRight)
    {
        //图像显示在标题右边
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, [title sizeWithFont:titleFont_].width + padding + 5, 0, 0)];
    }
    
    //[self addSubview:button];
    return button;
}

//添加分隔线
- (void)addLine:(CGRect)frame backgroundColor:(UIColor *)backgroundColor
{
    UIView *line = [[UIView alloc]init];
    line.frame = frame;
    line.backgroundColor = backgroundColor;
    [self addSubview:line];
}

//按钮事件
- (void)buttonAction:(UIButton *)button
{
    //NSLog(@"%ld", button.tag);
    NSInteger tag = button.tag - kDropdownButtonTag;
    BOOL choose = [[chooseArray objectAtIndex:tag]boolValue];
    
    choose = !choose;
    [chooseArray replaceObjectAtIndex:tag withObject:[NSNumber numberWithBool:choose]];
    if (choose)//转动360度
    {
        for (int i=0; i<chooseArray.count; i++)//其他的还原原角度位置
        {
            if (i != tag)
            {
                [chooseArray replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:NO]];
                UIButton *btn = [buttonsArray objectAtIndex:i];
                [self changeButton:btn rotationAngle:0];
                //[self.delegate hideDropdownMenu:i];
            }
        }
        [self changeButton:button rotationAngle:M_PI];
        [self.delegate showDropdownMenu:tag];
    }
    else//转动0度，还原原角度位置
    {
        [self changeButton:button rotationAngle:0];
        [self.delegate hideDropdownMenu:tag];
    }
}

/**
 *  修改按钮标题
 *
 *  @param index 索引
 *  @param title 修改的标题
 */
- (void)changeButtonWithIndex:(NSInteger)index title:(NSString *)title
{
    UIButton *button = [buttonsArray objectAtIndex:index];
    [button setTitle:title forState:UIControlStateNormal];
    [buttonsArray replaceObjectAtIndex:index withObject:button];
    
    NSInteger tag = button.tag - kDropdownButtonTag;
    BOOL choose = [[chooseArray objectAtIndex:tag]boolValue];
    choose = NO;
    [chooseArray replaceObjectAtIndex:tag withObject:[NSNumber numberWithBool:choose]];
}

/**
 *  修改按钮旋转角度
 *
 *  @param index         索引
 *  @param rotationAngle 旋转的角度
 */
- (void)changeButtonAngle:(NSInteger)index rotationAngle:(CGFloat)rotationAngle
{
    UIButton *button = [buttonsArray objectAtIndex:index];
    [self changeButton:button rotationAngle:rotationAngle];
    
    NSInteger tag = button.tag - kDropdownButtonTag;
    BOOL choose = [[chooseArray objectAtIndex:tag]boolValue];
    choose = NO;
    [chooseArray replaceObjectAtIndex:tag withObject:[NSNumber numberWithBool:choose]];
}

/**
 *  按钮旋转
 *
 *  @param button        旋转的按钮
 *  @param rotationAngle 旋转的角度
 */
- (void)changeButton:(UIButton *)button rotationAngle:(CGFloat)rotationAngle
{
    [UIView animateWithDuration:0.1f animations:^{
        button.imageView.transform = CGAffineTransformMakeRotation(rotationAngle);
    }];
}

@end
