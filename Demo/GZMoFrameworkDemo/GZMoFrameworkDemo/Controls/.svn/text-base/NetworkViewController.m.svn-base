//
//  NetworkViewController.m
//  CustomControls
//
//  Created by mojx on 16/9/22.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import "NetworkViewController.h"

@implementation NetworkViewController

//外网开发服务器
#define kServerIP_yjyb @"http://61.28.113.182:2082"

/**超时时间*/
static const int kTimeOut = 10;
/**医生组ID*/
static const int kDoctorGroupId = 72;
/**医生ID*/
static const int KDoctorId = 176;


#pragma mark - NSURLSession

- (IBAction)NSURLSession_GET:(id)sender
{
    //判断是否有网络
    if(![[GZNetworkTool sharedNetworkTool] connectedToNetwork])
    {
        [self toastMessage:@"当前网络不可用，请保证网络畅通。" delay:2];
        return;
    }
    
    //获取已签约居民列表
    NSString *url = [NSString stringWithFormat:@"%@%@", kServerIP_yjyb, @"/yjyb/sign/person/list"];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:[NSNumber numberWithLong:kDoctorGroupId] forKey:@"doctor_group_id"];
    
    //发送GET请求
    [[GZNetworkTool sharedNetworkTool] requestWithUrl:url paramaters:params successBlock:^(id object, NSURLResponse *response)
     {
         NSLog(@"GET网络请求成功: %@", object);
         @try
         {
             long statusCode = [[object objectForKey:@"statusCode"]longValue];
             if (statusCode == 200)
             {
                 NSArray *result = [object objectForKey:@"result"];
                 NSLog(@"获取服务器数据成功: %@", result);
             }
             else
             {
                 NSString *message = [NSString stringWithFormat:@"获取服务器数据失败: %@; statusCode: %ld", [object objectForKey:@"message"], statusCode];
                 NSLog(@"%@", message);
                 [self toastMessage:message delay:2];
             }
         } @catch (NSException *exception)
         {
             NSLog(@"异常: %@", exception.description);
             NSString *message = [NSString stringWithFormat:@"GET网络请求失败"];
             [self toastMessage:message delay:2];
         }
     }
     failBlock:^(NSError *error)
     {
         NSLog(@"GET网络请求失败: %@", error.localizedDescription);
         [self toastMessage:@"GET网络请求失败" delay:2];
     } timeout:kTimeOut httpMethod:RequestHTTPMethod_GET];
}

- (IBAction)NSURLSession_POST:(id)sender
{
    //判断是否有网络
    if(![[GZNetworkTool sharedNetworkTool] connectedToNetwork])
    {
        [self toastMessage:@"当前网络不可用，请保证网络畅通。" delay:2];
        return;
    }
    
    //根据医生编号获取医生的基本信息
    NSString *url = [NSString stringWithFormat:@"%@%@",kServerIP_yjyb, @"/yjyb/doctor/info/get"];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:[NSNumber numberWithLong:KDoctorId] forKey:@"doctor_id"];
    
    //发送POST请求
    [[GZNetworkTool sharedNetworkTool] requestWithUrl:url paramaters:params successBlock:^(id object, NSURLResponse *response)
     {
         NSLog(@"POST网络请求成功: %@", object);
         @try
         {
             long statusCode = [[object objectForKey:@"statusCode"]longValue];
             if (statusCode == 200)
             {
                 NSArray *result = [object objectForKey:@"result"];
                 NSLog(@"获取服务器数据成功: %@", result);
             }
             else
             {
                 NSString *message = [object objectForKey:@"message"];
                 NSLog(@"获取服务器数据失败: %@; statusCode: %ld", message, statusCode);
             }
         } @catch (NSException *exception)
         {
             NSLog(@"异常: %@", exception.description);
         }
     }
     failBlock:^(NSError *error)
     {
         NSLog(@"POST网络请求失败: %@", error.localizedDescription);
     } timeout:kTimeOut httpMethod:RequestHTTPMethod_POST];
}

