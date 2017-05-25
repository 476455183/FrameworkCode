//
//  UITextField+Category.h
//  CustomControls
//
//  Created by mojx on 2017/4/27.
//  Copyright © 2017年 mojiaxun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Category)

/**
 超出限制长度时的警告闭包回调
 */
@property (nonatomic, copy) void(^warningBlock)();

/** 限制输入长度，最多可输入limitLength个字符*/
@property (nonatomic, assign) NSInteger limitLength;

/**
 添加编辑事件
 */
- (void)addEditingChanged;

@end
