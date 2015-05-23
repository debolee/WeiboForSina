//
//  WBJsonParser.h
//  WeiboForSina
//
//  Created by BOBO on 15/5/4.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBUserInfo.h"
#import "WBWeibo.h"
#import "WBComment.h"

@interface WBJsonParser : NSObject
+ (WBUserInfo *)parseUserInfoByData:(NSData *)data;
+ (WBUserInfo *)parseUserInfoByDictionary:(NSDictionary *)dic;

//解析微博
+(WBWeibo *)parseWeiboByDictionary:(NSDictionary *)dic;

//解析评论
+(WBComment *)parseCommentByDictionary:(NSDictionary *)dic;
@end
