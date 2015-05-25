//
//  WBTitleMenuViewController.h
//  WeiboForSina
//
//  Created by BOBO on 15/5/23.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBDropdownMenuView.h"

@protocol WBTitleMenuDelegate <NSObject>
#pragma mark 当前选中了哪一行
@required
- (void)selectAtIndexPath:(NSIndexPath *)indexPath title:(NSString*)title;
@end

@interface WBTitleMenuViewController : UITableViewController
@property (nonatomic, weak) id<WBTitleMenuDelegate> delegate;
@property (nonatomic, weak) WBDropdownMenuView * dropdownMenuView;

@end
