//
//  WBAppDelegate.m
//  WeiboForSina
//
//  Created by BOBO on 15/4/22.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import "WBAppDelegate.h"

@implementation WBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    //打开调试选项，并像微博客户端注册AppKey
//    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:WBAppKey];
    
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [WeiboSDK handleOpenURL:url delegate:self];
}



#pragma mark -WeiboSDKDelegate
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    
    if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        self.wbToken = [(WBAuthorizeResponse *)response accessToken];
        self.wbCurrentUserID = [(WBAuthorizeResponse *)response userID];
        NSLog(@"登录成功！");
        NSLog(@"self.wbToken is:%@", self.wbToken);
        NSLog(@"self.wbCurrentUserID is:%@", self.wbCurrentUserID);
        NSLog(@"self.wbCurrentUserID is:%@", self.wbCurrentUserID);
        
        //将请求到的Token信息保存起来
        NSUserDefaults *userDf = [NSUserDefaults standardUserDefaults];
        [userDf setObject:[(WBAuthorizeResponse *)response userID] forKey:@"userID"];
        [userDf setObject:[(WBAuthorizeResponse *)response accessToken] forKey:@"accessToken"];
        [userDf setObject:[(WBAuthorizeResponse *)response expirationDate] forKey:@"expirationDate"];
        [userDf setObject:[(WBAuthorizeResponse *)response refreshToken] forKey:@"refreshToken"];
        [userDf synchronize];
        
        NSLog(@"token的有效期：%@", [(WBAuthorizeResponse *)response expirationDate]);
        
        if ([(WBAuthorizeResponse *)response accessToken]) {
            [self.wbdelegate CallBackDidReceiveWeiboResponse:nil];   
        }

        



    }
}



- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    NSLog(@"didReceiveWeiboRequest执行了。。。。。。。");
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
