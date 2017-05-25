//
//  MySecurity.h
//  CustomControls
//
//  Created by mojx on 16/9/16.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MySecurity : NSObject

/**
 *  MD5字符串加密
 *
 *  @param sourceString 加密字符串
 *  @param length       加密长度：16、32
 *  @param isLowerCase  是否小写
 *
 *  @return 加密后的结果
 */
+ (NSString *)md5String:(NSString *)sourceString encryptionLength:(NSInteger)length isLowerCase:(BOOL)isLowerCase;

/**
 *  md5 data加密
 *
 *  @param sourceData 需要加密的数据
 *
 *  @return 加密后的数据
 */
+ (NSString *)md5Data:(NSData *)sourceData;

/**
 *  base64编码（生成base64编码的字符串）
 *
 *  @param sourceData 数据源
 *
 *  @return base64编码字符串
 */
+ (NSString *)base64EncodingWithData:(NSData *)sourceData;

/**
 *  base64反编码（生成base64反编码的数据）
 *
 *  @param sourceString 数据源
 *
 *  @return base64反编码数据
 */
+ (id)base64EncodingWithString:(NSString *)sourceString;

/**
 *  转化为Base64
 *
 *  @param text 数据
 *
 *  @return base64编码字符串
 */
+ (NSString *)base64StringFromText:(NSString *)text;

/**
 *  base64反编码
 *
 *  @param base64 base64编码字符串
 *
 *  @return base64反编码数据
 */
+ (NSString *)textFromBase64String:(NSString *)base64;

/**
 *  base64编码字符串转换为NSData数据
 *
 *  @param string base64编码字符串
 *
 *  @return base64反编码数据
 */
+ (NSData *)dataWithBase64EncodedString:(NSString *)string;

/**
 *  NSData数据转base64编码字符串
 *
 *  @param data NSData数据
 *
 *  @return base64编码字符串
 */
+ (NSString *)base64EncodedStringFrom:(NSData *)data;

/**
 *  DES加密
 *
 *  @param sText 需要加密的数据
 *  @param key   加密key
 *  @param ivDes 密钥向量
 *
 *  @return DES加密后的数据
 */
+ (NSString *)encryptWithDESSting:(NSString *)sText key:(NSString *)key andDesiv:(NSString *)ivDes;

/**
 *  DES解密
 *
 *  @param sText 需要解密的数据
 *  @param key   加密key
 *  @param iv    密钥向量
 *
 *  @return DES解密后的数据
 */
+ (NSString *)decryptWithDESString:(NSString *)sText key:(NSString *)key andiV:(NSString *)iv;

/**
 *  3des加解密
 *
 *  @param plainText        加解密的明文
 *  @param encryptOrDecrypt 加密或解密：加密0，解密1
 *  @param key              加解密的key
 *
 *  @return 加解密后的数据
 */
+ (NSString *)tripleDES:(NSString*)plainText encryptOrDecrypt:(int)encryptOrDecrypt key:(NSString *)key;

/**
 *  AES128加密
 *
 *  @param key  加密的key
 *  @param iv   密钥向量
 *  @param data 加密的数据
 *
 *  @return 加密后的数据
 */
+ (NSData *)AES128EncryptWithKey:(NSString *)key iv:(NSString *)iv withNSData:(NSData *)data;

/**
 *  AES128解密
 *
 *  @param key  解密的key
 *  @param iv   密钥向量
 *  @param data 解密的数据
 *
 *  @return 解密后的数据
 */
+ (NSData *)AES128DecryptWithKey:(NSString *)key iv:(NSString *)iv withNSData:(NSData *)data;

/**
 *  AES256加密
 *
 *  @param key         加密的key
 *  @param encryptData 加密的数据
 *
 *  @return 加密后的数据
 */
+ (NSData *)AES256EncryptWithKey:(NSString *)key encryptData:(NSData *)encryptData;

/**
 *  AES256解密
 *
 *  @param key         解密的key
 *  @param decryptData 解密的数据
 *
 *  @return 解密后的数据
 */
+ (NSData *)AES256DecryptWithKey:(NSString *)key decryptData:(NSData *)decryptData;

@end
