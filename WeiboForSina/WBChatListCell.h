//
//  WBChatListCell.h
//  WeiboForSina
//
//  Created by BOBO on 15/5/30.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WBChatListCell : UITableViewCell
@property (nonatomic, strong) NSDictionary *message;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *latestMessage;

@end
