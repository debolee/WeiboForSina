//
//  WBJsonParser.m
//  WeiboForSina
//
//  Created by BOBO on 15/5/4.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import "WBJsonParser.h"


@implementation WBJsonParser

+ (WBUserInfo *)parseUserInfoByData:(NSData *)data {
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

+ (WBUserInfo *)parseUserInfoByDictionary:(NSDictionary *)dic {
    WBUserInfo * userInfo = [[WBUserInfo alloc]init];
    userInfo.coverImagePath = [dic objectForKey:@"cover_image_phone"];
    userInfo.portraitImagePath = [dic objectForKey:@"avatar_large"];
    userInfo.nickName = [dic objectForKey:@"screen_name"];
    userInfo.followerCount = [dic objectForKey:@"friends_count"];
    userInfo.fanscount = [dic objectForKey:@"followers_count"];
    userInfo.introduction = [dic objectForKey:@"description"];
    userInfo.site = [dic objectForKey:@"location"];
    return userInfo;
}

+ (WBWeibo *)parseWeiboByDictionary:(NSDictionary *)dic {
    WBWeibo *myWeibo = [[WBWeibo alloc]init];
    
    
    myWeibo.createDate = [WBJsonParser fomateString:[dic objectForKey:@"created_at"]];
    
    myWeibo.text = [dic objectForKey:@"text"];
    
    myWeibo.source = [dic objectForKey:@"source"];
    myWeibo.repostsCount = [NSString stringWithFormat:@"%@",[dic objectForKey:@"reposts_count"]];
    myWeibo.commentsCount = [NSString stringWithFormat:@"%@",[dic objectForKey:@"comments_count"]];
    NSDictionary *locationDic = [dic objectForKey:@"geo"];
    if (locationDic&&![locationDic isMemberOfClass:[NSNull class]]) {
        NSArray *coordArr = [locationDic objectForKey:@"coordinates"];
        CLLocationCoordinate2D coord;
        coord.latitude = [coordArr[0] doubleValue];
        coord.longitude = [coordArr[1]doubleValue];
        myWeibo.coord = coord;
    }
    
    
    myWeibo.thumbnailImage = [dic objectForKey:@"thumbnail_pic"];
    id weiboID  = [dic objectForKey:@"id"];
    myWeibo.weiboId = [NSString stringWithFormat:@"%@",weiboID];
    //获取用户信息
    NSDictionary *userDic = [dic objectForKey:@"user"];
    WBUserInfo *userInfo = [WBJsonParser parseUserInfoByDictionary:userDic];
    myWeibo.user = userInfo;
    
    NSDictionary *reWeiboDic = [dic objectForKey:@"retweeted_status"];
    //判断是否有转发
    if (reWeiboDic && ![reWeiboDic isMemberOfClass:[NSNull class]]) {
        
        //如果发现有转发 调用自身
        myWeibo.retweetedWeibo = [WBJsonParser parseWeiboByDictionary:reWeiboDic];
        myWeibo.retweetedWeibo.isRepost = YES;
    }
    return myWeibo;
}

//转换时间格式
+ (NSString *)fomateString:(NSString *)datestring {
    NSString *formatString = @"E MMM d HH:mm:ss Z yyyy";
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:formatString];
    NSDate *date = [format dateFromString:datestring];
    formatString = @"MM-dd HH:mm";
    [format setDateFormat:formatString];
    
    return [format stringFromDate:date];
}

@end
