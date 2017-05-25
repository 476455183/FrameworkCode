//
//  MyAVAudioPlayer.m
//  CustomControls
//
//  Created by mojx on 16/9/25.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import "MyAVAudioPlayer.h"

@interface MyAVAudioPlayer ()<AVAudioPlayerDelegate>
{
    AVAudioPlayer *audio_player;//音频播放器，用于播放录音文件
    BOOL isPlay;
}

@end


@implementation MyAVAudioPlayer

/** 创建单例对象*/
+ (MyAVAudioPlayer *)sharedSingleton
{
    static MyAVAudioPlayer *sharedSingleton;
    
    @synchronized(self)
    {
        if (!sharedSingleton)
            sharedSingleton = [[MyAVAudioPlayer alloc] init];
        return sharedSingleton;
    }
}

/** 播放语音*/
- (void)playVoice
{
    isPlay = YES;
    [audio_player play];
}

/** 停止播放语音*/
-(void)stopPlayVoice
{
    [audio_player stop];
    isPlay = NO;
}

/**
 *  音频播放器初始化
 *
 *  @param source   播放文件来源：资源文件或指定文件路径
 *  @param playType 音频播放器播放类型
 *
 *  @return 初始化成功返回YES，否则返回NO
 */
- (BOOL)audioPlayerInit:(NSString *)source playType:(enum AudioPlayerPlayType)playType
{
    /*
     AVAudioRecorder录音和AVAudioPlayer播放声音小的问题！
     问题描述：播放完一段音频，声音大小正常；录完一段音频，再重新播放一段音频时，声音就变得特别小。
     原因：
     使用kAudioSessionCategory_PlayAndRecord的时候，播放器的声音会自动切到receiver，所以听起来特别小，如果需要从speaker出声，需要自己设置。
     解决方案：
     在录完音，播放下一段音频之前，加入下面两行代码：
     */
    UInt32 doChangeDefaultRoute = 1;
    AudioSessionSetProperty(kAudioSessionProperty_OverrideCategoryDefaultToSpeaker,sizeof(doChangeDefaultRoute), &doChangeDefaultRoute);
    
    //NSString *urlStr = [[NSBundle mainBundle]pathForResource:@"message_music.mp3" ofType:nil];
    NSString *urlStr;
    if (playType == AudioPlayerPlayType_Resource)
        urlStr = [[NSBundle mainBundle]pathForResource:source ofType:nil];
    else
        urlStr = source;
    NSURL *url = [NSURL fileURLWithPath:urlStr];
    
    NSError *error=nil;
    //初始化播放器，注意这里的Url参数只能文件路径，不支持HTTP Url
    audio_player=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    //设置播放器属性
    audio_player.numberOfLoops = 0;//设置为0不循环
    audio_player.delegate = self;
    //设置初始音量大小
    //audio_player.volume = 1;//0.0-1.0之间
    [audio_player prepareToPlay];//预播放
    if (error)
    {
        NSLog(@"创建播放器过程中发生错误，错误信息：%@",error.localizedDescription);
        return NO;
    }
    //持续时间: 录制了多少秒
    NSLog(@"total time: %f", audio_player.duration);
    if (audio_player.duration == 0)
        return NO;
    
    return YES;
}

#pragma mark - 播放器代理方法
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    //NSLog(@"播放完成: successfully: %@",flag == YES ? @"YES": @"NO");
    //根据实际情况播放完成可以将会话关闭，其他音频应用继续播放
    //[[AVAudioSession sharedInstance]setActive:NO error:nil];
    [self stopPlayVoice];
    //使用Block传值
    if (self.FinishPlayingBlock)
        self.FinishPlayingBlock(player, flag);
}

@end
