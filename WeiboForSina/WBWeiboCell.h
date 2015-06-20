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

@class WBWeiboCell;

/**
 *  定义协议，用户响应cell中的事件
 */
@protocol WBWeiboCellDelegate <NSObject>

/**
 *  cell中的转发按钮被点击时会向它的委托对象发送此消息，例如，点击转发按钮会通知cell所在的视图控制器（视图控制器必须遵守WBWeiboCellDelegate协议）弹出一个传发微博的视图控制器,实现此方法是需要判断button的tag值
 *
 *  @param cell   当前cell对象
 *  @param button 被点击的按钮对象
 */
- (void)WBWeiboCell:(WBWeiboCell *)cell clickedButton:(UIButton *)button;


@end

@interface WBWeiboCell : UITableViewCell<UIActionSheetDelegate>
@property (nonatomic, weak) id<WBWeiboCellDelegate> delegate;
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
