//
//  AudioVideoViewController.m
//  CustomControls
//
//  Created by mojx on 16/9/25.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import "AudioVideoViewController.h"

@implementation AudioVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

//播放资源文件
- (IBAction)audio_sample1:(id)sender
{
    [[MyAVAudioPlayer sharedSingleton] audioPlayerInit:@"iphone.mp3" playType:AudioPlayerPlayType_Resource];
    //播放语音
    [[MyAVAudioPlayer sharedSingleton] playVoice];
    //完成播放回调
    [MyAVAudioPlayer sharedSingleton].FinishPlayingBlock = ^(AVAudioPlayer *player, BOOL successfullyFlag)
    {
        NSLog(@"播放完成: successfully: %@",successfullyFlag == YES ? @"YES": @"NO");
    };
}

//播放沙盒内指定的文件
- (IBAction)audio_sample2:(id)sender
{
    NSString *filePath = [NSString stringWithFormat:@"%@/Documents/%@/%@", NSHomeDirectory(), @"music", @"iphone.mp3"];
    NSLog(@"%@", filePath);
    
    if ([GZPublicMethod createDir:@"music"])//不存在时则创建
    {
        //获取当前程序包中一个文件资源的（iphone.mp3）路径
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"iphone" ofType:@"mp3"];
        NSData *fileData = [NSData dataWithContentsOfFile:filePath];
        if (fileData)
        {
            BOOL ret = [GZPublicMethod saveAnyFileToDir:@"music" anyFileData:fileData fileName:@"iphone.mp3"];
            NSLog(@"%@", ret == YES ? @"YES" : @"NO");
        }
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        [[MyAVAudioPlayer sharedSingleton] audioPlayerInit:filePath playType:AudioPlayerPlayType_FilePath];
        //播放语音
        [[MyAVAudioPlayer sharedSingleton] playVoice];
        //完成播放回调
        [MyAVAudioPlayer sharedSingleton].FinishPlayingBlock = ^(AVAudioPlayer *player, BOOL successfullyFlag)
        {
            NSLog(@"播放完成: successfully: %@",successfullyFlag == YES ? @"YES": @"NO");
        };
    }
}

//播放资源文件
- (IBAction)video_sample1:(id)sender
{
    [[MyAVPlayer sharedSingleton] loadVideo:@"big_buck_bunny.mp4" playType:VideoPlayerPlayType_Resource control:self];
}

//播放沙盒内指定的文件
- (IBAction)video_sample2:(id)sender
{
    NSString *filePath = [NSString stringWithFormat:@"%@/Documents/%@/%@", NSHomeDirectory(), @"video", @"big_buck_bunny.mp4"];
    NSLog(@"%@", filePath);
    
    if ([GZPublicMethod createDir:@"video"])//不存在时则创建
    {
        //获取当前程序包中一个文件资源的（big_buck_bunny.mp4）路径
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"big_buck_bunny" ofType:@"mp4"];
        NSData *fileData = [NSData dataWithContentsOfFile:filePath];
        if (fileData)
        {
            BOOL ret = [GZPublicMethod saveAnyFileToDir:@"video" anyFileData:fileData fileName:@"big_buck_bunny.mp4"];
            NSLog(@"%@", ret == YES ? @"YES" : @"NO");
        }
    }
    
    [[MyAVPlayer sharedSingleton] loadVideo:filePath playType:VideoPlayerPlayType_FilePath control:self];
}

//播放网络视频
- (IBAction)video_sample3:(id)sender
{
    NSString *url = @"http://v1.mukewang.com/a45016f4-08d6-4277-abe6-bcfd5244c201/L.mp4";
    [[MyAVPlayer sharedSingleton] loadVideo:url playType:VideoPlayerPlayType_Url control:self];
}

//播放资源文件
- (IBAction)video_sample4:(id)sender
{
    //装载视频的view
    CGRect frame = CGRectMake(40, 301, 261, 175);
    UIView *view = [[UIView alloc]initWithFrame:frame];
    [self.view addSubview:view];
    
    //播放进度label
    frame.origin.y += frame.size.height;
    frame.size.width = 110;
    frame.size.height = 21;
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:11];
    [self.view addSubview:label];
    
    //播放进度view
    frame.origin.x += frame.size.width;
    frame.origin.y += frame.size.height/2;
    frame.size.width = 151;
    frame.size.height = 2;
    UIProgressView *progress = [[UIProgressView alloc]initWithFrame:frame];
    [progress setProgress:0 animated:YES];
    [self.view addSubview:progress];
    
    [[MyAVPlayer sharedSingleton] loadVideo:@"big_buck_bunny.mp4" playType:VideoPlayerPlayType_Resource videoView:view];

    //这里设置每秒执行一次
    [[MyAVPlayer sharedSingleton].avPlayer.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time)
     {
         //获取当前已经播放的时间
         float current = CMTimeGetSeconds(time);
         //获取总时间
         NSInteger duration = CMTimeGetSeconds([[MyAVPlayer sharedSingleton].avPlayer.player.currentItem duration]);
         NSString *playtime = [NSString stringWithFormat:@"%@ / %@",  [GZPublicMethod timeHHMMSSFromSS:current], [GZPublicMethod timeHHMMSSFromSS:duration]];
         
         //更新播放进度label值
         label.text = playtime;
         //更新播放进度view值
         if (current)
             [progress setProgress:(current/duration) animated:YES];
     }];
    
    //播放完成回调
    [MyAVPlayer sharedSingleton].playFinishBlock = ^()
    {
        NSLog(@"视频播放完成.");
        //根据需要，注释掉或开启下面一行：停止播放视频并释放资源
        //[[MyAVPlayer sharedSingleton] stopVideo];
    };
}

@end
