//
//  WBWeiboAPI.h
//  WeiboForSina
//
//  Created by BOBO on 15/5/9.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBJsonParser.h"

typedef void (^callBack) (id obj);
@interface WBWeiboAPI : NSObject
+ (WBWeiboAPI *) shareWeiboApi;

//获取当前登录用户及其所关注用户的最新微博
- (void)requestHomeTimeLineWithPageNumber:(NSInteger)page completionCallBack:(callBack)callBack;

//获取某条微博的评论列表
- (void)requestCommentsByWeiboId:(NSString *)weiboId WithPageNumber:(NSInteger)page completionCallBack:(callBack)callBack;

//获取当前登陆用户的好友分组
- (void)requestFriendshipGroupsCompletionCallBack:(callBack)callBack;

//获取系统推荐的热门用户列表
- (void)requestHotUsersWithCategory:(NSString *)category CompletionCallBack:(callBack)callBack;

//搜索用户时的联想搜索建议
- (void)searchSuggestionsUsersWithString:(NSString *)string AndCount:(int)count CompletionCallBack:(callBack)callBack;

//搜索学校时的联想搜索建议
- (void)searchSuggestionsSchoolsWithString:(NSString *)string AndCount:(int)count AndType:(int)type CompletionCallBack:(callBack)callBack;

//搜索公司时的联想搜索建议
- (void)searchSuggestionsCompaniesWithString:(NSString *)string AndCount:(int)count CompletionCallBack:(callBack)callBack;

@end
