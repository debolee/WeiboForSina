//
//  WBChatListCell.m
//  WeiboForSina
//
//  Created by BOBO on 15/5/30.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import "WBChatListCell.h"

@implementation WBChatListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setMessage:(NSDictionary *)message {
    _message = message;
    self.headImageView.image = [message objectForKey:@"image"];
    self.nickName.text = [message objectForKey:@"nickName"];
    self.latestMessage.text = [message objectForKey:@"message"];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
