//
//  GZNetworkTool.h
//  NSURLSessionDemo
//
//  Created by mojx on 16/9/17.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**网络访问时请求的枚举方法*/
enum RequestHTTPMethod
{
    /**GET请求方法*/
    RequestHTTPMethod_GET = 0,
    /**POST请求方法*/
    RequestHTTPMethod_POST = 1,
    /**PUT请求方法*/
    RequestHTTPMethod_PUT = 2,
    /**DELETE请求方法*/
    RequestHTTPMethod_DELETE = 3,
};


@interface GZNetworkTool : NSObject

//创建单例对象
+ (instancetype)sharedNetworkTool;

/**
 *  成功后回调的block
 *
 *  @param object   如果是JSON, 那么直接解析成OC中的数组或者字典. 如果不是JSON, 直接返回NSData
 *  @param response 响应头信息, 主要是对服务器端的描述
 */
typedef void(^successBlock)(id object, NSURLResponse *response);

/**
 *  失败后回调的block
 *
 *  @param error 错误信息，如果请求失败，则error有值
 */
typedef void(^failBlock)(NSError *error);


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
            httpMethod:(enum RequestHTTPMethod)httpMethod;

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
                   timeout:(NSInteger)timeout;

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
                    timeout:(NSInteger)timeout;

/**
 *  判断网络状态
 *
 *  @return 有网络YES，NO无网络
 */
- (BOOL)connectedToNetwork;

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
                httpMethod:(enum RequestHTTPMethod)httpMethod;

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
                timeout:(NSInteger)timeout;

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
                        timeout:(NSInteger)timeout;

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
                       timeout:(NSInteger)timeout;

/**
 HTTP各种状态码的含义
 
 @param statusCode HTTP状态码
 @return 返回对应状态码的含义
 */
- (NSString *)httpErrorReason:(NSInteger)statusCode;

/**
 HTTP状态码含义
 
 @param response url请求的响应
 @return 返回响应状态码的含义
 */
- (NSString *)httpErrorReasonWithURLResponse:(NSURLResponse *)response;

@end
