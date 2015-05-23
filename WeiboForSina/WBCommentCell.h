//
//  WBCommentCell.h
//  WeiboForSina
//
//  Created by BOBO on 15/5/17.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBComment.h"

@interface WBCommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nick;
@property (weak, nonatomic) IBOutlet UILabel *topicTime;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic, strong) WBComment *comment;
@end
