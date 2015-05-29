//
//  WBUserInfoCell.m
//  WeiboForSina
//
//  Created by BOBO on 15/5/29.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import "WBUserInfoCell.h"

@implementation WBUserInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setUser:(WBUserInfo *)user {
    _user = user;
    if (self.user.portraitImagePath) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.user.portraitImagePath] options:0 error:nil];
            UIImage *image = [UIImage imageWithData:imageData];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.headImageView.image = image;
            });
        });
    }
    
    self.nickName.text = self.user.nickName;
    self.introduction.text = self.user.introduction;
}
- (IBAction)followButtonClick:(UIButton *)sender {
#warning 发送关注请求，高级接口，暂未实现
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
