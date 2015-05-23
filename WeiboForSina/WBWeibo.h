//
//  WBWeibo.h
//  WeiboForSina
//
//  Created by BOBO on 15/5/9.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBUserInfo.h"
#import <MapKit/MapKit.h>

@interface WBWeibo : NSObject

@property (nonatomic)BOOL isRepost;//是转发的微博
@property (nonatomic)CLLocationCoordinate2D coord;
@property(nonatomic,copy)NSString *createDate;        //微博的创建时间
@property(nonatomic,copy)NSString *weiboId;           //微博id
@property(nonatomic,copy)NSString *text;              //微博内容
@property(nonatomic,copy)NSString *source;            //微博来源
@property(nonatomic,copy)NSString *thumbnailImage;    //缩略图片地址，没有时不返回此字段

@property(nonatomic,strong)WBWeibo *retweetedWeibo;          //被转发的原微博
@property(nonatomic,strong)WBUserInfo *user;              //微博的作者用户
@property (nonatomic, copy)NSString *location;  //微博经纬度
@property(nonatomic,copy)NSString *latitude;
@property(nonatomic,copy)NSString *longitude;
@property (nonatomic, copy)NSString *repostsCount;  //转发数
@property (nonatomic, copy)NSString *commentsCount; //评论数
@property (nonatomic, copy)NSString *attitudesCount; //点赞数

//实现这个方法 计算微博高度
-(float)getWeiboHeightIsDetailPage:(BOOL)isDitail;

@end
