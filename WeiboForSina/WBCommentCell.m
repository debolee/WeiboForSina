//
//  WBCommentCell.m
//  WeiboForSina
//
//  Created by BOBO on 15/5/17.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import "WBCommentCell.h"

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
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *heardImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.comment.user.portraitImagePath] options:0 error:nil];
            UIImage *heardImage = [UIImage imageWithData:heardImageData];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.headImageView.image = heardImage;
            });
        });
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