- (IBAction)NSURLSession_DELETE:(id)sender
{
    //判断是否有网络
    if(![[GZNetworkTool sharedNetworkTool] connectedToNetwork])
    {
        [self toastMessage:@"当前网络不可用，请保证网络畅通。" delay:2];
        return;
    }
    
    //删除签约预约排班时间段
    long sign_schedual_id = 10;
    NSString *url = [NSString stringWithFormat:@"%@%@%ld",kServerIP_yjyb, @"/yjyb/sign/timebucket/deletebucket/",sign_schedual_id];

    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:[NSNumber numberWithLong:sign_schedual_id] forKey:@"sign_schedual_id"];
    
    //发送DELETE请求
    [[GZNetworkTool sharedNetworkTool] requestWithUrl:url paramaters:params successBlock:^(id object, NSURLResponse *response)
     {
         NSLog(@"DELETE网络请求成功: %@", object);
         @try
         {
             long statusCode = [[object objectForKey:@"statusCode"]longValue];
             if (statusCode == 200)
             {
                 long result = [[object objectForKey:@"result"]longValue];
                 NSLog(@"获取服务器数据成功: %ld", result);
             }
             else
             {
                 NSString *message = [object objectForKey:@"message"];
                 NSLog(@"获取服务器数据失败: %@; statusCode: %ld", message, statusCode);
             }
         } @catch (NSException *exception)
         {
             NSLog(@"异常: %@", exception.description);
         }
     }
     failBlock:^(NSError *error)
     {
         NSLog(@"DELETE网络请求失败: %@", error.localizedDescription);
     } timeout:kTimeOut httpMethod:RequestHTTPMethod_DELETE];
}

- (IBAction)NSURLSession_PUT:(id)sender
{
    //判断是否有网络
    if(![[GZNetworkTool sharedNetworkTool] connectedToNetwork])
    {
        [self toastMessage:@"当前网络不可用，请保证网络畅通。" delay:2];
        return;
    }
    
    //修改医生信息
    NSString *url = [NSString stringWithFormat:@"%@%@",kServerIP_yjyb, @"/yjyb/doctor/info/update"];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:[NSNumber numberWithLong:KDoctorId] forKey:@"doctor_id"];
    [params setValue:@"15902010888" forKey:@"doc_phone"];
    [params setValue:@"广州天河区软件路15号" forKey:@"doc_address"];
    [params setValue:@"888888@qq.com" forKey:@"doc_email"];
    [params setValue:@"专治各种疑难杂症、风湿骨痛、坐骨神经等" forKey:@"doc_describe"];
    
    //发送PUT请求
    [[GZNetworkTool sharedNetworkTool] requestWithUrl:url paramaters:params successBlock:^(id object, NSURLResponse *response)
     {
         NSLog(@"PUT网络请求成功: %@", object);
         @try
         {
             long statusCode = [[object objectForKey:@"statusCode"]longValue];
             if (statusCode == 200)
             {
                 long result = [[object objectForKey:@"result"]longValue];
                 NSLog(@"获取服务器数据成功: %ld", result);
             }
             else
             {
                 NSString *message = [object objectForKey:@"message"];
                 NSLog(@"获取服务器数据失败: %@; statusCode: %ld", message, statusCode);
             }
         } @catch (NSException *exception)
         {
             NSLog(@"异常: %@", exception.description);
         }
     }
     failBlock:^(NSError *error)
     {
         NSLog(@"PUT网络请求失败: %@", error.localizedDescription);
     } timeout:kTimeOut httpMethod:RequestHTTPMethod_PUT];
}

