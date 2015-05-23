//
//  WBWeiboCell.h
//  WeiboForSina
//
//  Created by BOBO on 15/5/10.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBWeibo.h"
#import "WBWeiboView.h"

@interface WBWeiboCell : UITableViewCell<UIActionSheetDelegate>
@property (nonatomic, strong)WBWeiboView *weiboView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nick;
@property (weak, nonatomic) IBOutlet UILabel *topicTime;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UIButton *transNums;
@property (weak, nonatomic) IBOutlet UIButton *commentNum;
@property (weak, nonatomic) IBOutlet UIButton *attitCount;
@property (weak, nonatomic) IBOutlet UIButton *moreOperation;

@property(nonatomic,strong)WBWeibo * weibo;
@end
