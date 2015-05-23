//
//  WBDetailWeiboTableViewController.h
//  WeiboForSina
//
//  Created by BOBO on 15/5/15.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBDetailWeiboHeaderView.h"
#import "WBWeibo.h"
#import "WBComment.h"
#import "WBWeiboAPI.h"


@interface WBDetailWeiboTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet WBDetailWeiboHeaderView *detailWeiboHeaderView;
@property (nonatomic, strong) WBWeibo *weibo;
@property (nonatomic, strong) NSArray *comments;
@end
