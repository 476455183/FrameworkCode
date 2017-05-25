//
//  QRCodeView.m
//  CustomControls
//
//  Created by mojx on 16/9/6.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import "QRCodeView.h"
#import "GZPublicConst.h"

@implementation QRCodeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/**
*  初始化
*
*  @param frame   位置大小
*  @param control 视图控制器
*
*  @return 实例
*/
- (instancetype)initWithFrame:(CGRect)frame controller:(UIViewController *)control
{
    if (self = [super initWithFrame:frame])
    {
        /* 添加子控件的代码
         在重新构造方法的时候,我们只需要把控件放进去,暂时先不用考虑他们在什么位置,而是在layoutSubViews方法里面布局子控件
         */
        self.viewControl = control;
        self.isShowQrcodeButton = YES;
        [self viewInit];
    }
    return self;
}

//在layoutSubViews方法里面布局子控件
- (void)layoutSubviews
{
    // 一定要调用super的方法
    [super layoutSubviews];
}

- (void)viewInit
{    
    _captureSession = nil;
    
    //二维码button
    qrCodeInfoButton = [[ UIButton alloc ] initWithFrame : CGRectMake ( (self.frame.size.width-116)/2 , self.frame.size.height/2 - 36 , 116 , 36 )];
    [qrCodeInfoButton setTitle:@"发现二维码" forState:UIControlStateNormal];
    qrCodeInfoButton.titleLabel.font = [UIFont systemFontOfSize:15];
    qrCodeInfoButton.layer.cornerRadius = 18;
    qrCodeInfoButton.layer.borderColor = [UIColor whiteColor].CGColor;
    qrCodeInfoButton.layer.borderWidth = 1;
    [qrCodeInfoButton addTarget : self action : @selector (QRCodeInfo:) forControlEvents : UIControlEventTouchUpInside ];
    [qrCodeInfoButton setHidden:YES];
    [self addSubview :qrCodeInfoButton];
    
    [self startStopScanning];
}

