//
//  UITextField+Category.m
//  CustomControls
//
//  Created by mojx on 2017/4/27.
//  Copyright © 2017年 mojiaxun. All rights reserved.
//

#import "UITextField+Category.h"
#import <objc/runtime.h>

static void *myKey = &myKey;
static void *myBlockKey = &myBlockKey;

@implementation UITextField (Category)

/**
 添加编辑事件
 */
- (void)addEditingChanged
{
    [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark - warningBlock
/**
 设置超出限制长度时的警告闭包

 @param aObject 空类型对象
 */
- (void)setWarningBlock:(void(^)())aObject
{
    objc_setAssociatedObject(self, myBlockKey, aObject,  OBJC_ASSOCIATION_COPY);
}

/**
 获取超出限制长度时的警告闭包
 */
- (void(^)())warningBlock
{
    return objc_getAssociatedObject(self, myBlockKey);
}

#pragma mark - limitLength
/**
 设置输入限制的长度

 @param limitLength 限制的长度
 */
- (void)setLimitLength:(NSInteger)limitLength
{
    objc_setAssociatedObject(self, &myKey, [NSNumber numberWithInteger:limitLength], OBJC_ASSOCIATION_ASSIGN);
}

/**
 获取限制的长度

 @return 限制的长度
 */
- (NSInteger)limitLength
{
    NSNumber *length = objc_getAssociatedObject(self, &myKey);
    return [length integerValue];
}

#pragma mark - 文本编辑事件
- (void)textFieldDidChange:(UITextField *)textField
{
    //限制输入长度，最多可输入limitLength个字符
    if (textField.text.length > self.limitLength)
    {
        textField.text = [textField.text substringToIndex:self.limitLength];
        if (self.warningBlock)
            self.warningBlock();
    }
}

@end
