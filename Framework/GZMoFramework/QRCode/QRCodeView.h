//
//  QRCodeView.h
//  CustomControls
//
//  Created by mojx on 16/9/6.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface QRCodeView : UIView<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSArray *metadataObjectsArray;
    NSString *qrCodeValue;
    
    NSTimer *scanTimer;
    UIImageView *_QrCodeline;
    UIButton *qrCodeInfoButton;
    BOOL isScanning;
    
    UIView *viewPreview;
    UIView *boxView;
}

/** 视图控制器*/
@property(nonatomic, strong) UIViewController *viewControl;
/** 是否显示二维码按钮，默认为显示*/
@property(nonatomic) BOOL isShowQrcodeButton;
//捕捉会话
@property (nonatomic, strong) AVCaptureSession *captureSession;
//展示layer
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;

/**
 *  初始化
 *
 *  @param frame   位置大小
 *  @param control 视图控制器
 *
 *  @return 实例
 */
- (instancetype)initWithFrame:(CGRect)frame controller:(UIViewController *)control;

@end