- (BOOL)startScanning
{
    NSError *error;
    
    //1.初始化捕捉设备（AVCaptureDevice），类型为AVMediaTypeVideo
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //2.用captureDevice创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input)
    {
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    
    //3.创建媒体数据输出流
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    
    //4.实例化捕捉会话
    _captureSession = [[AVCaptureSession alloc] init];
    
    //4.1.将输入流添加到会话
    [_captureSession addInput:input];
    
    //4.2.将媒体输出流添加到会话中
    [_captureSession addOutput:captureMetadataOutput];
    
    //高质量采集率
    //[_captureSession setSessionPreset:AVCaptureSessionPresetHigh];
    
    //5.创建串行队列，并加媒体输出流添加到队列当中
    //[captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    dispatch_queue_t dispatchQueue = dispatch_queue_create("myQueue", NULL);
    //5.1.设置代理
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    
    //5.2.设置输出媒体数据类型为QRCode
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    captureMetadataOutput.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    //6.实例化预览图层
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    
    //7.设置预览图层填充方式
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    //_videoPreviewLayer.videoGravity = AVLayerVideoGravityResize;
    
    //8.设置图层的frame
    CGRect frame = self.frame;
    frame.origin.y = 0;
    viewPreview = [[UIView alloc]initWithFrame:frame];
    [self addSubview :viewPreview];
    [self bringSubviewToFront:qrCodeInfoButton];
    [_videoPreviewLayer setFrame:viewPreview.layer.bounds];
    
    //9.将图层添加到预览view的图层上
    [viewPreview.layer addSublayer:_videoPreviewLayer];
    
    /*资源库GZMoFramework.bundle，新建文件夹GZMoFramework，将后缀名改为.bundle，即可生成资源库。往资源库添加文件时，点击资源库，右键点击显示包内容，然后往其添加文件即可，如图片等。和GZMoFramework.framework一起使用时，GZMoFramework.framework拖至工程下，GZMoFramework.bundle拖至工程下时需要选择copy items if needed。资源访问使用如：[UIImage imageNamed:@"GZMoFramework.bundle/qrcode_images/codebox"]。
    */
    
    //UIImageView *imageview = [[UIImageView alloc]initWithFrame:self.view.frame];
    //imageview.image = [UIImage imageNamed:@"GZMoFramework.bundle/qrcode_images/codebox"];
    //NSString *image_path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"GZMoFramework.bundle/qrcode_images/codebox"];
    //imageview.image = [UIImage imageWithContentsOfFile:image_path];
    
    //10.扫描框
    boxView =[[ UIImageView alloc ] initWithFrame : CGRectMake ( SCANVIEW_EdgeLeft-5 , SCANVIEW_EdgeTop-7.0 , kScreenWidth - 2 * SCANVIEW_EdgeLeft+9, kScreenWidth - 2 * SCANVIEW_EdgeLeft+15.0 )];
    //UIImageView *boxImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"codebox"]];
    UIImageView *boxImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"GZMoFramework.bundle/qrcode_images/codebox"]];
    boxImageView.frame = CGRectMake(0, 0, boxView.frame.size.width, boxView.frame.size.height);
    [boxView addSubview:boxImageView];
    //boxView.layer.borderColor = [UIColor greenColor].CGColor;
    //boxView.layer.borderWidth = 1.0f;
    boxView.tag = 100;
    
    //10.1设置扫描范围（默认时为全屏扫描）
    //captureMetadataOutput.rectOfInterest = CGRectMake(0.2f, 0.2f, 0.8f, 0.8f);
    frame = CGRectMake(boxView.frame.origin.y/kScreenHeight,boxView.frame.origin.x/kScreenWidth,boxView.frame.size.height/kScreenHeight,boxView.frame.size.width/kScreenWidth);
    [captureMetadataOutput setRectOfInterest:frame];
    
    //重置二维码按钮位置
    frame = qrCodeInfoButton.frame;
    frame.origin.y = boxView.frame.origin.y + boxView.frame.size.height - frame.size.height - 20;
    
    //用于说明的label
    UILabel *remarkLabel= [[ UILabel alloc ] init ];
    remarkLabel.backgroundColor = [ UIColor clearColor];
    remarkLabel.frame = CGRectMake ( (self.frame.size.width-250)/2 , boxView.frame.origin.y + boxView.frame.size.height + 20 , 250 , 20 );
    remarkLabel.numberOfLines = 1 ;
    remarkLabel.font =[ UIFont systemFontOfSize : 15.0 ];
    remarkLabel.textAlignment = NSTextAlignmentCenter ;
    remarkLabel.textColor =[ UIColor whiteColor ];
    remarkLabel.text = @"将二维码对准方框，即可自动扫描";
    [viewPreview addSubview:remarkLabel];
    
    //底部view
    UIView *darkView = [[ UIView alloc ] initWithFrame:CGRectMake(0, self.frame.size.height - 130.0, self.frame.size.width, 130.0)];
    //darkView.backgroundColor = [[ UIColor clearColor ] colorWithAlphaComponent : DARKCOLOR_ALPHA ];
    darkView.backgroundColor = [[ UIColor blackColor ] colorWithAlphaComponent : TINTCOLOR_ALPHA ];
    
    //闪光灯button
    CGFloat xoffset = (self.frame.size.width-72*2)/3;
    UIButton *openButton=[[ UIButton alloc ] initWithFrame : CGRectMake ( xoffset , 10 , 72 , 110 )];
    //[openButton setBackgroundImage:[UIImage imageNamed:@"onlight"] forState:UIControlStateNormal];
    [openButton setBackgroundImage:[UIImage imageNamed:@"GZMoFramework.bundle/qrcode_images/onlight"] forState:UIControlStateNormal];
    [openButton addTarget : self action : @selector (openLight:) forControlEvents : UIControlEventTouchUpInside];
    [darkView addSubview :openButton];
    
    //相册button
    UIButton *photoAlbumButton=[[ UIButton alloc ] initWithFrame : CGRectMake ( xoffset*2 + 72 , 10 , 72 , 110 )];
    //[photoAlbumButton setBackgroundImage:[UIImage imageNamed:@"Photoalbum_normal"] forState:UIControlStateNormal];
    [photoAlbumButton setBackgroundImage:[UIImage imageNamed:@"GZMoFramework.bundle/qrcode_images/Photoalbum_normal"] forState:UIControlStateNormal];
    [photoAlbumButton addTarget : self action : @selector (openPhotoAlbum:) forControlEvents : UIControlEventTouchUpInside ];
    [darkView addSubview :photoAlbumButton];
    
    [viewPreview addSubview:boxView];
    [self addSubview :darkView];
    
    //10.2.扫描线
    _QrCodeline = [[ UIImageView alloc ] initWithFrame: CGRectMake(3, SCANVIEW_EdgeTop, boxView.bounds.size.width - 6, 2)];
    //_QrCodeline . backgroundColor = [ UIColor greenColor ];
    //_QrCodeline.image=[UIImage imageNamed:@"codeline"];
    _QrCodeline.image=[UIImage imageNamed:@"GZMoFramework.bundle/qrcode_images/codeline"];
    [ boxView addSubview : _QrCodeline ];
    
    //创建一个时间计数
    scanTimer=[NSTimer scheduledTimerWithTimeInterval: 1.0 target: self selector: @selector (moveUpAndDownLine) userInfo: nil repeats: YES ];
    //开启定时器
    //[scanTimer setFireDate:[NSDate distantPast]];
    
    //10.开始扫描
    [_captureSession startRunning];
    
    return YES;
}

