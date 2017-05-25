//
//  CustomAlertView.m
//  CustomDialog
//  自定义弹出对话框
//  Created by mojx on 2017/4/11.
//  Copyright © 2017年 mojiaxun. All rights reserved.
//

#import "CustomAlertView.h"

/** 对话框按钮最大个数*/
const static NSInteger buttonTitlesMaxCount  = 2;

@interface CustomAlertView ()
{
    /** 覆盖的背景视图*/
    UIView *backgroundView_;
    /** 富文本标签*/
    UILabel *textLabel;
}
@end

@implementation CustomAlertView

/**
 初始化对话框
 
 @param frame 位置、大小
 @param backgroundColor 背景颜色
 @param imageName 提示图片名称
 @param imageSize 提示图片大小
 @param imageTopEdge 提示图片顶部边缘大小
 @param title 对话框主标题
 @param titleColor 对话框主标题颜色
 @param titleFontSize 对话框主标题字体大小
 @param subtitle 对话框副标题
 @param subtitleColor 对话框副标题颜色
 @param subtitleFontSize 对话框副标题字体大小
 @param buttonTitles 对话框按钮，按钮个数目前限制<3个
 @return 实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame
              backgroundColor:(UIColor *)backgroundColor
                    imageName:(NSString *)imageName
                    imageSize:(CGSize)imageSize
                 imageTopEdge:(CGFloat)imageTopEdge
                        title:(NSString *)title
                   titleColor:(UIColor *)titleColor
                titleFontSize:(CGFloat)titleFontSize
                     subtitle:(NSString *)subtitle
                subtitleColor:(UIColor *)subtitleColor
             subtitleFontSize:(CGFloat)subtitleFontSize
                 buttonTitles:(NSMutableArray *)buttonTitles
{
    if (self = [super initWithFrame:frame])
    {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        backgroundView_ = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
        backgroundView_.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        
        self.tag = 1;
        //self.center = backgroundView.center;
        [backgroundView_ addSubview:self];
        [window addSubview:backgroundView_];
        
        self.backgroundColor = backgroundColor;
        self.layer.cornerRadius = 12;//设置圆角半径
        self.clipsToBounds = YES;//裁剪掉多余的视图
        
        //创建一个富文本
        self.mAttributeString = [[NSMutableAttributedString alloc] init];
        
        //添加提示图片
        if (imageName && ![imageName isEqualToString:@""])
        {
            //添加图片
            NSTextAttachment *attch = [[NSTextAttachment alloc] init];
            //设置图片
            attch.image = [UIImage imageNamed:imageName];
            //设置图片大小
            attch.bounds = CGRectMake((frame.size.width-imageSize.width)/2, imageTopEdge, imageSize.width, imageSize.height);
            //创建带有图片的富文本
            NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
            [self.mAttributeString appendAttributedString:string];
        }
        
        //添加标题
        if (title && ![title isEqualToString:@""])
        {
            //标题属性字典
            NSDictionary *attributeDic = @{NSFontAttributeName: [UIFont systemFontOfSize:titleFontSize], NSForegroundColorAttributeName:titleColor};
            //富文本字符串
            NSString *title_ = [NSString stringWithFormat:@"\n%@", title];
            if (!imageName || [imageName isEqualToString:@""])
                title_ = title;
            NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:title_ attributes:attributeDic];
            [self.mAttributeString appendAttributedString:attrString];
        }
        
        //添加副标题
        if (subtitle && ![subtitle isEqualToString:@""])
        {
            //副标题属性字典
            NSDictionary *attributeDic = @{NSFontAttributeName: [UIFont systemFontOfSize:subtitleFontSize], NSForegroundColorAttributeName:subtitleColor};
            //富文本字符串
            NSString *subtitle_ = [NSString stringWithFormat:@"\n%@", subtitle];
            if ((!imageName || [imageName isEqualToString:@""]) && (!title || [title isEqualToString:@""]))
                subtitle_ = subtitle;
            NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:subtitle_ attributes:attributeDic];
            [self.mAttributeString appendAttributedString:attrString];
        }
        
        //设置段落格式
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.alignment = NSTextAlignmentCenter;//设置对齐方式
        //style.firstLineHeadIndent = 80; // 首行缩进
        //style.headIndent = 25; // 其它行缩进
        //style.lineHeightMultiple = 1.5;//行间距是多少倍
        //style.paragraphSpacingBefore = 10;//段落之前的间距
        style.paragraphSpacing = 5;//段落后面的间距
        //style.lineSpacing = 20;//行距
        //需要设置的范围
        NSRange range = NSMakeRange(0, self.mAttributeString.length);
        [self.mAttributeString addAttribute:NSParagraphStyleAttributeName value:style range:range];
        
        //添加富文本标签
        textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-44)];
        //用label的attributedText属性来使用富文本
        textLabel.attributedText = self.mAttributeString;
        textLabel.numberOfLines = 0;
        //textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:textLabel];
        
        //创建按钮
        if (buttonTitles.count <= buttonTitlesMaxCount)
        {
            //添加横线
            UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-45, frame.size.width, 1)];
            lineview.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [self addSubview:lineview];
            
            for (int i=0; i< buttonTitles.count; i++)
            {
                CGRect bframe = CGRectMake(i*(frame.size.width/2), frame.size.height-44, frame.size.width/2, 44);
                if (buttonTitles.count == 1)
                    bframe.size.width = frame.size.width;
                
                //创建按钮
                NSDictionary *dic = [buttonTitles objectAtIndex:i];
                NSString *btitle = [dic objectForKey:@"title"];
                UIColor *bcolor = [dic objectForKey:@"titleColor"];
                CGFloat bfont = [[dic objectForKey:@"titleFontOfSize"]floatValue];
                UIButton *button = [self createButton:bframe title:btitle titleColor:bcolor fontOfSize:bfont tag:i];
                
                //添加竖线
                if (buttonTitles.count > 1 && i == 0)
                {
                    lineview = [[UIView alloc]initWithFrame:CGRectMake(frame.size.width/2, frame.size.height-45, 1, 44)];
                    lineview.backgroundColor = [UIColor groupTableViewBackgroundColor];
                    [self addSubview:lineview];
                }
                
                [self addSubview:button];
            }
        }
    }
    return self;
}

/**
 更新对话框富文本标签的富文本
 
 @param attributedString 富文本
 */
- (void)updateTextLabelAttributedText:(NSMutableAttributedString *)attributedString
{
    if (textLabel)
        textLabel.attributedText = attributedString;
}

/**
 创建按钮

 @param frame 位置、大小
 @param title 按钮标题
 @param titleColor 按钮标题颜色
 @param fontOfSize 按钮标题字体大小
 @param tag 标志
 @return 按钮对象
 */
- (UIButton *)createButton:(CGRect)frame
                     title:(NSString *)title
                titleColor:(UIColor *)titleColor
                fontOfSize:(CGFloat)fontOfSize
                       tag:(NSInteger)tag
{
    //按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.tag = tag;
    button.titleLabel.font = [UIFont systemFontOfSize: fontOfSize];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

//按钮点击事件
- (void)buttonAction:(UIButton *)sender
{
    if (self.buttonBlock)
        self.buttonBlock(sender);
    [backgroundView_ removeFromSuperview];
}

@end
