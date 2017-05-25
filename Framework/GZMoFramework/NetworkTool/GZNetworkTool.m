//
//  GZNetworkTool.m
//  NSURLSessionDemo
//
//  Created by mojx on 16/9/17.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import "GZNetworkTool.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <netdb.h>

@interface GZNetworkTool ()<NSURLSessionDelegate>

@end

@implementation GZNetworkTool

//创建单例对象
+ (instancetype)sharedNetworkTool
{
    static id _instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

/**
 *  判断网络状态
 *
 *  @return 有网络YES，NO无网络
 */
- (BOOL)connectedToNetwork
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        printf("Error. Could not recover network reachability flags\n");
        return NO;
    }
    
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}

/**
 *  网络请求
 *
 *  @param urlString  请求的url地址
 *  @param paramaters 访问的参数
 *  @param success    成功block
 *  @param fail       失败block
 *  @param timeout    超时时间
 *  @param httpMethod 设置请求方法：GET、POST、PUT、DELETE
 */
- (void)requestWithUrl:(NSString *)urlString
            paramaters:(NSMutableDictionary *)paramaters
          successBlock:(successBlock)success
             failBlock:(failBlock)fail
               timeout:(NSInteger)timeout
            httpMethod:(enum RequestHTTPMethod)httpMethod
{
    // 1. 创建请求.
    // 参数拼接.遍历参数字典,一一取出参数
    NSMutableString *strM = [[NSMutableString alloc] init];
    [paramaters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop)
     {
         // 服务器接收参数的 key 值.
         NSString *paramaterKey = key;
         // 参数内容
         NSString *paramaterValue = obj;
         // appendFormat :可变字符串直接拼接的方法!
         [strM appendFormat:@"%@=%@&",paramaterKey,paramaterValue];
     }];

    NSURL *url = [NSURL URLWithString:urlString];
    if (httpMethod == RequestHTTPMethod_GET)
    {
        urlString = [NSString stringWithFormat:@"%@?%@",urlString,strM];
        // 截取字符串的方法!
        urlString = [urlString substringToIndex:urlString.length - 1];
        //NSLog(@"urlString:%@",urlString);
        url = [NSURL URLWithString:urlString];
    }
    //设置网络请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:timeout];
    
    if (httpMethod == RequestHTTPMethod_GET)
    {
        request.HTTPMethod = @"GET";
    }
    else if (httpMethod == RequestHTTPMethod_POST || httpMethod == RequestHTTPMethod_PUT || httpMethod == RequestHTTPMethod_DELETE)
    {
        // 1.1设置请求方法
        if (httpMethod == RequestHTTPMethod_POST)
            request.HTTPMethod = @"POST";
        else if (httpMethod == RequestHTTPMethod_PUT)
            request.HTTPMethod = @"PUT";
        else if (httpMethod == RequestHTTPMethod_DELETE)
            request.HTTPMethod = @"DELETE";
        
        // 1.2.设置请求体
        NSString *body = [strM substringToIndex:strM.length - 1];
        //NSLog(@"%@",body);
        NSData *bodyData = [body dataUsingEncoding:NSUTF8StringEncoding];
        request.HTTPBody = bodyData;
    }

    // 2. 发送网络请求.
    // completionHandler: 说明网络请求完成!
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
      {
          //NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
          if (data && !error)// 网络请求成功
          {
              // 查看 data 是否是 JSON 数据.
              // JSON 解析.
              /*
               1、NSJSONReadingMutableContainers：返回可变容器，NSMutableDictionary或NSMutableArray。
               2、NSJSONReadingMutableLeaves：返回的JSON对象中字符串的值为NSMutableString.
               3、NSJSONReadingAllowFragments：允许JSON字符串最外层既不是NSArray也不是NSDictionary，但必须是有效的JSON Fragment。例如使用这个选项可以解析 @“123” 这样的字符串。
               4、NSJSONWritingPrettyPrinted：的意思是将生成的json数据格式化输出，这样可读性高，不设置（0）则输出的json字符串就是一整行。
               */
              id obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
              //id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
              
              // 如果 obj 能够解析, 说明就是 JSON, 否则返回nsdata数据
              if (!obj)
                  obj = data;
              
              // 成功回调
              dispatch_async(dispatch_get_main_queue(), ^{
                  if (success)
                      success(obj, response);
              });
          }else // 网络请求失败
          {
              // 失败回调
              if (fail)
                  fail(error);
          }
      }] resume];
}

