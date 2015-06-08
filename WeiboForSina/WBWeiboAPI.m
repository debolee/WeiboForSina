//
//  WBWeiboAPI.m
//  WeiboForSina
//
//  Created by BOBO on 15/5/9.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import "WBWeiboAPI.h"

static WBWeiboAPI *weiboApi;

@implementation WBWeiboAPI

+ (WBWeiboAPI *)shareWeiboApi {
    if (!weiboApi) {
        weiboApi = [[WBWeiboAPI alloc]init];
    }
    return weiboApi;
}


//获取当前登录用户及其所关注用户的最新微博
- (void)requestHomeTimeLineWithPageNumber:(NSInteger)page completionCallBack:(callBack)callBack {
    
    NSString *params = [NSString stringWithFormat:@"since_id=0&max_id=0&count=20&page=%ld&base_app=0&feature=0&trim_user=0", (long)page];
    
    
    [self getByApiName:@"statuses/home_timeline.json" andParams:params andCallBack:^(id obj) {
        NSDictionary *dic = obj;
        NSArray *weibosDic = [dic objectForKey:@"statuses"];
        NSMutableArray *weibos = [NSMutableArray array];
        for (NSDictionary *weiboDic in weibosDic) {
            WBWeibo *weibo = [WBJsonParser parseWeiboByDictionary:weiboDic];
            [weibos addObject:weibo];
        }
     callBack(weibos);
    }];
}

//获取某条微博的评论列表
- (void)requestCommentsByWeiboId:(NSString *)weiboId WithPageNumber:(NSInteger)page completionCallBack:(callBack)callBack {
    
    //请求回来的ID是int64类型的数据
    long long intWeibId = [weiboId longLongValue];
    
    NSString *params = [NSString stringWithFormat:@"id=%lld&since_id=0&max_id=0&count=50&page=%ld&filter_by_author=0" ,intWeibId , (long)page];
    
    [self getByApiName:@"comments/show.json" andParams:params andCallBack:^(id obj) {
        NSArray *commentsDic = [(NSDictionary *)obj objectForKey:@"comments"];
        NSMutableArray *comments = [NSMutableArray array];
        for (NSDictionary *commentDic in commentsDic) {
            WBComment *comment = [WBJsonParser parseCommentByDictionary:commentDic];
            [comments addObject:comment];
        }
        
        callBack(comments);
    }];
}


//获取当前登陆用户的好友分组
- (void)requestFriendshipGroupsCompletionCallBack:(callBack)callBack {
    [self getByApiName:@"friendships/groups.json" andParams:nil andCallBack:^(id obj) {
        NSArray *groupsDic = [(NSDictionary *)obj objectForKey:@"lists"];
        NSMutableArray *groups = [[NSMutableArray alloc]init];
        for (NSDictionary *groupDic in groupsDic) {
            WBGroup *group = [WBJsonParser parseGroupByDictionary:groupDic];
            [groups addObject:group];
        }
        callBack(groups);
    }];
    
}

//获取系统推荐的热门用户列表
- (void)requestHotUsersWithCategory:(NSString *)category CompletionCallBack:(callBack)callBack {
    NSString *params = [NSString stringWithFormat:@"id=%@" ,category];
    [self getByApiName:@"suggestions/users/hot.json" andParams:params andCallBack:^(id obj) {
        NSArray *usersDic = obj;
        NSMutableArray *users = [[NSMutableArray alloc]init];
        for (NSDictionary *userDic in usersDic) {
            WBUserInfo *user = [WBJsonParser parseUserInfoByDictionary:userDic];
            [users addObject:user];
        }
        callBack(users);
    }];
}

//搜索用户时的联想搜索建议
- (void)searchSuggestionsUsersWithString:(NSString *)string AndCount:(int)count CompletionCallBack:(callBack)callBack {
    NSString *params = [NSString stringWithFormat:@"q=%@&count=%d",string, count];
    [self getByApiName:@"search/suggestions/users.json" andParams:params andCallBack:^(id obj) {
        NSArray *suggestionsDic = obj;
        NSMutableArray *suggestions = [[NSMutableArray alloc]init];
        for (NSDictionary *suggestionDic in suggestionsDic) {
            WBSearchSuggestionsOfUsers *suggestion = [WBJsonParser parseSuggestionOfUserByDictionary:suggestionDic];
            [suggestions addObject:suggestion];
        }
        callBack(suggestions);
    }];
}

//搜索学校时的联想搜索建议
- (void)searchSuggestionsSchoolsWithString:(NSString *)string AndCount:(int)count AndType:(int)type CompletionCallBack:(callBack)callBack {
    NSString *params = [NSString stringWithFormat:@"q=%@&count=%d&type=%d",string, count,type];
    [self getByApiName:@"search/suggestions/schools.json" andParams:params andCallBack:^(id obj) {
        NSArray *suggestionsDic = obj;
        NSMutableArray *suggestions = [[NSMutableArray alloc]init];
        for (NSDictionary *suggestionDic in suggestionsDic) {
            WBSearchSuggestionsOfSchools *suggestion = [WBJsonParser parseSuggestionOfSchoolByDictionary:suggestionDic];
            [suggestions addObject:suggestion];
        }
        callBack(suggestions);
    }];
}

//搜索公司时的联想搜索建议
- (void)searchSuggestionsCompaniesWithString:(NSString *)string AndCount:(int)count CompletionCallBack:(callBack)callBack {
    NSString *params = [NSString stringWithFormat:@"q=%@&count=%d",string, count];
    [self getByApiName:@"search/suggestions/companies.json" andParams:params andCallBack:^(id obj) {
        NSArray *suggestionsDic = obj;
        NSMutableArray *suggestions = [[NSMutableArray alloc]init];
        for (NSDictionary *suggestionDic in suggestionsDic) {
            WBSearchSuggestionsOfCompanies *suggestion = [WBJsonParser parseSuggestionOfCompanyByDictionary:suggestionDic];
            [suggestions addObject:suggestion];
        }
        callBack(suggestions);
    }];
}



-(void)getByApiName:(NSString *)apiName andParams:(NSString *)params andCallBack:(callBack)callback {
    
    NSString *apiPath = [NSString stringWithFormat:@"https://api.weibo.com/2/%@", apiName];
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"];
    if (params) {
        NSString *normalParams = [NSString stringWithFormat:@"access_token=%@",accessToken];
        apiPath = [apiPath stringByAppendingFormat:@"?%@&%@", normalParams,params];
        apiPath = [apiPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    } else {
        NSString *normalParams = [NSString stringWithFormat:@"access_token=%@",accessToken];
        apiPath = [apiPath stringByAppendingFormat:@"?%@", normalParams];
        apiPath = [apiPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }

    
    NSLog(@"请求地址为： %@", apiPath);
    
    NSURL *url = [NSURL URLWithString:apiPath];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        id receiveData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        callback(receiveData);
    }];
    
    [task resume];

}


-(void)postByApiName:(NSString *)apiName andParams:(NSString *)params andCallBack:(callBack)callback {
    
    NSString *apiPath = [NSString stringWithFormat:@"https://api.weibo.com/2/%@", apiName];
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"];
    NSString *normalParams = [NSString stringWithFormat:@"access_token=%@",accessToken];
    NSString *allParams = [normalParams stringByAppendingFormat:@"&%@", params];
    
    NSURL *url = [NSURL URLWithString:apiPath];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[allParams dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        id  receiveData= [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        callback(receiveData);
    }];
    [task resume];
}




@end
