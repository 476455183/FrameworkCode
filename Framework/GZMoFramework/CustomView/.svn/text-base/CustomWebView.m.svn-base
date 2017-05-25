//
//  CustomWebView.m
//  CustomControls
//
//  Created by mojx on 16/7/27.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import "CustomWebView.h"

@interface CustomWebView ()<UIWebViewDelegate>
{
    UIWebView *myWebView;
    UIActivityIndicatorView *activityIndicatorView;
}

@end

@implementation CustomWebView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//在initWithFrame:方法中添加子控件
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self webViewInit];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

-(void)webViewInit
{
    myWebView = [[UIWebView alloc]init];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    myWebView.frame = CGRectMake(0, 0, width, height);
    myWebView.userInteractionEnabled = YES;//是否支持交互
    myWebView.scalesPageToFit = YES;//自动缩放以适应屏幕
    myWebView.delegate = self;
    [self addSubview:myWebView];
    
    activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 32, 32)];
    [activityIndicatorView setCenter: self.center];
    //[activityIndicatorView setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleWhite];
    [activityIndicatorView setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleGray];
    [self addSubview:activityIndicatorView];
}


#pragma mark - UIWebViewDelegate

/**
 *  加载网页访问请求
 *
 *  @param urlString 请求的url地址
 */
- (void)loadWebRequestWithUrl:(NSString*)urlString
{
    //字符串转URL地址.stringByAddingPercentEscapesUsingEncoding: 解决NSURL中遇到了url中含有中文，导致NSURL初始化返回null问题。
    NSURL *url=[[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //请求初始化，可以在这针对缓存，超时做出一些设置
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:20];
    //request默认get方式
    //[request setHTTPMethod:@"GET"];
    [myWebView loadRequest:request];
}

#pragma mark - web启动链接时获取URL
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url = request.URL.absoluteString;
    NSLog(@"url: %@", url);
    //NSDictionary* dic = [request allHTTPHeaderFields];
    return YES;
}

#pragma mark - web完成启动
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [activityIndicatorView startAnimating];
}

#pragma mark - web完成加载
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicatorView stopAnimating];
}

#pragma mark - web加载出错
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"web error: %@",[error localizedDescription]);
    [activityIndicatorView stopAnimating];
}


#pragma mark - web方法
#pragma mark - 前进
- (void)webForawrd
{
    [myWebView goForward];
}
#pragma mark - 后退
- (void)webBack
{
    //[myWebView goBack];
    if([myWebView canGoBack])
    {
        [myWebView goBack];
    }
}
#pragma mark - 刷新
- (void)webReload
{
    [myWebView reload];
}

@end
