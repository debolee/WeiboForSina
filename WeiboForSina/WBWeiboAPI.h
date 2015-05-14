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


- (void)requestHomeTimeLineWithPageNumber:(NSInteger)page completionCallBack:(callBack)callBack;

@end
