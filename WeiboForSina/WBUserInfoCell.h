//
//  WBUserInfoCell.h
//  WeiboForSina
//
//  Created by BOBO on 15/5/29.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBUserInfo.h"

@interface WBUserInfoCell : UITableViewCell
@property(nonatomic, strong)WBUserInfo *user;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *introduction;
@property (weak, nonatomic) IBOutlet UIButton *followButton;
@end