- (IBAction)NSURLSession_UPLOAD:(id)sender
{
    //判断是否有网络
    if(![[GZNetworkTool sharedNetworkTool] connectedToNetwork])
    {
        [self toastMessage:@"当前网络不可用，请保证网络畅通。" delay:2];
        return;
    }
    
    //上传医生头像图片
    NSString *url = [NSString stringWithFormat:@"%@/yjyb/doctor/info/%d/uploadimage",kServerIP_yjyb, KDoctorId];
    NSString *imageName = [NSString stringWithFormat:@"%@_ID%d.jpg",@"doctorImage",KDoctorId];
    UIImage *image = [UIImage imageNamed:@"bg_002.jpg"];
    
    //发送PUT请求
    [[GZNetworkTool sharedNetworkTool] requestUploadPhoto2:url paramaters:nil image:image imageName:imageName successBlock:^(id object, NSURLResponse *response)
     {
         NSLog(@"UPLOAD网络请求成功: %@", object);
         @try
         {
             long statusCode = [[object objectForKey:@"statusCode"]longValue];
             if (statusCode == 200)
             {
                 NSString *result = [object objectForKey:@"result"];
                 NSLog(@"获取服务器数据成功: %@", result);
             }
             else
             {
                 NSString *message = [object objectForKey:@"message"];
                 NSLog(@"获取服务器数据失败: %@; statusCode: %ld", message, statusCode);
             }
         } @catch (NSException *exception)
         {
             NSLog(@"异常: %@", exception.description);
         }
     }
     failBlock:^(NSError *error)
     {
         NSLog(@"UPLOAD网络请求失败: %@", error.localizedDescription);
     } timeout:kTimeOut];
}

- (IBAction)NSURLSession_UPLOAD2:(id)sender
{
    //判断是否有网络
    if(![[GZNetworkTool sharedNetworkTool] connectedToNetwork])
    {
        [self toastMessage:@"当前网络不可用，请保证网络畅通。" delay:2];
        return;
    }
    
    //发送聊天消息图片
    NSString *url = [NSString stringWithFormat:@"%@%@",kServerIP_yjyb, @"/yjyb/online/chat/send/pictureandvoice"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    NSString *imageName = [NSString stringWithFormat:@"%@_ID%d.jpg",@"MessageImage",11111001];
    UIImage *image = [UIImage imageNamed:@"bg_002.jpg"];
    
    //消息发送方id,居民手机app为登录居民的person_id,医生手机app为登录医生的doctor_id
    //[params setValue:[NSNumber numberWithLong:11111002] forKey:@"0_client_id"];
    [params setValue:[NSNumber numberWithLong:KDoctorId] forKey:@"0_client_id"];
    //消息发送方类型，1.居民；2.医生；4.医生组
    [params setValue:@"1" forKey:@"1_client_type"];
    //消息接收方id，居民为person_id,医生为doctor_id,家庭为family_id,医生组为doctor_group_id
    [params setValue:[NSNumber numberWithLong:11111001] forKey:@"2_revive_id"];
    //消息接收方类型，1.居民；2.医生；3.家庭；4.医生组
    [params setValue:@"2" forKey:@"3_revive_type"];
    //要发送的聊天内容
    //[params setValue:@"" forKey:@"content"];
    //发送图片
    [params setValue:@"101" forKey:@"4_send_type"];
    
    //群接收的居民ID
    [params setValue:[NSNumber numberWithLong:11111002] forKey:@"5_revive_copy_id"];
    //群接收的居民类型
    [params setValue:@"1" forKey:@"6_revive_copy_type"];
    
    //发送PUT请求
    [[GZNetworkTool sharedNetworkTool] requestUploadPhoto2:url paramaters:params image:image imageName:imageName successBlock:^(id object, NSURLResponse *response)
     {
         NSLog(@"UPLOAD网络请求成功: %@", object);
         @try
         {
             long statusCode = [[object objectForKey:@"statusCode"]longValue];
             if (statusCode == 200)
             {
                 long messageId = [[object objectForKey:@"result"]longValue];
                 NSLog(@"获取服务器数据成功: %ld", messageId);
             }
             else
             {
                 NSString *message = [object objectForKey:@"message"];
                 NSLog(@"获取服务器数据失败: %@; statusCode: %ld", message, statusCode);
             }
         } @catch (NSException *exception)
         {
             NSLog(@"异常: %@", exception.description);
         }
     }
                                                 failBlock:^(NSError *error)
     {
         NSLog(@"UPLOAD网络请求失败: %@", error.localizedDescription);
     } timeout:kTimeOut];
}


#pragma mark - NSURLConnection

- (IBAction)NSURLConnection_GET:(id)sender
{
    //判断是否有网络
    if(![[GZNetworkTool sharedNetworkTool] connectedToNetwork])
    {
        [self toastMessage:@"当前网络不可用，请保证网络畅通。" delay:2];
        return;
    }
    
    //获取已签约居民列表
    NSString *url = [NSString stringWithFormat:@"%@%@", kServerIP_yjyb, @"/yjyb/sign/person/list"];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:[NSNumber numberWithLong:kDoctorGroupId] forKey:@"doctor_group_id"];
    
    //发送GET请求
    [[GZNetworkTool sharedNetworkTool] httpRequestWithUrl:url paramaters:params successBlock:^(id object, NSURLResponse *response)
     {
         NSLog(@"GET网络请求成功: %@", object);
         @try
         {
             long statusCode = [[object objectForKey:@"statusCode"]longValue];
             if (statusCode == 200)
             {
                 NSArray *result = [object objectForKey:@"result"];
                 NSLog(@"获取服务器数据成功: %@", result);
             }
             else
             {
                 NSString *message = [object objectForKey:@"message"];
                 NSLog(@"获取服务器数据失败: %@; statusCode: %ld", message, statusCode);
             }
         } @catch (NSException *exception)
         {
             NSLog(@"异常: %@", exception.description);
         }
     }
     failBlock:^(NSError *error)
     {
         NSLog(@"GET网络请求失败: %@", error.localizedDescription);
     } timeout:kTimeOut httpMethod:RequestHTTPMethod_GET];
}

