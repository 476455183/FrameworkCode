//
//  GridCollectionViewCell.m
//  CustomControls
//
//  Created by mojx on 2016/11/5.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import "GridCollectionViewCell.h"

@implementation GridCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //设置图层边框和背景颜色
        //self.layer.borderWidth = 0.5;
        //self.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        self.backgroundColor = [UIColor whiteColor];
        
        //设置图片与标题大小
        CGFloat imageWidth = frame.size.width*0.4, imageHeight = imageWidth;
        CGFloat titleWidth = self.frame.size.width, titleHeight = 33, offset = 5;
        
        //背景图片与功能图片
        UIImageView *functionBkgImageView_ = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        UIImageView *functionImageView_ = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width-imageWidth)/2, (self.frame.size.height-imageHeight-titleHeight)/2, imageWidth, imageHeight)];
        [functionImageView_ setUserInteractionEnabled:YES];
        
        //显示消息的view
        UIView *badgeView_ = [[UIView alloc]initWithFrame:functionImageView_.frame];
        
        //按钮
        UIButton *functionButton_ = [UIButton buttonWithType:UIButtonTypeSystem];
        functionButton_.frame = functionBkgImageView_.frame;
        
        //添加长按手势
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(gridLongPress:)];
        [functionButton_ addGestureRecognizer:longPressGesture];
        
        //标题
        UILabel * titleLabel_ = [[UILabel alloc]initWithFrame:CGRectMake(0, (self.frame.size.height-imageHeight-titleHeight)/2+imageHeight+offset, titleWidth, titleHeight)];
        titleLabel_.font = [UIFont systemFontOfSize:13];
        titleLabel_.numberOfLines = 2;
        titleLabel_.textAlignment = NSTextAlignmentCenter;
        
        self.functionBkgImageView = functionBkgImageView_;
        self.functionImageView = functionImageView_;
        self.functionButton = functionButton_;
        self.titleLabel = titleLabel_;
        self.badgeView = badgeView_;
        
        [self addSubview:self.functionBkgImageView];
        [self addSubview:self.functionImageView];
        [self addSubview:self.badgeView];
        [self addSubview:self.functionButton];
        [self addSubview:self.titleLabel];
    }
    return self;
}

//响应格子的长按手势事件
- (void)gridLongPress:(UILongPressGestureRecognizer *)longPressGesture
{
    switch (longPressGesture.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            self.functionImageView.alpha = 0.8;
            self.functionBkgImageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            self.functionImageView.alpha = 1;
            self.functionBkgImageView.backgroundColor = [UIColor clearColor];
            break;
        }
        default:
            break;
    }
}

@end
