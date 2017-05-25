//
//  MySecurity.m
//  CustomControls
//
//  Created by mojx on 16/9/16.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import "MySecurity.h"
#import <CommonCrypto/CommonDigest.h> //md5
#import <CommonCrypto/CommonCryptor.h>//des、3des、aes
//#import <Security/Security.h>
#import "GTMBase64.h"

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@implementation MySecurity


/**
 *  MD5字符串加密
 *
 *  @param sourceString 加密字符串
 *  @param length       加密长度：16、32
 *  @param isLowerCase  是否小写
 *
 *  @return 加密后的结果
 */
+ (NSString *)md5String:(NSString *)sourceString encryptionLength:(NSInteger)length isLowerCase:(BOOL)isLowerCase
{
    if (!sourceString || (length != 16 && length != 32))
        return nil;
    
    //MD5加密都是通过C级别的函数来计算，所以需要将加密的字符串转换为C语言的字符串
    const char *cString = sourceString.UTF8String;
    //创建一个C语言的字符数组，用来接收加密结束之后的字符
    //unsigned char result[CC_MD5_DIGEST_LENGTH];
    unsigned char result[length];
    
    //MD5计算（也就是加密）
    //第一个参数：需要加密的字符串
    //第二个参数：需要加密的字符串的长度
    //第三个参数：加密完成之后的字符串存储的地方
    CC_MD5(cString, (CC_LONG)strlen(cString), result);
    
    //*
    //将加密完成的字符拼接起来使用（16进制的）。
    //声明一个可变字符串类型，用来拼接转换好的字符
    NSMutableString *resultString = [[NSMutableString alloc]init];
    
    NSString *format = @"%02X";//大写
    if (isLowerCase)
        format = @"%02x";//小写
    
    //遍历所有的result数组，取出所有的字符来拼接
    //for (int i = 0;i < CC_MD5_DIGEST_LENGTH; i++)
    for (int i = 0;i < length; i++)
    {
        [resultString  appendFormat:format,result[i]];
        //%02x：x 表示以十六进制形式输出，02 表示不足两位，前面补0输出；超出两位，不影响。当x小写的时候，返回的密文中的字母就是小写的，当X大写的时候返回的密文中的字母是大写的。
    }//*/
    
    /*NSString *resultString;
     if (length == 16 && isLowerCase)
     {
     resultString = [NSString stringWithFormat:
     @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
     result[0], result[1], result[2], result[3],
     result[4], result[5], result[6], result[7],
     result[8], result[9], result[10], result[11],
     result[12], result[13], result[14], result[15]
     ];
     }
     else if (length == 16 && !isLowerCase)
     {
     resultString = [NSString stringWithFormat:
     @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
     result[0], result[1], result[2], result[3],
     result[4], result[5], result[6], result[7],
     result[8], result[9], result[10], result[11],
     result[12], result[13], result[14], result[15]
     ];
     }
     else if (length == 32 && isLowerCase)
     {
     resultString = [NSString stringWithFormat:
     @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
     result[0], result[1], result[2], result[3],
     result[4], result[5], result[6], result[7],
     result[8], result[9], result[10], result[11],
     result[12], result[13], result[14], result[15],
     result[16], result[17],result[18], result[19],
     result[20], result[21],result[22], result[23],
     result[24], result[25],result[26], result[27],
     result[28], result[29],result[30], result[31]];
     }
     else if (length == 32 && !isLowerCase)
     {
     resultString = [NSString stringWithFormat:
     @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
     result[0],result[1],result[2],result[3],
     result[4],result[5],result[6],result[7],
     result[8],result[9],result[10],result[11],
     result[12],result[13],result[14],result[15],
     result[16], result[17],result[18], result[19],
     result[20], result[21],result[22], result[23],
     result[24], result[25],result[26], result[27],
     result[28], result[29],result[30], result[31]];
     }*/
    
    //打印最终需要的字符
    //NSLog(@"resultString === %@",resultString);
    return resultString;
}

/**
 *  md5 data加密
 *
 *  @param sourceData 需要加密的数据
 *
 *  @return 加密后的数据
 */
+ (NSString *)md5Data:(NSData *)sourceData
{
    if (!sourceData)
        return nil;//判断sourceString如果为空则直接返回nil。
    
    //需要MD5变量并且初始化
    CC_MD5_CTX  md5;
    CC_MD5_Init(&md5);
    //开始加密(第一个参数：对md5变量去地址，要为该变量指向的内存空间计算好数据，第二个参数：需要计算的源数据，第三个参数：源数据的长度)
    CC_MD5_Update(&md5, sourceData.bytes, (CC_LONG)sourceData.length);
    
    //声明一个无符号的字符数组，用来盛放转换好的数据
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    //将数据放入result数组
    CC_MD5_Final(result, &md5);
    //将result中的字符拼接为OC语言中的字符串，以便我们使用。
    NSMutableString *resultString = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [resultString appendFormat:@"%02X",result[i]];
    }
    
    //NSLog(@"resultString=========%@",resultString);
    return  resultString;
}

