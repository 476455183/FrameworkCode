//
//  CustomImagePicker.m
//  CustomControls
//
//  Created by mojx on 16/9/5.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import "CustomImagePicker.h"

@implementation CustomImagePicker

//单例
+ (CustomImagePicker *)sharedSingleton
{
    static CustomImagePicker *sharedSingleton;
    @synchronized(self)
    {
        if (!sharedSingleton)
            sharedSingleton = [[CustomImagePicker alloc] init];
        return sharedSingleton;
    }
}

//弹出拍照对话菜单
- (void)takeAPhoto
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil//@"请选择"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"//buttonIndex为最后一个
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"拍照",@"来自图库",@"来自相册",nil];//buttonIndex从0开始
    [sheet showInView:self.viewControl.view];
}

//菜单选择
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0://拍照
            [self takePhoto:UIImagePickerControllerSourceTypeCamera];
            break;
        case 1://来自图库
            [self takePhoto:UIImagePickerControllerSourceTypePhotoLibrary];
            break;
        case 2://来自相册
            [self takePhoto:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
            break;
        case 3://取消
            break;
        default:
            break;
    }
}

//拍照或调用相册或调用图库
- (void)takePhoto:(UIImagePickerControllerSourceType)sourceType
{
    /*
     UIImagePickerControllerSourceTypePhotoLibrary ,//来自图库
     UIImagePickerControllerSourceTypeCamera ,//来自相机
     UIImagePickerControllerSourceTypeSavedPhotosAlbum //来自相册
     */
    
    //UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //判断是否有摄像头
    if(![UIImagePickerController isSourceTypeAvailable:sourceType])
    {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    /*
     if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
     {
     NSLog(@"支持相机");
     }
     if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
     {
     NSLog(@"支持图库");
     }
     if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
     {
     NSLog(@"支持相片库");
     }*/
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;   // 设置委托
    imagePickerController.sourceType = sourceType;
    //imagePickerController.allowsEditing = YES;
    [self.viewControl presentViewController:imagePickerController animated:YES completion:nil];  //需要以模态的形式展示
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    
}

//完成拍照
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    //NSLog(@"info: %@",info);
    //UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image == nil)
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //使用Block传值
    if (self.ImagePickerBlock)
        self.ImagePickerBlock(image);
}

//用户取消拍照
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.viewControl dismissViewControllerAnimated:YES completion:^{}];
}

@end
