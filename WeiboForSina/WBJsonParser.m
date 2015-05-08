//
//  WBJsonParser.m
//  WeiboForSina
//
//  Created by BOBO on 15/5/4.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import "WBJsonParser.h"


@implementation WBJsonParser

+ (WBUserInfo *)parseUserInfoWithDada:(NSData *)data {
    WBUserInfo * userInfo = [[WBUserInfo alloc]init];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    userInfo.coverImagePath = [dic objectForKey:@"cover_image_phone"];
    userInfo.portraitImagePath = [dic objectForKey:@"avatar_large"];
    userInfo.nickName = [dic objectForKey:@"screen_name"];
    userInfo.followerCount = [dic objectForKey:@"friends_count"];
    userInfo.fanscount = [dic objectForKey:@"followers_count"];
    userInfo.introduction = [dic objectForKey:@"description"];
    userInfo.site = [dic objectForKey:@"location"];
    return userInfo;
}

@end
