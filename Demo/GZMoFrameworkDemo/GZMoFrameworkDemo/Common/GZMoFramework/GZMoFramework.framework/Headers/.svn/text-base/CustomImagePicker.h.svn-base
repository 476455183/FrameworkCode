//
//  CustomImagePicker.h
//  CustomControls
//
//  Created by mojx on 16/9/5.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CustomImagePicker : NSObject<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

/** 单例*/
+ (CustomImagePicker *)sharedSingleton;

/** 视图控制器*/
@property(nonatomic, strong) UIViewController *viewControl;
/** 图片回调*/
@property(nonatomic, strong) void(^ImagePickerBlock)(UIImage *image);

//- (id)initWithViewControl:(UIViewController *)control;

/** 拍照*/
- (void)takeAPhoto;

@end
