//
//  WBJsonParser.h
//  WeiboForSina
//
//  Created by BOBO on 15/5/4.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBUserInfo.h"

@interface WBJsonParser : NSObject
+ (WBUserInfo *)parseUserInfoWithDada:(NSData *)data;

@end
