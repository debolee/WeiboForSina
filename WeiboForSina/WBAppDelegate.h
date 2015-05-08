//
//  WBAppDelegate.h
//  WeiboForSina
//
//  Created by BOBO on 15/4/22.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import <UIKit/UIKit.h>

//定义forCallBackDidReceiveWeiboResponseDelegate用于发出请求获得响应后回调
@protocol forCallBackDidReceiveWeiboResponseDelegate <NSObject>

- (void)CallBackDidReceiveWeiboResponse:(id) obj;

@end

@interface WBAppDelegate : UIResponder <UIApplicationDelegate,WeiboSDKDelegate>

@property (strong, nonatomic) UIWindow *window;


@property (nonatomic, copy)NSString *wbToken;
@property (nonatomic, copy)NSString *wbCurrentUserID;

//发送服务器返回授权信息后调用该方法
@property (nonatomic, weak)id<forCallBackDidReceiveWeiboResponseDelegate> wbdelegate;


@end

