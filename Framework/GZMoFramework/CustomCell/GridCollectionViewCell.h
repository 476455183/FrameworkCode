//
//  GridCollectionViewCell.h
//  CustomControls
//
//  Created by mojx on 2016/11/5.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridCollectionViewCell : UICollectionViewCell

/** 功能按钮*/
@property (nonatomic, weak) IBOutlet UIButton *functionButton;
/** 功能图片*/
@property (nonatomic, weak) IBOutlet UIImageView *functionImageView;
/** 功能背景图片*/
@property (nonatomic, weak) IBOutlet UIImageView *functionBkgImageView;
/** 标题*/
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
/** 显示消息的view*/
@property (nonatomic, weak) IBOutlet UIView *badgeView;

@end
