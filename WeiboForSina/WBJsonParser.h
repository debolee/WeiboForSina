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
#import "WBGroup.h"
#import "WBSearchSuggestionsOfUsers.h"
#import "WBSearchSuggestionsOfSchools.h"
#import "WBSearchSuggestionsOfCompanies.h"

@interface WBJsonParser : NSObject
+ (WBUserInfo *)parseUserInfoByData:(NSData *)data;
+ (WBUserInfo *)parseUserInfoByDictionary:(NSDictionary *)dic;

//解析微博
+(WBWeibo *)parseWeiboByDictionary:(NSDictionary *)dic;

//解析评论
+(WBComment *)parseCommentByDictionary:(NSDictionary *)dic;

//解析分组
+(WBGroup *)parseGroupByDictionary:(NSDictionary *)dic;

//解析搜索用户时的联想搜索建议
+(WBSearchSuggestionsOfUsers *)parseSuggestionOfUserByDictionary:(NSDictionary *)dic;

//解析搜索学校时的联想搜索建议
+(WBSearchSuggestionsOfSchools *)parseSuggestionOfSchoolByDictionary:(NSDictionary *)dic;

//解析搜索公司时的联想搜索建议
+(WBSearchSuggestionsOfCompanies *)parseSuggestionOfCompanyByDictionary:(NSDictionary *)dic;

@end
