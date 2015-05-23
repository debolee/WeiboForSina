//
//  WBComment.m
//  WeiboForSina
//
//  Created by BOBO on 15/5/17.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import "WBComment.h"

@implementation WBComment

-(float)getCommentHeightWithWidth:(float) width {
    NSLog(@"width is :%f", width);
    float height = 0.0;
//    NSString *commentString = self.commentText;
//    if (self.replyComment) {
//        commentString = [self.commentText stringByAppendingString:self.replyComment.commentText];
//    }

    CGRect frame = [self.commentText boundingRectWithSize:CGSizeMake(width, 999) options:NSStringDrawingUsesLineFragmentOrigin  attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:FONTSIZE_OF_WB - 2]} context:nil];
    
    NSLog(@"frame.size.height :%f", frame.size.height);
    //加上文本高度
    height += frame.size.height;
    return height;
}

@end
