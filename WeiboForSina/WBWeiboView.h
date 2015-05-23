//
//  WBWeiboView.h
//  WeiboForSina
//
//  Created by BOBO on 15/5/10.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBWeibo.h"

@interface WBWeiboView : UIView

@property (nonatomic, strong)WBWeibo *weibo;
@property (nonatomic)BOOL isDetail;

@property (nonatomic, strong)UITextView *textView;
@property (nonatomic, strong)UIImageView *imageView;

//转发微博View
@property (nonatomic, strong)WBWeiboView *relWeiboView;
@end
