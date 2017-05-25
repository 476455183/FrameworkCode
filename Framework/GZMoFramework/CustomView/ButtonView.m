//
//  FunctionButtonView.m
//  zqgzfwpt
//
//  Created by mojx on 2017/3/16.
//  Copyright © 2017年 mojiaxun. All rights reserved.
//

#import "ButtonView.h"

@interface ButtonView ()
{
}

@end

@implementation ButtonView

/**
 初始化
 
 @param frame 位置和大小
 @param title 标题
 @param imageName 图像名称
 @param color 标题颜色
 @param font 标题字体大小
 @return 实例对象
 */
- (id)initWithFrame:(CGRect)frame
              title:(NSString *)title
          imageName:(NSString *)imageName
              color:(UIColor *)color
               font:(UIFont *)font
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, frame.size.width-30, frame.size.height-30)];
        imageView.image = [UIImage imageNamed:imageName];
        [self addSubview:imageView];
        
        //
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height-20, frame.size.width, 20)];
        titleLable.text = title;
        titleLable.textColor = color;
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.font = font;
        [self addSubview:titleLable];
    }
    return self;
}

@end