- (IBAction)startStopScanning
{
    if (isScanning)
    {
        [self stopScanning];
        isScanning = NO;
        [qrCodeInfoButton setHidden:YES];
        //关闭定时器
        [scanTimer setFireDate:[NSDate distantFuture]];
    }
    else
    {
        if ([self startScanning])
            isScanning = YES;
    }
}

- (void)stopScanning
{
    [_captureSession stopRunning];
    _captureSession = nil;
    [_videoPreviewLayer removeFromSuperlayer];
    //对view上的控件删除或隐藏
    for (UIView *view in viewPreview.subviews)
    {
        if([view isKindOfClass:[boxView class]] && (view.tag == 100))//如果有多个同类型的View可以通过tag来区分
        {
            //[view setHidden:YES];//隐藏此控件
            [view removeFromSuperview];//删除此控件
        }
    }
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    //判断是否有数据
    if (metadataObjects != nil && [metadataObjects count] > 0)
    {
        metadataObjectsArray = metadataObjects;
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        //NSLog(@"type: %@; value: %@", [metadataObj type], [metadataObj stringValue]);
        //type: org.iso.QRCode; value: http://d.nuomi.com/?1013465g
        //NSLog(@"v: %@",AVMetadataObjectTypeQRCode);
        //判断回传的数据类型
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode])//二维码
        {
            if (self.isShowQrcodeButton)//显示按钮，由用户决定是否访问url
                [self performSelectorOnMainThread:@selector(showQRCodeInfo:) withObject:metadataObj waitUntilDone:YES];
            else//直接访问url
            {
                //判断是否包含 头'http:'
                NSString *regex = @"http+:[^\\s]*" ;
                NSPredicate *predicate = [ NSPredicate predicateWithFormat : @"SELF MATCHES %@" ,regex];
                qrCodeValue = [metadataObj stringValue];
                if ([predicate evaluateWithObject :qrCodeValue])
                {
                    //打开url链接
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:qrCodeValue]];
                }
            }
        }
        else if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeEAN13Code] ||
                 [[metadataObj type] isEqualToString:AVMetadataObjectTypeEAN8Code] ||
                 [[metadataObj type] isEqualToString:AVMetadataObjectTypeCode128Code] )//条形码
        {
            [self performSelectorOnMainThread:@selector(showBarCodeInfo:) withObject:metadataObj waitUntilDone:YES];
        }
    }
}
//二维码
-(void)showQRCodeInfo:(AVMetadataMachineReadableCodeObject *)metadataObj
{
    [qrCodeInfoButton setHidden:NO];
    [qrCodeInfoButton setTitle:@"发现二维码" forState:UIControlStateNormal];
    qrCodeValue = [metadataObj stringValue];
}
//条形码
-(void)showBarCodeInfo:(AVMetadataMachineReadableCodeObject *)metadataObj
{
    [qrCodeInfoButton setHidden:NO];
    [qrCodeInfoButton setTitle:@"发现条形码" forState:UIControlStateNormal];
    qrCodeValue = [metadataObj stringValue];
}

-(IBAction)QRCodeInfo:(id)sender
{
    //NSLog(@"qrCodeValue: %@",qrCodeValue);
    [qrCodeInfoButton setHidden:YES];
    
    AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjectsArray objectAtIndex:0];
    //判断回传的数据类型
    if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode])//二维码
    {
        UIAlertView* alview = [[UIAlertView alloc] initWithTitle:@"二维码" message:qrCodeValue delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"访问", nil];
        alview.tag=100;
        [alview show];
    }
    else if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeEAN13Code] ||
             [[metadataObj type] isEqualToString:AVMetadataObjectTypeEAN8Code] ||
             [[metadataObj type] isEqualToString:AVMetadataObjectTypeCode128Code] )//条形码
    {
        UIAlertView* alview = [[UIAlertView alloc] initWithTitle:@"条形码" message:qrCodeValue delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alview show];
    }
}