/**
 *  上传图片网络请求
 *
 *  @param urlString  请求的url地址
 *  @param image      上传的图片
 *  @param success    成功block
 *  @param fail       失败block
 *  @param timeout    超时时间
 */
- (void)requestUploadPhoto:(NSString *)urlString
                     image:(UIImage *)image
              successBlock:(successBlock)success
                 failBlock:(failBlock)fail
                   timeout:(NSInteger)timeout
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request addValue:@"image/jpeg" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"text/html" forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:@"POST"];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [request setTimeoutInterval:timeout];
    
    NSData *imagedata = UIImageJPEGRepresentation(image, 1.0);
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionUploadTask *uploadtask = [session uploadTaskWithRequest:request fromData:imagedata completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
      {
          if (data && !error)// 网络请求成功
          {
              // 查看 data 是否是 JSON 数据.
              // JSON 解析.
              id obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
              //id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
              
              // 如果 obj 能够解析, 说明就是 JSON, 否则返回nsdata数据
              if (!obj)
                  obj = data;
              
              // 成功回调
              dispatch_async(dispatch_get_main_queue(), ^{
                  if (success)
                      success(obj, response);
              });
          }else // 网络请求失败
          {
              // 失败回调
              if (fail)
                  fail(error);
          }
      }];
    [uploadtask resume];
}

/**
 *  上传图片网络请求
 *
 *  @param urlString  请求的url地址
 *  @param params     请求的参数
 *  @param image      上传的图片
 *  @param imageName  图片名称
 *  @param success    成功block
 *  @param fail       失败block
 *  @param timeout    超时时间
 */
- (void)requestUploadPhoto2:(NSString *)urlString
                 paramaters:(NSMutableDictionary *)params
                      image:(UIImage *)image
                  imageName:(NSString*)imageName
               successBlock:(successBlock)success
                  failBlock:(failBlock)fail
                    timeout:(NSInteger)timeout
{
    //把传进来的urlString字符串转变为URL地址
    NSURL *url = [NSURL URLWithString:urlString];
    //解析请求参数
    if (params && params.count > 0)
    {
        //解析请求参数，用NSDictionary来存参数，通过自定义的函数parseParams把它解析成一个post格式的字符串
        NSString *parseParamsResult = [self parseParams2:params];
        //NSData *paramsData = [parseParamsResult dataUsingEncoding:NSUTF8StringEncoding];
        //把传进来的URL字符串转变为URL地址
        NSString *strURL = [NSString stringWithFormat:@"%@/%@",urlString,parseParamsResult];
        strURL = [strURL substringToIndex:strURL.length - 1];
        url = [NSURL URLWithString:strURL];
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //[request addValue:@"image/jpeg" forHTTPHeaderField:@"Content-Type"];
    //[request addValue:@"text/html" forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:@"POST"];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [request setTimeoutInterval:timeout];
    
    NSData *imagedata = UIImageJPEGRepresentation(image, 1.0);
    
    //分界线 --AaB03x
    NSString *boundary = [NSString stringWithFormat:@"Boundary+%08X%08X", arc4random(), arc4random()];
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",boundary];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    
    //http body的字符串
    NSMutableString *body=[[NSMutableString alloc]init];
    
    ////添加分界线，换行
    [body appendFormat:@"%@\r\n",MPboundary];
    
    //声明pic字段，文件名为boris.png
    //[body appendFormat:@"Content-Disposition: form-data; name=\"photo\"; filename=\"icon.jpeg\"\r\n"];
    [body appendString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"uploadFile\"; filename=\"%@\"\r\n",imageName]];
    //声明上传文件的格式
    [body appendFormat:@"Content-Type: image/jpeg\r\n\r\n"];
    
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[NSMutableData data];
    
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [myRequestData appendData:imagedata];
    
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",boundary];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    //NSURLSessionUploadTask *uploadtask = [session uploadTaskWithRequest:request fromData:imagedata completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    NSURLSessionDataTask *uploadtask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
      {
          if (data && !error)// 网络请求成功
          {
              // 查看 data 是否是 JSON 数据.
              // JSON 解析.
              id obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
              //id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
              
              // 如果 obj 能够解析, 说明就是 JSON, 否则返回nsdata数据
              if (!obj)
                  obj = data;
              
              // 成功回调
              dispatch_async(dispatch_get_main_queue(), ^{
                  if (success)
                      success(obj, response);
              });
          }else // 网络请求失败
          {
              // 失败回调
              if (fail)
                  fail(error);
          }
      }];
    [uploadtask resume];
}