- (IBAction)NSURLConnection_POST:(id)sender
{
    //判断是否有网络
    if(![[GZNetworkTool sharedNetworkTool] connectedToNetwork])
    {
        [self toastMessage:@"当前网络不可用，请保证网络畅通。" delay:2];
        return;
    }
    
    //根据医生编号获取医生的基本信息
    NSString *url = [NSString stringWithFormat:@"%@%@",kServerIP_yjyb, @"/yjyb/doctor/info/get"];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:[NSNumber numberWithLong:KDoctorId] forKey:@"doctor_id"];
    
    //发送POST请求
    [[GZNetworkTool sharedNetworkTool] httpRequestWithUrl:url paramaters:params successBlock:^(id object, NSURLResponse *response)
     {
         NSLog(@"POST网络请求成功: %@", object);
         @try
         {
             long statusCode = [[object objectForKey:@"statusCode"]longValue];
             if (statusCode == 200)
             {
                 NSArray *result = [object objectForKey:@"result"];
                 NSLog(@"获取服务器数据成功: %@", result);
             }
             else
             {
                 NSString *message = [object objectForKey:@"message"];
                 NSLog(@"获取服务器数据失败: %@; statusCode: %ld", message, statusCode);
             }
         } @catch (NSException *exception)
         {
             NSLog(@"异常: %@", exception.description);
         }
     }
     failBlock:^(NSError *error)
     {
         NSLog(@"POST网络请求失败: %@", error.localizedDescription);
     } timeout:kTimeOut httpMethod:RequestHTTPMethod_POST];
}

- (IBAction)NSURLConnection_DELETE:(id)sender
{
    //判断是否有网络
    if(![[GZNetworkTool sharedNetworkTool] connectedToNetwork])
    {
        [self toastMessage:@"当前网络不可用，请保证网络畅通。" delay:2];
        return;
    }
    
    //删除签约预约排班时间段
    long sign_schedual_id = 10;
    NSString *url = [NSString stringWithFormat:@"%@%@%ld",kServerIP_yjyb, @"/yjyb/sign/timebucket/deletebucket/",sign_schedual_id];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:[NSNumber numberWithLong:sign_schedual_id] forKey:@"sign_schedual_id"];
    
    //发送DELETE请求
    [[GZNetworkTool sharedNetworkTool] httpRequestWithUrl:url paramaters:params successBlock:^(id object, NSURLResponse *response)
     {
         NSLog(@"DELETE网络请求成功: %@", object);
         @try
         {
             long statusCode = [[object objectForKey:@"statusCode"]longValue];
             if (statusCode == 200)
             {
                 long result = [[object objectForKey:@"result"]longValue];
                 NSLog(@"获取服务器数据成功: %ld", result);
             }
             else
             {
                 NSString *message = [object objectForKey:@"message"];
                 NSLog(@"获取服务器数据失败: %@; statusCode: %ld", message, statusCode);
             }
         } @catch (NSException *exception)
         {
             NSLog(@"异常: %@", exception.description);
         }
     }
     failBlock:^(NSError *error)
     {
         NSLog(@"DELETE网络请求失败: %@", error.localizedDescription);
     } timeout:kTimeOut httpMethod:RequestHTTPMethod_DELETE];
}

