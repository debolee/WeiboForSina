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
    [self.attitCount setTitle:self.weibo.attitudesCount forState:UIControlStateNormal];
    
    if (self.weibo.user.portraitImagePath) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *heardImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.weibo.user.portraitImagePath] options:0 error:nil];
            UIImage *heardImage = [UIImage imageWithData:heardImageData];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.headImageView.image = heardImage;
            });
        });
    }

    //****************************
    self.weiboView.weibo = self.weibo;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    //****************************
    //把WeiboView添加到界面
    self.weiboView = [[WBWeiboView alloc]initWithFrame:CGRectZero];
    self.weiboView.backgroundColor = [UIColor greenColor];
    [self addSubview:self.weiboView];
    //****************************
    
    //给cell上的button添加动作
    [self.moreOperation addTarget:self action:@selector(moreOperation:) forControlEvents:UIControlEventTouchUpInside];
    
    NSLog(@"awakeFromNib of WBWeiboCell");
    
}


#pragma mark 更多按钮
- (void)moreOperation:(id)sender {
    UIActionSheet * sheetofMore = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"举报" otherButtonTitles:@"屏蔽",@"取消关注", @"帮上头条", @"收藏", nil];
    sheetofMore.actionSheetStyle = UIActionSheetStyleDefault;
    [sheetofMore showInView:self];
    
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    //TODO
    
}



- (void)layoutSubviews {

    [super layoutSubviews];

    //设置weiboView的尺寸
    self.weiboView.frame = CGRectMake(10, 50, self.window.bounds.size.width - 20, [self.weibo getWeiboHeightIsDetailPage:NO] + 10);
    
//    NSLog(@"self.weiboView.frame x = %f, y = %f, width = %f, height = %f",
//          self.weiboView.frame.origin.x,
//          self.weiboView.frame.origin.y,
//          self.weiboView.frame.size.width,
//          self.weiboView.frame.size.height);
    
    
    NSLog(@"cell self.frame.size.height:%f", self.frame.size.height);
    
//    self.address.frame = CGRectMake(10, self.frame.size.height - 70, 25, 290);
//    self.transNums.frame = CGRectMake(25, self.frame.size.height - 40, 30, 30);
//    self.commentNum.frame = CGRectMake(145, self.frame.size.height - 40, 30, 30);
//    self.attitCount.frame = CGRectMake(265, self.frame.size.height - 40, 30, 30);
    
    NSLog(@"layoutSubviews.............................");
    //*****************************

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