/**
 *  网络请求
 *
 *  @param urlString  请求的url地址
 *  @param paramaters 访问的参数
 *  @param success    成功block
 *  @param fail       失败block
 *  @param timeout    超时时间
 *  @param httpMethod 设置请求方法：GET、POST、PUT、DELETE
 */
- (void)httpRequestWithUrl:(NSString *)urlString
            paramaters:(NSMutableDictionary *)paramaters
          successBlock:(successBlock)success
             failBlock:(failBlock)fail
               timeout:(NSInteger)timeout
            httpMethod:(enum RequestHTTPMethod)httpMethod
{
    // 1. 创建请求.
    // 参数拼接.遍历参数字典,一一取出参数
    NSMutableString *strM = [[NSMutableString alloc] init];
    [paramaters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop)
     {
         // 服务器接收参数的 key 值.
         NSString *paramaterKey = key;
         // 参数内容
         NSString *paramaterValue = obj;
         // appendFormat :可变字符串直接拼接的方法!
         [strM appendFormat:@"%@=%@&",paramaterKey,paramaterValue];
     }];
    
    NSURL *url = [NSURL URLWithString:urlString];
    if (httpMethod == RequestHTTPMethod_GET)
    {
        urlString = [NSString stringWithFormat:@"%@?%@",urlString,strM];
        // 截取字符串的方法!
        urlString = [urlString substringToIndex:urlString.length - 1];
        //NSLog(@"urlString:%@",urlString);
        url = [NSURL URLWithString:urlString];
    }
    //设置网络请求
    //NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:timeout];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:timeout];
    
    if (httpMethod == RequestHTTPMethod_GET)
    {
        request.HTTPMethod = @"GET";
    }
    else if (httpMethod == RequestHTTPMethod_POST || httpMethod == RequestHTTPMethod_PUT || httpMethod == RequestHTTPMethod_DELETE)
    {
        // 1.1设置请求方法
        if (httpMethod == RequestHTTPMethod_POST)
            request.HTTPMethod = @"POST";
        else if (httpMethod == RequestHTTPMethod_PUT)
            request.HTTPMethod = @"PUT";
        else if (httpMethod == RequestHTTPMethod_DELETE)
            request.HTTPMethod = @"DELETE";
        
        // 1.2.设置请求体
        NSString *body = [strM substringToIndex:strM.length - 1];
        //NSLog(@"%@",body);
        NSData *bodyData = [body dataUsingEncoding:NSUTF8StringEncoding];
        request.HTTPBody = bodyData;
        //[request setHTTPShouldHandleCookies:YES];
    }

    //创建一个新的队列（开启新线程）
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    //发送异步请求，请求完以后返回的数据，通过completionHandler参数来调用
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         //NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
         if (data && !connectionError)// 网络请求成功
         {
             // 查看 data 是否是 JSON 数据.
             // JSON 解析.
             id obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
             //id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
             
             // 如果 obj 能够解析, 说明就是 JSON, 否则返回nsdata数据
             if (!obj)
                 obj = data;
             
             // 成功回调
             dispatch_async(dispatch_get_main_queue(), ^{
                 if (success)
                     success(obj, response);
             });
         }else // 网络请求失败
         {
             // 失败回调
             if (fail)
                 fail(connectionError);
         }
     }];
}