- (IBAction)NSURLConnection_PUT:(id)sender
{
    //判断是否有网络
    if(![[GZNetworkTool sharedNetworkTool] connectedToNetwork])
    {
        [self toastMessage:@"当前网络不可用，请保证网络畅通。" delay:2];
        return;
    }
    
    //修改医生信息
    NSString *url = [NSString stringWithFormat:@"%@%@",kServerIP_yjyb, @"/yjyb/doctor/info/update"];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:[NSNumber numberWithLong:KDoctorId] forKey:@"doctor_id"];
    [params setValue:@"15902010888" forKey:@"doc_phone"];
    [params setValue:@"广州天河区软件路15号" forKey:@"doc_address"];
    [params setValue:@"888888@qq.com" forKey:@"doc_email"];
    [params setValue:@"专治各种疑难杂症、风湿骨痛、坐骨神经等" forKey:@"doc_describe"];
    
    //发送PUT请求
    [[GZNetworkTool sharedNetworkTool] httpRequestWithUrl:url paramaters:params successBlock:^(id object, NSURLResponse *response)
     {
         NSLog(@"PUT网络请求成功: %@", object);
         @try
         {
             long statusCode = [[object objectForKey:@"statusCode"]longValue];
             if (statusCode == 200)
             {
                 long result = [[object objectForKey:@"result"]longValue];
                 NSLog(@"获取服务器数据成功: %ld", result);
             }
             else
             {
                 NSString *message = [object objectForKey:@"message"];
                 NSLog(@"获取服务器数据失败: %@; statusCode: %ld", message, statusCode);
             }
         } @catch (NSException *exception)
         {
             NSLog(@"异常: %@", exception.description);
         }
     }
     failBlock:^(NSError *error)
     {
         NSLog(@"PUT网络请求失败: %@", error.localizedDescription);
     } timeout:kTimeOut httpMethod:RequestHTTPMethod_PUT];
}

- (IBAction)NSURLConnection_UPLOAD:(id)sender
{
    //判断是否有网络
    if(![[GZNetworkTool sharedNetworkTool] connectedToNetwork])
    {
        [self toastMessage:@"当前网络不可用，请保证网络畅通。" delay:2];
        return;
    }
    
    [[NetworkBusyView shareInstance] showBusyViewWithPrompt:@"请稍候..." superView:self.view];
    
    //请求网络
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
   {
       // 耗时的操作...
       NSString *url = [NSString stringWithFormat:@"%@/yjyb/doctor/info/%d/uploadimage",kServerIP_yjyb,KDoctorId];
       NSString *imageName = [NSString stringWithFormat:@"%@_ID%d.jpg",@"doctorImage",KDoctorId];
       UIImage *image = [UIImage imageNamed:@"bg_002.jpg"];
       
       //发送请求，并且得到返回的数据
       [[GZNetworkTool sharedNetworkTool] httpUploadPhoto:url paramaters:nil imageName:imageName image:image finishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError)
        {
            //NSString *nsdata = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            //NSLog(@"%@",nsdata);
            
            dispatch_async(dispatch_get_main_queue(), ^
           {
               // 更新界面...
               @try
               {
                   [[NetworkBusyView shareInstance] removeBusyViewFromSuperView:self.view];
                   if (data)//请求成功
                   {
                       NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                       long statusCode = [[dic objectForKey:@"statusCode"]longValue];
                       if (statusCode == 200)
                       {
                           NSString *result = [dic objectForKey:@"result"];
                           NSLog(@"获取服务器数据成功: %@", result);
                       }
                       else
                       {
                           NSString *message = [dic objectForKey:@"message"];
                           NSLog(@"获取服务器数据失败: %@; statusCode: %ld", message, statusCode);
                       }
                   }
                   else
                   {
                       NSLog(@"输出的错误%@",connectionError);
                       [GZPublicMethod showAlertOK:[connectionError localizedDescription] control:self];
                   }
               }
               @catch (NSException *exception)
               {
                   [[NetworkBusyView shareInstance] removeBusyViewFromSuperView:self.view];
                   [GZPublicMethod showAlertOK:exception.description control:self];
               }
           });
        }timeout:kTimeOut];
   });
}