/**
 *  base64编码（生成base64编码的字符串）
 *
 *  @param sourceData 数据源
 *
 *  @return base64编码字符串
 */
+ (NSString *)base64EncodingWithData:(NSData *)sourceData
{
    if (!sourceData) //如果sourceData则返回nil，不进行base64编码
        return nil;
    
    NSString *resultString = [sourceData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return resultString;
}

/**
 *  base64反编码（生成base64反编码的数据）
 *
 *  @param sourceString 数据源
 *
 *  @return base64反编码数据
 */
+ (id)base64EncodingWithString:(NSString *)sourceString
{
    if (!sourceString)//如果sourceString则返回nil，不进行base64反编码
        return nil;
    
    NSData *resultData = [[NSData alloc]initWithBase64EncodedString:sourceString options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return resultData;
}

/**
 *  转化为Base64
 *
 *  @param text 数据
 *
 *  @return base64编码字符串
 */
+ (NSString *)base64StringFromText:(NSString *)text
{
    if (text && ![text isEqualToString:@""])
    {
        //取项目的bundleIdentifier作为KEY  改动了此处
        //NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
        //IOS 自带DES加密 Begin  改动了此处
        //data = [self DESEncrypt:data WithKey:key];
        //IOS 自带DES加密 End
        return [self base64EncodedStringFrom:data];
    }
    else
        return @"";
}

/**
 *  base64反编码
 *
 *  @param base64 base64编码字符串
 *
 *  @return base64反编码数据
 */
+ (NSString *)textFromBase64String:(NSString *)base64
{
    if (base64 && ![base64 isEqualToString:@""])
    {
        //取项目的bundleIdentifier作为KEY   改动了此处
        //NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [self dataWithBase64EncodedString:base64];
        //IOS 自带DES解密 Begin    改动了此处
        //data = [self DESDecrypt:data WithKey:key];
        //IOS 自带DES加密 End
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    else
        return @"";
}

/**
 *  base64编码字符串转换为NSData数据
 *
 *  @param string base64编码字符串
 *
 *  @return base64反编码数据
 */
+ (NSData *)dataWithBase64EncodedString:(NSString *)string
{
    if (string == nil)
        [NSException raise:NSInvalidArgumentException format:@""];
    if ([string length] == 0)
        return [NSData data];
    static char *decodingTable = NULL;
    if (decodingTable == NULL)
    {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++)
            decodingTable[(short)encodingTable[i]] = i;
    }
    const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL)     //  Not an ASCII string!
        return nil;
    char *bytes = malloc((([string length] + 3) / 4) * 3);
    if (bytes == NULL)
        return nil;
    NSUInteger length = 0;
    NSUInteger i = 0;
    while (YES)
    {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++)
        {
            if (characters[i] == '\0')
                break;
            if (isspace(characters[i]) || characters[i] == '=')
                continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
            {
                free(bytes);
                return nil;
            }
        }
        if (bufferLength == 0)
            break;
        if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
        {
            free(bytes);
            return nil;
        }
        //  Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2)
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3)
            bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    bytes = realloc(bytes, length);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}

/**
 *  NSData数据转base64编码字符串
 *
 *  @param data NSData数据
 *
 *  @return base64编码字符串
 */