/**
 *  http上传照片
 *
 *  @param urlString 请求的url地址
 *  @param params    请求的参数
 *  @param imageName 图片名称
 *  @param image     图片
 *  @param block     处理结果block
 *  @param timeout   超时时间
 */
- (void)httpUploadPhoto:(NSString *)urlString
             paramaters:(NSMutableDictionary *)params
              imageName:(NSString*)imageName
                  image:(UIImage *)image
            finishBlock:(void (^)(NSURLResponse *response, NSData *data, NSError *connectionError))block
                timeout:(NSInteger)timeout
{
    //把传进来的urlString字符串转变为URL地址
    NSURL *url = [NSURL URLWithString:urlString];
    //解析请求参数
    if (params && params.count > 0)
    {
        //解析请求参数，用NSDictionary来存参数，通过自定义的函数parseParams把它解析成一个post格式的字符串
        NSString *parseParamsResult = [self parseParams2:params];
        //NSData *paramsData = [parseParamsResult dataUsingEncoding:NSUTF8StringEncoding];
        //把传进来的URL字符串转变为URL地址
        NSString *strURL = [NSString stringWithFormat:@"%@/%@",urlString,parseParamsResult];
        strURL = [strURL substringToIndex:strURL.length - 1];
        url = [NSURL URLWithString:strURL];
    }

    //请求初始化，可以在这针对缓存，超时做出一些设置
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:timeout];
    
    NSString *boundary = [NSString stringWithFormat:@"Boundary+%08X%08X", arc4random(), arc4random()];
    NSMutableData *body = [NSMutableData data];

    // 图片数据部分
    NSMutableString *topStr = [NSMutableString string];
    //NSString *path = [[NSBundle mainBundle] pathForResource:ImgFile ofType:nil];
    //NSData *data = [NSData dataWithContentsOfFile:path];
    
    /**拼装成格式：
     --Boundary+72D4CD655314C423
     Content-Disposition: form-data; name="uploadFile"; filename="001.png"
     Content-Type:image/png
     Content-Transfer-Encoding: binary
     
     ... contents of boris.png ...
     */
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    //NSData *imageData = UIImagePNGRepresentation(image);
    
    [topStr appendString:[NSString stringWithFormat:@"--%@\r\n", boundary]];
    //[topStr appendString:@"Content-Disposition: form-data; name=\"uploadFile\"; filename=\"doctor_01.jpg\"\r\n"];
    [topStr appendString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"uploadFile\"; filename=\"%@\"\r\n",imageName]];
    //[topStr appendString:[NSString stringWithFormat:@"Content-Type:image/%@\r\n",ImgFileExtend]];
    [topStr appendString:[NSString stringWithFormat:@"Content-Type:image/jpeg\r\n"]];
    [topStr appendString:@"Content-Transfer-Encoding: binary\r\n\r\n"];
    [body appendData:[topStr dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:imageData];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    // 结束部分
    NSString *bottomStr = [NSString stringWithFormat:@"--%@--", boundary];
    /**拼装成格式：
     --Boundary+72D4CD655314C423--
     */
    [body appendData:[bottomStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    // 设置请求类型为post请求
    request.HTTPMethod = @"post";
    // 设置request的请求体
    request.HTTPBody = body;
    // 设置头部数据，标明上传数据总大小，用于服务器接收校验
    [request setValue:[NSString stringWithFormat:@"%ld", (long)body.length] forHTTPHeaderField:@"Content-Length"];
    // 设置头部数据，指定了http post请求的编码方式为multipart/form-data（上传文件必须用这个）。
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary] forHTTPHeaderField:@"Content-Type"];
    
    //创建一个新的队列（开启新线程）
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    //发送异步请求，请求完以后返回的数据，通过completionHandler参数来调用
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:block];
}

