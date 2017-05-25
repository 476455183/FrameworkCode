//
//  CustomWebView.h
//  CustomControls
//
//  Created by mojx on 16/7/27.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomWebView : UIView

/**
 *  加载网页访问请求
 *
 *  @param urlString 请求的url地址
 */
- (void)loadWebRequestWithUrl:(NSString*)urlString;

@end
