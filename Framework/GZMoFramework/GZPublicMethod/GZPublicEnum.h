//
//  GZPublicEnum.h
//  GZMoFramework
//
//  Created by mojx on 2016/11/13.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#ifndef GZPublicEnum_h
#define GZPublicEnum_h

//当前设备类型
typedef enum
{
    Device_other = 0,
    Device_iPhone4s = 1,
    Device_iPhone5_5s = 2,
    Device_iPhone6 = 3,
    Device_iPhone6_Plus = 4,
    Device_iPhone2g3g3gs = 5,
    Device_iPhone6s = 6,
    Device_iPhone6s_Plus = 7,
    Device_iPhone7 = 8,
    Device_iPhone7_Plus = 9,
} CurrentDeviceType;

//电话号码类型
typedef enum
{
    /** 手机号码*/
    KMobile_phone_number = 0,
    /** 固定电话*/
    KFixed_telephone = 1,
    /** 手机号码和固定电话*/
    KMobile_fixed_telephone = 2,
} TelephoneNumberType;

#endif /* GZPublicEnum_h */