/**
 *  https网络请求，注意请求的参数为json
 *
 *  @param urlString  请求的url地址
 *  @param paramaters 访问的参数
 *  @param success    成功block
 *  @param fail       失败block
 *  @param timeout    超时时间
 */
- (void)httpsPostRequestWithUrl:(NSString *)urlString
                     paramaters:(NSMutableDictionary *)paramaters
                   successBlock:(successBlock)success
                      failBlock:(failBlock)fail
                        timeout:(NSInteger)timeout
{
    //创建会话对象,并设置代理
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    //创建可变的请求对象
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:timeout];
    //设置请求方法为POST
    request.HTTPMethod = @"POST";
    //设置参数格式为json
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //设置请求体：传参封装成json格式
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:paramaters options:0 error:nil];
    request.HTTPBody = jsondata;
    
    //根据会话对象创建一个Task(发送请求）
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
      {
          //解析数据
          //NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
          if (data && !error)// 网络请求成功
          {
              // JSON 解析.
              id obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
              //id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
              
              // 如果 obj 能够解析, 说明就是 JSON, 否则返回nsdata数据
              if (!obj)
                  obj = data;
              
              // 成功回调
              dispatch_async(dispatch_get_main_queue(), ^{
                  if (success)
                      success(obj, response);
              });
          }else // 网络请求失败
          {
              // 失败回调
              if (fail)
                  fail(error);
          }
      }];
    
    //执行任务
    [dataTask resume];
}

/**
 *  网络请求
 *
 *  @param urlString  请求的url地址
 *  @param paramaters 访问的参数
 *  @param success    成功block
 *  @param fail       失败block
 *  @param timeout    超时时间
 */
- (void)httpsGetRequestWithUrl:(NSString *)urlString
                    paramaters:(NSMutableDictionary *)paramaters
                  successBlock:(successBlock)success
                     failBlock:(failBlock)fail
                       timeout:(NSInteger)timeout
{
    //创建会话对象,并设置代理
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    //参数拼接.遍历参数字典,一一取出参数
    NSMutableString *strM = [[NSMutableString alloc] init];
    [paramaters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop)
     {
         // 服务器接收参数的 key 值.
         NSString *paramaterKey = key;
         // 参数内容
         NSString *paramaterValue = obj;
         // appendFormat :可变字符串直接拼接的方法!
         [strM appendFormat:@"%@=%@&",paramaterKey,paramaterValue];
     }];
    
    NSURL *url = [NSURL URLWithString:urlString];
    urlString = [NSString stringWithFormat:@"%@?%@",urlString,strM];
    // 截取字符串的方法!
    urlString = [urlString substringToIndex:urlString.length - 1];
    //NSLog(@"urlString:%@",urlString);
    url = [NSURL URLWithString:urlString];
    
    //创建可变的请求对象
    //NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:timeout];
    //4.设置请求方法为POST
    request.HTTPMethod = @"GET";
    
    //根据会话对象创建一个Task(发送请求）
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
      {
          //解析数据
          //NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
          if (data && !error)// 网络请求成功
          {
              // 查看 data 是否是 JSON 数据.
              // JSON 解析.
              id obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
              //id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
              
              // 如果 obj 能够解析, 说明就是 JSON, 否则返回nsdata数据
              if (!obj)
                  obj = data;
              
              // 成功回调
              dispatch_async(dispatch_get_main_queue(), ^{
                  if (success)
                      success(obj, response);
              });
          }else // 网络请求失败
          {
              // 失败回调
              if (fail)
                  fail(error);
          }
      }];
    
    //执行任务
    [dataTask resume];
}

/**
 HTTP各种状态码的含义
 
 @param statusCode HTTP状态码
 @return 返回对应状态码的含义
 */
