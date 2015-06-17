//
//  WBDetailWeiboHeaderView.m
//  WeiboForSina
//
//  Created by BOBO on 15/5/16.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import "WBDetailWeiboHeaderView.h"
#import "SDWebImage/UIImageView+WebCache.h"

@implementation WBDetailWeiboHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setWeibo:(WBWeibo *)weibo {
    _weibo = weibo;
    self.nick.text = self.weibo.user.nickName;
    self.topicTime.text = self.weibo.createDate;
    self.address.text = self.weibo.location;
    [self.commentNum setTitle:self.weibo.commentsCount forState:UIControlStateNormal];
    [self.transNums setTitle:self.weibo.repostsCount forState:UIControlStateNormal];
    [self.attitCount setTitle:self.weibo.attitudesCount forState:UIControlStateNormal];
    
    if (self.weibo.user.portraitImagePath) {
        
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:self.weibo.user.portraitImagePath] placeholderImage:[UIImage imageNamed:@"placeholder_picture"]];
    }
    
    self.weiboView.weibo = self.weibo;
    [self layoutSubviews];
    
    
}

- (void)awakeFromNib {
    self.weiboView = [[WBWeiboView alloc]initWithFrame:CGRectZero];
    self.weiboView.isDetail = YES;
    [self addSubview:self.weiboView];
    
    NSLog(@"、、、、awakeFromNib of WBDetailWeiboHeaderView!!!");
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.weiboView.frame = CGRectMake(10, 50, self.window.bounds.size.width - 20, [self.weibo getWeiboHeightIsDetailPage:YES] + 10);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
