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

- (void)requestHomeTimeLineWithPageNumber:(NSInteger)page completionCallBack:(callBack)callBack {
    
    NSString *params = [NSString stringWithFormat:@"since_id=0&max_id=0&count=20&page=%ld&base_app=0&feature=0&trim_user=0", page];
    
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


-(void)getByApiName:(NSString *)apiName andParams:(NSString *)params andCallBack:(callBack)callback {
    
    NSString *apiPath = [NSString stringWithFormat:@"https://api.weibo.com/2/%@", apiName];
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"];
    
    NSString *normalParams = [NSString stringWithFormat:@"access_token=%@",accessToken];
    apiPath = [apiPath stringByAppendingFormat:@"?%@&%@", normalParams,params];
    
    NSLog(@"请求地址为： %@", apiPath);
    
    NSURL *url = [NSURL URLWithString:apiPath];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        callback(dic);
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
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        callback(dic);
    }];
    [task resume];
}




@end
