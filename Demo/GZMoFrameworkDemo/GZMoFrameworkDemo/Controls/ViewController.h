//
//  ViewController.h
//  GZMoFrameworkDemo
//
//  Created by mojx on 16/8/16.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GZMoFramework/GZMoFramework.h>

@interface ViewController : UIViewController<TableViewPlainDidSelectRow>
{
    NSString *titleText;
    NSInteger selectedCell;
}

@end

