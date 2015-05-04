//
//  WBUserInfo.h
//  WeiboForSina
//
//  Created by BOBO on 15/5/4.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBUserInfo : NSObject
@property (nonatomic, copy)NSString *coverImagePath;
@property (nonatomic, copy)NSString *portraitImagePath;
@property (nonatomic, copy)NSString *nickName;
@property (nonatomic, copy)NSString *followerCount;
@property (nonatomic, copy)NSString *fanscount;
@property (nonatomic, copy)NSString *introduction;
@property (nonatomic, copy)NSString *school;
@property (nonatomic, copy)NSString *site;

@end
