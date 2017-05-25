//
//  MyAVPlayer.h
//  CustomControls
//
//  Created by mojx on 16/9/28.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

/**视频播放器播放类型*/
enum VideoPlayerPlayType
{
    /**从资源文件中播放*/
    VideoPlayerPlayType_Resource,
    /**从文件中播放*/
    VideoPlayerPlayType_FilePath,
    /**从网络中播放*/
    VideoPlayerPlayType_Url,
};

@interface MyAVPlayer : NSObject

/** 视频播放器*/
@property(nonatomic, strong)AVPlayerViewController *avPlayer;
/** 视频播放图层*/
@property(nonatomic, strong)AVPlayerLayer *playerLayer;
/** 播放完成回调*/
@property(nonatomic, copy) void(^playFinishBlock)();

/** 创建单例对象*/
+ (MyAVPlayer *)sharedSingleton;

/**
 *  加载并弹出视频播放器
 *
 *  @param source   视频来源
 *  @param playType 播放类型
 *  @param control  视图控制器
 */
- (void)loadVideo:(NSString *)source playType:(enum VideoPlayerPlayType)playType control:(UIViewController *)control;

/**
 *  加载并播放视频
 *
 *  @param source    视频来源
 *  @param playType  播放类型
 *  @param videoView 播放视频的view
 */
- (void)loadVideo:(NSString *)source playType:(enum VideoPlayerPlayType)playType videoView:(UIView *)videoView;

/**
 *  播放或暂停播放视频
 *
 *  @return 为0说明是停止状态，1是则是正常播放状态
 */
- (NSInteger)playVideo;

/** 停止播放视频并释放资源*/
- (void)stopVideo;

@end
