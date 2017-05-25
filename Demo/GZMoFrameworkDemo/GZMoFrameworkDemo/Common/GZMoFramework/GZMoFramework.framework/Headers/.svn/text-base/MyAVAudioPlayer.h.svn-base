//
//  MyAVAudioPlayer.h
//  CustomControls
//
//  Created by mojx on 16/9/25.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

/**音频播放器播放类型*/
enum AudioPlayerPlayType
{
    /**从资源文件中播放*/
    AudioPlayerPlayType_Resource,
    /**从文件中播放*/
    AudioPlayerPlayType_FilePath
};


@interface MyAVAudioPlayer : NSObject

/** 完成播放回调*/
@property(nonatomic, copy) void(^FinishPlayingBlock)(AVAudioPlayer *player, BOOL successfullyFlag);


/** 创建单例对象*/
+ (MyAVAudioPlayer *)sharedSingleton;

/** 播放语音*/
- (void)playVoice;

/** 停止播放语音*/
- (void)stopPlayVoice;

/**
 *  音频播放器初始化
 *
 *  @param source   播放文件来源：资源文件或指定文件路径
 *  @param playType 音频播放器播放类型
 *
 *  @return 初始化成功返回YES，否则返回NO
 */
- (BOOL)audioPlayerInit:(NSString *)source playType:(enum AudioPlayerPlayType)playType;

@end
