//
//  NetworkViewController.h
//  CustomControls
//
//  Created by mojx on 16/9/22.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GZMoFramework/GZMoFramework.h>

@interface NetworkViewController : UIViewController

- (IBAction)NSURLSession_GET:(id)sender;
- (IBAction)NSURLSession_POST:(id)sender;
- (IBAction)NSURLSession_DELETE:(id)sender;
- (IBAction)NSURLSession_PUT:(id)sender;
- (IBAction)NSURLSession_UPLOAD:(id)sender;
- (IBAction)NSURLSession_UPLOAD2:(id)sender;

- (IBAction)NSURLConnection_GET:(id)sender;
- (IBAction)NSURLConnection_POST:(id)sender;
- (IBAction)NSURLConnection_DELETE:(id)sender;
- (IBAction)NSURLConnection_PUT:(id)sender;
- (IBAction)NSURLConnection_UPLOAD:(id)sender;
- (IBAction)NSURLConnection_UPLOAD2:(id)sender;

@end
