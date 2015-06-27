//
//  WBPhotoBrowseView.h
//  WeiboForSina
//
//  Created by BOBO on 15/6/27.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBPhotoBrowseView : UIScrollView <UIScrollViewDelegate>

- (WBPhotoBrowseView *)initWithUrlPath:(NSString *)path
thumbnailImage:(UIImage *)image fromRect:(CGRect)rect;

@end
