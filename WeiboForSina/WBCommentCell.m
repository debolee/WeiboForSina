//
//  WBCommentCell.m
//  WeiboForSina
//
//  Created by BOBO on 15/5/17.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import "WBCommentCell.h"
#import "SDWebImage/UIImageView+WebCache.h"

@implementation WBCommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setComment:(WBComment *)comment {
    _comment = comment;
    
    if (self.comment.user.portraitImagePath) {
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:self.comment.user.portraitImagePath] placeholderImage:[UIImage imageNamed:@"placeholder_picture"]];
    }
    
    self.nick.text = comment.user.nickName;
    self.topicTime.text = comment.createdAt;
    self.textView.text = comment.commentText;
    
}



- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
