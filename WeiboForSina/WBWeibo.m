//
//  WBWeibo.m
//  WeiboForSina
//
//  Created by BOBO on 15/5/9.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import "WBWeibo.h"

@implementation WBWeibo


-(float)getWeiboHeightIsDetailPage:(BOOL)isDitail{
    
    float height = 0;
    float width = 300;
    //    判断是否是详情页面
    if (isDitail) {
        width = 300;
    }
    //计算微博文本的高度
    CGRect frame = [self.text boundingRectWithSize:CGSizeMake(width, 999) options:NSStringDrawingUsesLineFragmentOrigin  attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil];
    //加上文本高度
    height += frame.size.height;
    //加上微博图片的高度-----------------------
    if (self.thumbnailImage != nil && ![@"" isEqualToString:self.thumbnailImage]) {
        height += 110;
    }
    
    
    
    //加上转发的微博的高度
    
    if (self.retweetedWeibo) {
        //转发微博视图的高度
        float repostHeight = [self.retweetedWeibo getWeiboHeightIsDetailPage:isDitail];
        height += repostHeight;
    }
    if (_isRepost == YES) {//如果有转发 多加20个像素 为了美观
        height += 10;
    }
    
    return height;
}

@end
