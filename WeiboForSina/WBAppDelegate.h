//
//  WBAppDelegate.h
//  WeiboForSina
//
//  Created by BOBO on 15/4/22.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBAppDelegate : UIResponder <UIApplicationDelegate,WeiboSDKDelegate>

@property (strong, nonatomic) UIWindow *window;


@property (nonatomic, copy)NSString *wbToken;
@property (nonatomic, copy)NSString *wbCurrentUserID;
@end
