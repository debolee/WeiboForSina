//
//  WBComment.h
//  WeiboForSina
//
//  Created by BOBO on 15/5/17.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBUserInfo.h"
#import "WBWeibo.h"

@interface WBComment : NSObject
@property(nonatomic, copy)NSString *createdAt;
@property(nonatomic)NSInteger *commentId;
@property(nonatomic, copy)NSString *commentText;
@property(nonatomic, copy)NSString *commentSource;
@property(nonatomic, strong)WBUserInfo *user;
@property(nonatomic, copy)NSString *commentMid;
@property(nonatomic, copy)NSString *commentIdStr;
@property(nonatomic, strong)WBWeibo *weibo;
@property(nonatomic, strong)WBComment *replyComment;

//根据屏幕大小，传入评论文本的宽度，再根据宽度计算评论的高度，实现设备显示的适配
-(float)getCommentHeightWithWidth:(float) width;
@end
