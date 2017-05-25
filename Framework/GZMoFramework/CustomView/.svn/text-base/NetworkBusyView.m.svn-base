//
//  NetworkBusyView.m
//  ihuikou
//
//  Created by Horson on 14/11/18.
//  Copyright (c) 2014年 Horson. All rights reserved.
//

#import "NetworkBusyView.h"
#import "GZPublicConst.h"

@implementation NetworkBusyView

static NetworkBusyView *shareInstance = nil;

+(NetworkBusyView *)shareInstance{
    @synchronized (self){
        if (shareInstance == nil) {
            shareInstance =[[NetworkBusyView alloc]init];
        }
    }
    return shareInstance;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    @synchronized (self){
        if (shareInstance == nil) {
            shareInstance = [super allocWithZone:zone];
            return shareInstance;
        }
    }
    return nil;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.frame = CGRectMake(0, 63,self.frame.size.width , self.frame.size.height);
        self.backgroundColor=[UIColor clearColor];
        
        //半透明底色
        UIView * blackView=[[UIView alloc]initWithFrame:self.frame];
        [self addSubview:blackView];
        
        blackView.backgroundColor=[UIColor grayColor];
        blackView.alpha=0.5;
        //中間的黑色遠角矩形
        UIView * HUDview=[[UIView alloc]init];
        [self addSubview:HUDview];
        
        HUDview.backgroundColor=[UIColor lightGrayColor];
        HUDview.alpha=0.6;
        HUDview.layer.cornerRadius=6;
        HUDview.clipsToBounds=YES;
        //指示用的菊花
        UIActivityIndicatorView * HUDindicator=[[UIActivityIndicatorView alloc]
                                                initWithFrame:CGRectMake(0, 0, 30, 30)];
        [HUDview addSubview:HUDindicator];
        
        [HUDindicator setCenter:CGPointMake(40,30)];
        [HUDindicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [HUDindicator startAnimating];
        //显示提示文字用的label
        HUDlabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 50, 80, 30)];
        [HUDview addSubview:HUDlabel];
        
        HUDlabel.backgroundColor = [UIColor clearColor];
        HUDlabel.textColor = [UIColor whiteColor];
        HUDlabel.textAlignment = NSTextAlignmentCenter;
        HUDlabel.font = [UIFont systemFontOfSize:13];
        HUDview.frame = CGRectMake(kScreenWidth/2-40, kScreenHeight/2-120, 80, 80);
    }
    return self;
}

//设置显示的提示文字
-(void)setShowString:(NSString *)notice
{
    HUDlabel.text = notice;
}

#pragma mark - ****----显示遮挡页面
-(void)showBusyViewWithPrompt:(NSString *)prompt superView:(UIView *)aSuperView
{
    //设置提示文字
    [shareInstance setShowString:prompt];
    [aSuperView addSubview:shareInstance];
    //aSuperView.userInteractionEnabled = NO;
}

#pragma mark - ****----移除遮挡页面
-(void)removeBusyViewFromSuperView:(UIView *)aSuperView
{
    aSuperView.userInteractionEnabled = YES;
    [shareInstance removeFromSuperview];
}

@end
