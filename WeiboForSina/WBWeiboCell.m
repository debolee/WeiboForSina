//
//  WBWeiboCell.m
//  WeiboForSina
//
//  Created by BOBO on 15/5/10.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import "WBWeiboCell.h"

@implementation WBWeiboCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *heardImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.weibo.user.portraitImagePath] options:0 error:nil];
        UIImage *heardImage = [UIImage imageWithData:heardImageData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.headImageView.image = heardImage;
        });
    });
    
    //****************************
    self.weiboView.weibo = self.weibo;
    [self.weiboView setNeedsLayout];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    //****************************
    //把WeiboView添加到界面
    self.weiboView = [[WBWeiboView alloc]initWithFrame:CGRectZero];
    [self addSubview:self.weiboView];
    //****************************
    NSLog(@"awakeFromNib of WBWeiboCell");
    
}

- (void)layoutSubviews {
    
    NSLog(@"layoutSubviews.............................");
    [super layoutSubviews];

    //设置weiboView的尺寸
    self.weiboView.frame = CGRectMake(10, 60, self.window.bounds.size.width - 10, [self.weibo getWeiboHeightIsDetailPage:NO]);
    
    self.address.frame = CGRectMake(10, [self.weibo getWeiboHeightIsDetailPage:NO] + 60, 25, 290);
    self.transNums.frame = CGRectMake(25, [self.weibo getWeiboHeightIsDetailPage:NO] + 90, 30, 30);
    self.commentNum.frame = CGRectMake(145, [self.weibo getWeiboHeightIsDetailPage:NO] + 90, 30, 30);
    self.attitCount.frame = CGRectMake(265, [self.weibo getWeiboHeightIsDetailPage:NO] + 90, 30, 30);
    

    //*****************************
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
