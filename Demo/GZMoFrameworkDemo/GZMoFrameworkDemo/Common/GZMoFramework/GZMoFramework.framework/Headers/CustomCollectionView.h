//
//  CustomCollectionView.h
//  CustomControls
//
//  Created by mojx on 16/7/6.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import <UIKit/UIKit.h>

//定义协议
@protocol CollectionViewDidSelectRow

@optional//可选实现的方法
- (void)collectionViewDidSelectRowAtIndexPath:(NSIndexPath *)indexPath dataArray:(NSArray *)dataArray;

@end

@interface CustomCollectionView : UIView<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *myCollectionView;
/**数据数组*/
@property (nonatomic, strong) NSArray *dataArray;
/**图像数组*/
@property (nonatomic, strong) NSArray *imageArray;
/** CollectionView选中的item索引*/
@property (nonatomic) NSInteger selectedCell;

@property (nonatomic, assign) id<CollectionViewDidSelectRow> selectRowDelegate;//协议

@end
