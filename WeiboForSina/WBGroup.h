//
//  WBGroup.h
//  WeiboForSina
//
//  Created by BOBO on 15/5/28.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBUserInfo.h"

@interface WBGroup : NSObject
@property (nonatomic, copy)NSString *groupID;   //分组ID
@property (nonatomic, copy)NSString *groupName; //分组名称
@property (nonatomic, copy)NSString *groupMode; //分组可见范围
@property (nonatomic, copy)NSString *groupVisible;  //分组是否可见
@property (nonatomic, copy)NSString *groupLikeCount;
@property (nonatomic, copy)NSString *groupMemberCount;  //成员数量
@property (nonatomic, copy)NSString *groupDescription;
@property (nonatomic, copy)NSArray *groupTags;
@property (nonatomic, copy)NSString *groupProfileImageURL;
@property (nonatomic, strong)WBUserInfo *groupUser;  //当前用户
@property (nonatomic, copy)NSString *groupCreatedAt;

@end
