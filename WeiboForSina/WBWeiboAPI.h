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
@end