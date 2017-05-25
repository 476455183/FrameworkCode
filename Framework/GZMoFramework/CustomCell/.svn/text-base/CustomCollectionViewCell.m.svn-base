//
//  CustomCollectionViewCell.m
//  whrs
//
//  Created by mojx on 16/7/6.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@implementation CustomCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])//初始化
    {
        UIImageView *functionBkgImageView_ = [[UIImageView alloc]initWithFrame:CGRectMake(5, 4, 80, 80)];
        UIImageView *functionImageView_ = [[UIImageView alloc]initWithFrame:CGRectMake(13, 11, 65, 65)];
        UIButton *functionButton_ = [[UIButton alloc]initWithFrame:CGRectMake(13, 11, 65, 65)];
        UILabel *titleLabel_ = [[UILabel alloc]initWithFrame:CGRectMake(0, 84, 90, 33)];
        self.functionBkgImageView = functionBkgImageView_;
        self.functionImageView = functionImageView_;
        self.functionButton = functionButton_;
        self.titleLabel = titleLabel_;
        
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        //[self addSubview:self.functionBkgImageView];
        [self addSubview:self.functionImageView];
        [self addSubview:self.functionButton];
        [self addSubview:self.titleLabel];
    }
    return self;
}

@end
