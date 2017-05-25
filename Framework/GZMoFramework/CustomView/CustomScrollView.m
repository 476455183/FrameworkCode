//
//  CustomScrollView.m
//  CustomControls
//
//  Created by mojx on 16/7/17.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import "CustomScrollView.h"
#import "GZPublicMethod.h"

@interface CustomScrollView ()
{
    NSDictionary *attributeDictionary1;
    NSDictionary *attributeDictionary2;
}
@end

@implementation CustomScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/**
 *  初始化数据
 *
 *  @param text            文本数据
 *  @param textFont        文本字体
 *  @param backgroundColor 背景颜色
 *  @param backgroundView  背景图片
 */
- (void)initData:(NSString *)text textFont:(UIFont *)textFont backgroundColor:(UIColor *)backgroundColor backgroundView:(UIView *)backgroundView
{
    //添加UIScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.bounds;
    [self addSubview:scrollView];
    
    [scrollView addSubview: backgroundView];
    
    CGSize text_size = [GZPublicMethod sizeWithString:text font:textFont maxSize:CGSizeMake(self.frame.size.width, MAXFLOAT)];
    //设置内容范围
    if (text_size.height < self.frame.size.height)
        scrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    else
        scrollView.contentSize = CGSizeMake(self.frame.size.width, text_size.height);
    
    CGFloat offset = 20;
    UITextView *text_view = [[UITextView alloc]initWithFrame:CGRectMake(offset, offset, self.frame.size.width - offset, text_size.height)];
    text_view.textAlignment = NSTextAlignmentLeft;
    text_view.text = text;
    text_view.editable = NO;
    [text_view setUserInteractionEnabled: NO];
    [scrollView addSubview:text_view];
    
    self.backgroundColor = [UIColor clearColor];
    scrollView.backgroundColor = backgroundColor;//[UIColor clearColor];
    text_view.backgroundColor = [UIColor clearColor];
}

/**
 *  初始化数据
 *
 *  @param keys            数据keys，keys和values中的值必须一一对应
 *  @param values          数据values
 *  @param keyColor        key字体颜色
 *  @param valueColor      value字体颜色
 *  @param font            字体
 *  @param backgroundColor 背景颜色
 *  @param backgroundView  背景图片
 */
- (void)initData:(NSMutableArray *)keys values:(NSMutableArray *)values keyColor:(UIColor *)keyColor valueColor:(UIColor *)valueColor font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor backgroundView:(UIView *)backgroundView
{
    if (keys.count != values.count)
        return;

    [self initAttributeDictionary: font keyColor:keyColor valueColor:valueColor];
    
    //添加UIScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.bounds;
    [self addSubview:scrollView];
    
    //UIImageView *backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"girl_003"]];
    //backgroundView.alpha = 0.1;
    [scrollView addSubview: backgroundView];
    
    NSMutableAttributedString *mabstrings = [[NSMutableAttributedString alloc]init];
    for (int i=0; i< keys.count; i++)
    {
        NSString *str = [NSString stringWithFormat:@"%@",[keys objectAtIndex:i]];
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:str attributes:attributeDictionary1];
        [mabstrings appendAttributedString:attrString];
        str = [NSString stringWithFormat:@"%@\r\n\r\n",[values objectAtIndex:i]];
        attrString = [[NSAttributedString alloc] initWithString:str attributes:attributeDictionary2];
        [mabstrings appendAttributedString:attrString];
    }
    
    CGSize text_size = [GZPublicMethod sizeWithString:mabstrings.string font:font maxSize:CGSizeMake(self.frame.size.width, MAXFLOAT)];
    //设置内容范围
    if (text_size.height < self.frame.size.height)
        scrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    else
        scrollView.contentSize = CGSizeMake(self.frame.size.width, text_size.height);
    
    CGFloat offset = 20;
    UITextView *text_view = [[UITextView alloc]initWithFrame:CGRectMake(offset, offset, self.frame.size.width - offset, text_size.height)];
    text_view.textAlignment = NSTextAlignmentLeft;
    text_view.attributedText = mabstrings;
    text_view.editable = NO;
    [text_view setUserInteractionEnabled: NO];
    [scrollView addSubview:text_view];
    
    self.backgroundColor = [UIColor clearColor];
    scrollView.backgroundColor = backgroundColor;//[UIColor clearColor];
    text_view.backgroundColor = [UIColor clearColor];
}

//初始化属性字典
-(void)initAttributeDictionary:(UIFont *)font keyColor:(UIColor *)keyColor valueColor:(UIColor *)valueColor
{
    //字体
    //UIFont *font = [UIFont fontWithName:@"Helvetica" size:13];
    //段落
    NSMutableParagraphStyle *ps = [[NSMutableParagraphStyle alloc] init];
    ps.alignment = NSTextAlignmentCenter;//设置对齐方式
    ps.lineSpacing = 0.0;//行距
    //颜色
    UIColor *color = keyColor;//[UIColor blackColor];
    //属性字典
    attributeDictionary1 = @{NSFontAttributeName: font, NSParagraphStyleAttributeName:ps, NSForegroundColorAttributeName:color};
    
    //段落
    ps.alignment = NSTextAlignmentLeft;//设置对齐方式
    ps.lineSpacing = 0.0;//行距
    //颜色
    color = valueColor;//[UIColor darkGrayColor];
    //属性字典
    attributeDictionary2 = @{NSFontAttributeName: font, NSParagraphStyleAttributeName:ps, NSForegroundColorAttributeName:color};
}

@end
