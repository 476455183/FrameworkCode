//
//  MyAVPlayer.m
//  CustomControls
//
//  Created by mojx on 16/9/28.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import "MyAVPlayer.h"

@implementation MyAVPlayer

/** 创建单例对象*/
+ (MyAVPlayer *)sharedSingleton
{
    static MyAVPlayer *sharedSingleton;
    
    @synchronized(self)
    {
        if (!sharedSingleton)
            sharedSingleton = [[MyAVPlayer alloc] init];
        return sharedSingleton;
    }
}

/**
 *  加载并弹出视频播放器
 *
 *  @param source   视频来源
 *  @param playType 播放类型
 *  @param control  视图控制器
 */
- (void)loadVideo:(NSString *)source playType:(enum VideoPlayerPlayType)playType control:(UIViewController *)control
{
    [self stopVideo];
    
    // 1.获取URL(远程/本地)
    NSString *urlStr;
    NSURL *url;
    if (playType == VideoPlayerPlayType_Resource)//从资源文件中播放
    {
        urlStr = [[NSBundle mainBundle]pathForResource:source ofType:nil];
        url = [NSURL fileURLWithPath:urlStr];
    }
    else if (playType == VideoPlayerPlayType_FilePath)//从文件中播放
    {
        urlStr = source;
        url = [NSURL fileURLWithPath:urlStr];
    }
    else if (playType == VideoPlayerPlayType_Url)//从网络中播放
    {
        urlStr = source;
        url = [NSURL URLWithString:urlStr];
    }

    // 2.创建AVPlayerItem
    //AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
    //设置AVAsset，必须要创建
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:url options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    
    // 3.创建AVPlayer
    self.avPlayer = [[AVPlayerViewController alloc] init];
    self.avPlayer.player = [AVPlayer playerWithPlayerItem:playerItem];

    // 4.弹出AVPlayer
    [control presentViewController:self.avPlayer animated:YES completion:nil];
}

/**
 *  加载并播放视频
 *
 *  @param source    视频来源
 *  @param playType  播放类型
 *  @param videoView 播放视频的view
 */
- (void)loadVideo:(NSString *)source playType:(enum VideoPlayerPlayType)playType videoView:(UIView *)videoView
{
    [self stopVideo];
    
    NSString *urlStr;
    NSURL *url;
    if (playType == VideoPlayerPlayType_Resource)//从资源文件中播放
    {
        urlStr = [[NSBundle mainBundle]pathForResource:source ofType:nil];
        url = [NSURL fileURLWithPath:urlStr];
    }
    else if (playType == VideoPlayerPlayType_FilePath)//从文件中播放
    {
        urlStr = source;
        url = [NSURL fileURLWithPath:urlStr];
    }
    else if (playType == VideoPlayerPlayType_Url)//从网络中播放
    {
        urlStr = source;
        url = [NSURL URLWithString:urlStr];
    }
    
    // 2.创建AVPlayerItem
    //AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
    //设置AVAsset，必须要创建
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:url options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    
    //给AVPlayerItem添加播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.avPlayer.player.currentItem];
    
    // 3.创建AVPlayer
    self.avPlayer = [[AVPlayerViewController alloc] init];
    self.avPlayer.player = [AVPlayer playerWithPlayerItem:playerItem];
    
    // 4.添加AVPlayerLayer
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer.player];
    self.playerLayer.frame = CGRectMake(0, 0, videoView.frame.size.width, videoView.frame.size.height);
    [videoView.layer addSublayer:self.playerLayer];
    
    //添加进度更新
    //[self addProgressObserver];
    
    //播放
    [self.avPlayer.player play];
}

//播放完成通知
- (void)playbackFinished:(NSNotification *)notification
{
    //NSLog(@"视频播放完成.");
    //[self stopVideo];
    
    //Block回调
    if (self.playFinishBlock)
        self.playFinishBlock();
}

/*
//给播放器添加进度更新
-(void)addProgressObserver
{
    AVPlayerItem *playerItem = avPlayer.player.currentItem;
    UIProgressView *progress = self.progressView;
    [progress setProgress:0 animated:YES];
    //这里设置每秒执行一次
    [avPlayer.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time)
     {
         float current = CMTimeGetSeconds(time);
         float total = CMTimeGetSeconds([playerItem duration]);
         NSLog(@"当前已经播放%.2fs.",current);
         if (current) {
             [progress setProgress:(current/total) animated:YES];
         }
     }];
}*/

/**
 *  播放或暂停播放视频
 *
 *  @return 为0说明是停止状态，1是则是正常播放状态
 */
- (NSInteger)playVideo
{
    if (self.avPlayer)
    {
        //通常情况下可以通过判断播放器的播放速度来获得播放状态。如果rate为0说明是停止状态，1是则是正常播放状态。
        if (self.avPlayer.player.rate == 0)
        {
            [self.avPlayer.player play];
        }
        else
        {
            [self.avPlayer.player pause];
        }
        return self.avPlayer.player.rate;
    }
    return 0;
}

/** 停止播放视频并释放资源*/
- (void)stopVideo
{
    if (self.avPlayer)
    {
        //释放播放资源
        [self.avPlayer.player replaceCurrentItemWithPlayerItem:nil];
        [self.playerLayer removeFromSuperlayer];
        self.playerLayer = nil;
        self.avPlayer.player = nil;
        self.avPlayer = nil;
    }
}

@end
