//
//  CustomCollectionViewCell.h
//  whrs
//
//  Created by mojx on 16/7/6.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCollectionViewCell : UICollectionViewCell

/**功能按钮*/
@property (nonatomic, weak) IBOutlet UIButton *functionButton;
/**功能按钮图像*/
@property (nonatomic, weak) IBOutlet UIImageView *functionImageView;
/**功能按钮背景图片*/
@property (nonatomic, weak) IBOutlet UIImageView *functionBkgImageView;
/**标题*/
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@end