#pragma marks -- UIAlertViewDelegate --
//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100 && buttonIndex == alertView.firstOtherButtonIndex)//二维码
    {
        //判断是否包含 头'http:'
        NSString *regex = @"http+:[^\\s]*" ;
        NSPredicate *predicate = [ NSPredicate predicateWithFormat : @"SELF MATCHES %@" ,regex];
        if ([predicate evaluateWithObject :qrCodeValue])
        {
            //打开url链接
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:qrCodeValue]];
        }
    }
}

//二维码的横线移动
- ( void )moveUpAndDownLine
{
    CGFloat Y = _QrCodeline.frame.origin.y;
    if ((boxView.bounds.size.width - 6) - SCANVIEW_EdgeTop == Y)
    {
        [UIView beginAnimations: @"asa" context: nil];
        [UIView setAnimationDuration: 1 ];
        _QrCodeline.frame=CGRectMake(3, SCANVIEW_EdgeTop, boxView.bounds.size.width - 6, 2 );
        [UIView commitAnimations];
    } else if (SCANVIEW_EdgeTop == Y)
    {
        [UIView beginAnimations: @"asa" context: nil];
        [UIView setAnimationDuration: 1 ];
        _QrCodeline.frame=CGRectMake(3, (boxView.bounds.size.width - 6) - SCANVIEW_EdgeTop, boxView.bounds.size.width - 6, 2 );
        [UIView commitAnimations];
    }
}

//开启或关闭闪光灯
- ( void )openLight:(UIButton *)btn
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch])//判断是否有闪光灯
    {
        if (device.torchActive)//关闭闪光灯
        {
            [device lockForConfiguration:nil];
            [device setTorchMode: AVCaptureTorchModeOff];
            [device unlockForConfiguration];
            //[btn setBackgroundImage:[UIImage imageNamed:@"onlight"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"GZMoFramework.bundle/qrcode_images/onlight"] forState:UIControlStateNormal];
        }
        else//打开闪光灯
        {
            [device lockForConfiguration:nil];//锁定闪光灯
            [device setTorchMode: AVCaptureTorchModeOn];//打开闪光灯
            [device unlockForConfiguration];  //解除锁定
            //[btn setBackgroundImage:[UIImage imageNamed:@"onlight_highit"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"GZMoFramework.bundle/qrcode_images/onlight_highit"] forState:UIControlStateNormal];
        }
    }
}

//打开相册
- (void)openPhotoAlbum:(UIButton *)btn
{
    //拍照
    //[self takePhoto:UIImagePickerControllerSourceTypeCamera];
    //来自图库
    //[self takePhoto:UIImagePickerControllerSourceTypePhotoLibrary];
    //来自相册
    [self takePhoto:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
}

#pragma mark - 打开相册或拍照
-(void)takePhoto:(UIImagePickerControllerSourceType)sourceType
{
    //判断是否有摄像头
    if(![UIImagePickerController isSourceTypeAvailable:sourceType])
    {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;   // 设置委托
    imagePickerController.sourceType = sourceType;
    //imagePickerController.allowsEditing = YES;
    //[self presentViewController:imagePickerController animated:YES completion:nil];
    //翻转动画
    imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self.viewControl presentViewController:imagePickerController animated:YES completion:NULL];
}

//完成拍照
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //1.获取选择的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    //2.初始化一个监测器
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
    [picker dismissViewControllerAnimated:YES completion:^{
        //监测到的结果数组
        NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
        if (features.count > 0)
        {
            //结果对象
            CIQRCodeFeature *qrCodeFeature = [features objectAtIndex:0];
            qrCodeValue = qrCodeFeature.messageString;
            UIAlertView* alview = [[UIAlertView alloc] initWithTitle:@"二维码" message:qrCodeValue delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"访问", nil];
            alview.tag = 100;
            [alview show];
        }
        else
        {
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有检测到二维码！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }];
}
//用户取消拍照
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.viewControl dismissViewControllerAnimated:YES completion:^{}];
}

@end