- (NSString *)httpErrorReason:(NSInteger)statusCode
{
    //HTTP各种状态码的意义（HTTP Status Code）http://xieke90.iteye.com/blog/2259955
    
    NSString *reason = @"未知原因";
    switch (statusCode)
    {
            //消息（1字头）服务器收到请求，需要请求者继续执行操作
        case 100:
            reason = @"（继续）请求者应当继续提出请求。 服务器返回此代码表示已收到请求的第一部分，正在等待其余部分。";
            break;
        case 101:
            reason = @"（切换协议）请求者已要求服务器切换协议，服务器已确认并准备切换。";
            break;
            
            //成功（2字头）操作被成功接收并处理
        case 200:
            reason = @"（成功）服务器已成功处理了请求。";
            break;
        case 201:
            reason = @"（已创建）请求成功并且服务器创建了新的资源。";
            break;
        case 202:
            reason = @"（已接受）服务器已接受请求，但尚未处理。";
            break;
        case 203:
            reason = @"（非授权信息）服务器已成功处理了请求，但返回的信息可能来自另一来源。";
            break;
        case 204:
            reason = @"（无内容）服务器成功处理了请求，但没有返回任何内容。";
            break;
        case 205:
            reason = @"（重置内容）服务器成功处理了请求，但没有返回任何内容。";
            break;
        case 206:
            reason = @"（部分内容）服务器成功处理了部分GET请求。";
            break;
            
            //重定向（3字头）需要进一步的操作以完成请求
        case 300:
            reason = @"（多种选择）针对请求，服务器可执行多种操作。";
            break;
        case 301:
            reason = @"（永久移动）请求的网页已永久移动到新位置。";
            break;
        case 302:
            reason = @"（临时移动）服务器目前从不同位置的网页响应请求，但请求者应继续使用原有位置来进行以后的请求。";
            break;
        case 303:
            reason = @"（查看其他位置）请求者应当对不同的位置使用单独的 GET 请求来检索响应时，服务器返回此代码。";
            break;
        case 304:
            reason = @"（未修改）自从上次请求后，请求的网页未修改过。";
            break;
        case 305:
            reason = @"（使用代理）请求者只能使用代理访问请求的网页。";
            break;
        case 307:
            reason = @"（临时重定向）服务器目前从不同位置的网页响应请求，但请求者应继续使用原有位置来进行以后的请求。";
            break;
            
            //请求错误（4字头）客户端错误，请求包含语法错误或无法完成请求
        case 400:
            reason = @"（错误请求）服务器不理解请求的语法。";
            break;
        case 401:
            reason = @"（未授权）请求要求身份验证。";
            break;
        case 403:
            reason = @"（禁止）服务器拒绝请求。";
            break;
        case 404:
            reason = @"（未找到）服务器找不到请求的网页。";
            break;
        case 405:
            reason = @"（方法禁用）禁用请求中指定的方法。";
            break;
        case 406:
            reason = @"（不接受）无法使用请求的内容特性响应请求的网页。";
            break;
        case 407:
            reason = @"（需要代理授权）此状态代码与 401（未授权）类似，但指定请求者应当授权使用代理。";
            break;
        case 408:
            reason = @"（请求超时）服务器等候请求时发生超时。";
            break;
        case 409:
            reason = @"（冲突）服务器在完成请求时发生冲突。服务器必须在响应中包含有关冲突的信息。";
            break;
        case 410:
            reason = @"（已删除）如果请求的资源已永久删除，服务器就会返回此响应。";
            break;
        case 411:
            reason = @"（需要有效长度）服务器不接受不含有效内容长度标头字段的请求。";
            break;
        case 412:
            reason = @"（未满足前提条件）服务器未满足请求者在请求中设置的其中一个前提条件。";
            break;
        case 413:
            reason = @"（请求实体过大）服务器无法处理请求，因为请求实体过大，超出服务器的处理能力。";
            break;
        case 414:
            reason = @"（请求的 URI 过长）请求的URI（通常为网址）过长，服务器无法处理。";
            break;
        case 415:
            reason = @"（不支持的媒体类型）请求的格式不受请求页面的支持。";
            break;
        case 416:
            reason = @"（请求范围不符合要求）如果页面无法提供请求的范围，则服务器会返回此状态代码。";
            break;
        case 417:
            reason = @"（未满足期望值）服务器未满足”期望”请求标头字段的要求。";
            break;
            
            //服务器错误（5字头）服务器在处理请求的过程中发生了错误
        case 500:
            reason = @"（服务器内部错误）服务器遇到错误，无法完成请求。";
            break;
        case 501:
            reason = @"（尚未实施）服务器不具备完成请求的功能。";
            break;
        case 502:
            reason = @"（错误网关）服务器作为网关或代理，从上游服务器收到无效响应。";
            break;
        case 503:
            reason = @"（服务不可用）服务器目前无法使用（由于超载或停机维护）。";
            break;
        case 504:
            reason = @"（网关超时）服务器作为网关或代理，但是没有及时从上游服务器收到请求。";
            break;
        case 505:
            reason = @"（HTTP 版本不受支持）服务器不支持请求中所用的 HTTP 协议版本。";
            break;
        default:
            break;
    }
    return reason;
}