+ (NSString *)base64EncodedStringFrom:(NSData *)data
{
    if ([data length] == 0)
        return @"";
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    NSUInteger i = 0;
    while (i < [data length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

/**
 *  DES加密
 *
 *  @param sText 需要加密的数据
 *  @param key   加密key
 *  @param ivDes 密钥向量
 *
 *  @return DES加密后的数据
 */
+ (NSString *)encryptWithDESSting:(NSString *)sText key:(NSString *)key andDesiv:(NSString *)ivDes
{
    if ((sText == nil || sText.length == 0)
        || (sText == nil || sText.length == 0)
        || (ivDes == nil || ivDes.length == 0)) {
        return @"";
    }
    //gb2312 编码
    NSStringEncoding encoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* encryptData = [sText dataUsingEncoding:encoding];
    size_t  dataInLength = [encryptData length];
    const void *   dataIn = (const void *)[encryptData bytes];
    CCCryptorStatus ccStatus;
    uint8_t *dataOut = NULL; //可以理解位type/typedef 的缩写（有效的维护了代码，比如：一个人用int，一个人用long。最好用typedef来定义）
    size_t dataOutMoved = 0;
    size_t    dataOutAvailable = (dataInLength + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);  dataOut = malloc( dataOutAvailable * sizeof(uint8_t));
    memset((void *)dataOut, 0x0, dataOutAvailable);//将已开辟内存空间buffer的首 1 个字节的值设为值 0
    const void *iv = (const void *) [ivDes cStringUsingEncoding:NSASCIIStringEncoding];
    //CCCrypt函数 加密/解密
    ccStatus = CCCrypt(kCCEncrypt,//  加密/解密
                       kCCAlgorithmDES,//  加密根据哪个标准（des，3des，aes。。。。）
                       kCCOptionPKCS7Padding,//  选项分组密码算法(des:对每块分组加一次密  3DES：对每块分组加三个不同的密)
                       [key UTF8String],  //密钥    加密和解密的密钥必须一致
                       kCCKeySizeDES,//   DES 密钥的大小（kCCKeySizeDES=8）
                       iv, //  可选的初始矢量
                       dataIn, // 数据的存储单元
                       dataInLength,// 数据的大小
                       (void *)dataOut,// 用于返回数据
                       dataOutAvailable,
                       &dataOutMoved);
    //编码 base64
    NSData *data = [NSData dataWithBytes:(const void *)dataOut length:(NSUInteger)dataOutMoved];
    Byte *bytes = (Byte *)[data bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[data length];i++){
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    free(dataOut);
    return hexStr;
}

/**
 *  DES解密
 *
 *  @param sText 需要解密的数据
 *  @param key   加密key
 *  @param iv    密钥向量
 *
 *  @return DES解密后的数据
 */
+ (NSString *)decryptWithDESString:(NSString *)sText key:(NSString *)key andiV:(NSString *)iv
{
    if ((sText == nil || sText.length == 0)
        || (sText == nil || sText.length == 0)
        || (iv == nil || iv.length == 0)) {
        return @"";
    }
    const void *dataIn;
    size_t dataInLength;
    char *myBuffer = (char *)malloc((int)[sText length] / 2 + 1);
    bzero(myBuffer, [sText length] / 2 + 1);
    for (int i = 0; i < [sText length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [sText substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSData *decryptData =[NSData dataWithBytes:myBuffer length:[sText length] / 2 ];//转成utf-8并decode
    dataInLength = [decryptData length];
    dataIn = [decryptData bytes];
    free(myBuffer);
    CCCryptorStatus ccStatus;
    uint8_t *dataOut = NULL; //可以理解位type/typedef 的缩写（有效的维护了代码，比如：一个人用int，一个人用long。最好用typedef来定义）
    size_t dataOutAvailable = 0; //size_t  是操作符sizeof返回的结果类型
    size_t dataOutMoved = 0;
    dataOutAvailable = (dataInLength + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    dataOut = malloc( dataOutAvailable * sizeof(uint8_t));
    memset((void *)dataOut, 0x0, dataOutAvailable);//将已开辟内存空间buffer的首 1 个字节的值设为值 0
    const void *ivDes = (const void *) [iv cStringUsingEncoding:NSASCIIStringEncoding];
    //CCCrypt函数 加密/解密
    ccStatus = CCCrypt(kCCDecrypt,//  加密/解密
                       kCCAlgorithmDES,//  加密根据哪个标准（des，3des，aes。。。。）
                       kCCOptionPKCS7Padding,//  选项分组密码算法(des:对每块分组加一次密  3DES：对每块分组加三个不同的密)
                       [key UTF8String],  //密钥    加密和解密的密钥必须一致
                       kCCKeySizeDES,//   DES 密钥的大小（kCCKeySizeDES=8）
                       ivDes, //  可选的初始矢量
                       dataIn, // 数据的存储单元
                       dataInLength,// 数据的大小
                       (void *)dataOut,// 用于返回数据
                       dataOutAvailable,
                       &dataOutMoved);
    NSStringEncoding encoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *result  = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)dataOut length:(NSUInteger)dataOutMoved] encoding:encoding];
    free(dataOut);
    return result;
}

/**
 *  3des加解密
 *
 *  @param plainText        加解密的明文
 *  @param encryptOrDecrypt 加密或解密：加密0，解密1
 *  @param key              加解密的key
 *
 *  @return 加解密后的数据
 */
+ (NSString *)tripleDES:(NSString*)plainText encryptOrDecrypt:(int)encryptOrDecrypt key:(NSString *)key
{
    const void *vplainText;
    size_t plainTextBufferSize;
    
    if (encryptOrDecrypt == kCCDecrypt)//解密
    {
        NSData *EncryptData = [GTMBase64 decodeData:[plainText dataUsingEncoding:NSUTF8StringEncoding]];
        plainTextBufferSize = [EncryptData length];
        vplainText = [EncryptData bytes];
    }
    else //加密
    {
        NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
        plainTextBufferSize = [data length];
        vplainText = (const void *)[data bytes];
    }
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    // memset((void *) iv, 0x0, (size_t) sizeof(iv));
    
    const void *vkey = (const void *) [key UTF8String];
    // NSString *initVec = @init Vec;
    //const void *vinitVec = (const void *) [initVec UTF8String];
    // Byte iv[] = {0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF};
    ccStatus = CCCrypt(encryptOrDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                       vkey,
                       kCCKeySize3DES,
                       nil,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    //if (ccStatus == kCCSuccess) NSLog(@SUCCESS);
    /*else if (ccStatus == kCC ParamError) return @PARAM ERROR;
     else if (ccStatus == kCCBufferTooSmall) return @BUFFER TOO SMALL;
     else if (ccStatus == kCCMemoryFailure) return @MEMORY FAILURE;
     else if (ccStatus == kCCAlignmentError) return @ALIGNMENT;
     else if (ccStatus == kCCDecodeError) return @DECODE ERROR;
     else if (ccStatus == kCCUnimplemented) return @UNIMPLEMENTED; */
    
    NSString *result;
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                                length:(NSUInteger)movedBytes]
                                        encoding:NSUTF8StringEncoding];
    }
    else
    {
        NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
        result = [GTMBase64 stringByEncodingData:myData];
    }
    
    return result;
}

/**
 *  AES128加密
 *
 *  @param key  加密的key
 *  @param iv   密钥向量
 *  @param data 加密的数据
 *
 *  @return 加密后的数据
 */
+ (NSData *)AES128EncryptWithKey:(NSString *)key iv:(NSString *)iv withNSData:(NSData *)data
{
    char keyPtr[kCCKeySizeAES128+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    char ivPtr[kCCKeySizeAES128+1];
    bzero(ivPtr, sizeof(ivPtr));
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    int diff = kCCKeySizeAES128 - (dataLength % kCCKeySizeAES128);
    int newSize = 0;
    if(diff > 0)
    {
        newSize = (int)(dataLength + diff);
    }
    char dataPtr[newSize];
    memcpy(dataPtr, [data bytes], [data length]);
    for(int i = 0; i < diff; i++)
    {
        dataPtr[i + dataLength] = 0x00;
    }
    size_t bufferSize = newSize + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          0x00, //No padding
                                          keyPtr,
                                          kCCKeySizeAES128,
                                          ivPtr,
                                          dataPtr,
                                          sizeof(dataPtr),
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    if(cryptStatus == kCCSuccess)
    {
        //        NSData *data =[NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        //        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    return nil;
}

/**
 *  AES128解密
 *
 *  @param key  解密的key
 *  @param iv   密钥向量
 *  @param data 解密的数据
 *
 *  @return 解密后的数据
 */
+ (NSData *)AES128DecryptWithKey:(NSString *)key iv:(NSString *)iv withNSData:(NSData *)data
{
    char keyPtr[kCCKeySizeAES128+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    char ivPtr[kCCKeySizeAES128+1];
    bzero(ivPtr, sizeof(ivPtr));
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          0x00, //No padding
                                          keyPtr,
                                          kCCKeySizeAES128,
                                          ivPtr,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    if(cryptStatus == kCCSuccess)
    {
        //        NSData *data =[NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        // NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    return nil;
}

/**
 *  AES256加密
 *
 *  @param key         加密的key
 *  @param encryptData 加密的数据
 *
 *  @return 加密后的数据
 */
+ (NSData *)AES256EncryptWithKey:(NSString *)key encryptData:(NSData *)encryptData
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [encryptData length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeAES128,
                                          NULL,
                                          [encryptData bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}

/**
 *  AES256解密
 *
 *  @param key         解密的key
 *  @param decryptData 解密的数据
 *
 *  @return 解密后的数据
 */
+ (NSData *)AES256DecryptWithKey:(NSString *)key decryptData:(NSData *)decryptData
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [decryptData length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeAES128,
                                          NULL,
                                          [decryptData bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    free(buffer);
    return nil;
}

@end
