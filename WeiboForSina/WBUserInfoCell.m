//
//  WBUserInfoCell.m
//  WeiboForSina
//
//  Created by BOBO on 15/5/29.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import "WBUserInfoCell.h"
#import "SDWebImage/UIImageView+WebCache.h"

@implementation WBUserInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setUser:(WBUserInfo *)user {
    _user = user;
    if (self.user.portraitImagePath) {
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:self.user.portraitImagePath] placeholderImage:[UIImage imageNamed:@"placeholder_picture"]];
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
