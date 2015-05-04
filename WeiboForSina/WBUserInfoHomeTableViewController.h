//
//  WBUserInfoHomeTableViewController.h
//  WeiboForSina
//
//  Created by BOBO on 15/5/1.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBUserInfoHomeTableViewController : UITableViewController<WBHttpRequestDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *coverImage;
@property (weak, nonatomic) IBOutlet UIImageView *portraitImage;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UIButton *followerCount;
@property (weak, nonatomic) IBOutlet UIButton *fansCount;
@property (weak, nonatomic) IBOutlet UILabel *simplyIntroduction;
@property (weak, nonatomic) IBOutlet UILabel *school;
@property (weak, nonatomic) IBOutlet UILabel *site;
@property (weak, nonatomic) IBOutlet UITextView *detailIntroduction;

@end