/**
 HTTP状态码含义
 
 @param response url请求的响应
 @return 返回响应状态码的含义
 */
- (NSString *)httpErrorReasonWithURLResponse:(NSURLResponse *)response
{
    //将NSURLResponse对象转换成NSHTTPURLResponse对象
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
    //取得所有的请求的头
    //NSDictionary *dictionary = [httpResponse allHeaderFields];
    //打印所有请求头及http状态码
    //NSLog(@"%@; %ld", [dictionary description], httpResponse.statusCode);
    
    NSString *reason = [NSString stringWithFormat:@"状态码: %ld。%@", httpResponse.statusCode, [self httpErrorReason:httpResponse.statusCode]];
    
    return reason;
}

#pragma mark - NSURLSessionDataDelegate
/**
 只要请求的地址是HTTPS的, 就会调用这个代理方法
 */
- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler
{
    NSLog(@"%@",challenge.protectionSpace);
    
    if (![challenge.protectionSpace.authenticationMethod isEqualToString:@"NSURLAuthenticationMethodServerTrust"]) return;
    
    /*
     NSURLSessionAuthChallengeUseCredential 使用证书
     NSURLSessionAuthChallengePerformDefaultHandling  忽略证书 默认的做法
     NSURLSessionAuthChallengeCancelAuthenticationChallenge 取消请求,忽略证书
     NSURLSessionAuthChallengeRejectProtectionSpace 拒绝,忽略证书
     */
    
    NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
    completionHandler(NSURLSessionAuthChallengeUseCredential,credential);
}

//把NSDictionary解析成post格式的NSString字符串
- (NSString *)parseParams:(NSMutableDictionary *)params
{
    NSString *keyValueFormat;
    NSMutableString *result = [[NSMutableString alloc]init];
    //实例化一个key枚举器用来存放dictionary的key
    NSEnumerator *keyEnum = [params keyEnumerator];
    id key;
    while (key = [keyEnum nextObject])
    {
        keyValueFormat = [NSString stringWithFormat:@"%@=%@&",key,[params valueForKey:key]];
        //keyValueFormat = [NSString stringWithFormat:@"%@/%@/",key,[params valueForKey:key]];
        [result appendString:keyValueFormat];
        //NSLog(@"post()方法参数解析结果：%@",result);
    }
    return result;
}

- (NSString *)parseParams2:(NSMutableDictionary *)params
{
    NSString *keyValueFormat;
    NSMutableString *result = [[NSMutableString alloc]init];
    
    //获取keys并对keys进行排序
    NSMutableArray *keysArray = [NSMutableArray arrayWithArray:params.allKeys];
    [keysArray sortUsingComparator: ^NSComparisonResult (NSString *str1, NSString *str2) {
        return [str1 compare:str2];
    }];
    
    for (NSString *key in keysArray)
    {
        keyValueFormat = [key substringFromIndex:2];
        keyValueFormat = [NSString stringWithFormat:@"%@/%@/",keyValueFormat,[params objectForKey:key]];
        [result appendString:keyValueFormat];
    }
    
    return result;
}

@end