- (IBAction)NSURLConnection_UPLOAD2:(id)sender
{
    //判断是否有网络
    if(![[GZNetworkTool sharedNetworkTool] connectedToNetwork])
    {
        [self toastMessage:@"当前网络不可用，请保证网络畅通。" delay:2];
        return;
    }
    
    [[NetworkBusyView shareInstance] showBusyViewWithPrompt:@"请稍候..." superView:self.view];
    
    //请求网络
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
   {
       // 耗时的操作...
       //发送聊天消息图片
       NSString *url = [NSString stringWithFormat:@"%@%@",kServerIP_yjyb, @"/yjyb/online/chat/send/pictureandvoice"];
       NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
       NSString *imageName = [NSString stringWithFormat:@"%@_ID%d.jpg",@"MessageImage",11111001];
       UIImage *image = [UIImage imageNamed:@"bg_002.jpg"];
       
       //消息发送方id,居民手机app为登录居民的person_id,医生手机app为登录医生的doctor_id
       //[params setValue:[NSNumber numberWithLong:11111002] forKey:@"0_client_id"];
       [params setValue:[NSNumber numberWithLong:KDoctorId] forKey:@"0_client_id"];
       //消息发送方类型，1.居民；2.医生；4.医生组
       [params setValue:@"1" forKey:@"1_client_type"];
       //消息接收方id，居民为person_id,医生为doctor_id,家庭为family_id,医生组为doctor_group_id
       [params setValue:[NSNumber numberWithLong:11111001] forKey:@"2_revive_id"];
       //消息接收方类型，1.居民；2.医生；3.家庭；4.医生组
       [params setValue:@"2" forKey:@"3_revive_type"];
       //要发送的聊天内容
       //[params setValue:@"" forKey:@"content"];
       //发送图片
       [params setValue:@"101" forKey:@"4_send_type"];
       
       //群接收的居民ID
       [params setValue:[NSNumber numberWithLong:11111002] forKey:@"5_revive_copy_id"];
       //群接收的居民类型
       [params setValue:@"1" forKey:@"6_revive_copy_type"];
       
       //发送请求，并且得到返回的数据
       [[GZNetworkTool sharedNetworkTool] httpUploadPhoto:url paramaters:params imageName:imageName image:image finishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError)
        {
            NSString *nsdata = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",nsdata);
            
            dispatch_async(dispatch_get_main_queue(), ^
           {
               // 更新界面...
               @try
               {
                   [[NetworkBusyView shareInstance] removeBusyViewFromSuperView:self.view];
                   if (data)//请求成功
                   {
                       NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                       long statusCode = [[dic objectForKey:@"statusCode"]longValue];
                       if (statusCode == 200)
                       {
                           long messageId = [[dic objectForKey:@"result"]longValue];
                           NSLog(@"获取服务器数据成功: %ld", messageId);
                       }
                       else
                       {
                           NSString *message = [dic objectForKey:@"message"];
                           NSLog(@"获取服务器数据失败: %@; statusCode: %ld", message, statusCode);
                       }
                   }
                   else
                   {
                       NSLog(@"输出的错误%@",connectionError);
                       [GZPublicMethod showAlertOK:[connectionError localizedDescription] control:self];
                   }
               }
               @catch (NSException *exception)
               {
                   [[NetworkBusyView shareInstance] removeBusyViewFromSuperView:self.view];
                   [GZPublicMethod showAlertOK:exception.description control:self];
               }
           });
        }timeout:kTimeOut];
   });
}

//提示消息
- (void)toastMessage:(NSString *)title delay:(CGFloat)delay
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    // Set the annular determinate mode to show task progress.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = title;
    hud.label.font = [UIFont systemFontOfSize:12];
    // Move to bottm center.
    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    
    [hud hideAnimated:YES afterDelay:delay];
}

@end
