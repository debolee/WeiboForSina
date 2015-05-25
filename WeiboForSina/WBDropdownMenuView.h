//
//  WBDropdownMenuView.h
//  WeiboForSina
//
//  Created by BOBO on 15/5/23.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBDropdownMenuView;

@protocol WBDropdownMenuViewDelegate <NSObject>
@optional
- (void)dropdownMenuDidDismiss:(WBDropdownMenuView *)menu;
- (void)dropdownMenuDidShow:(WBDropdownMenuView *)menu;

@end

@interface WBDropdownMenuView : UIView
@property (nonatomic, weak) id<WBDropdownMenuViewDelegate> delegate;

#pragma mark 在指定UIView下方显示菜单
- (void)showFrom:(UIView *)theView;

#pragma mark 销毁下拉菜单
- (void)dismiss;

// 要显示的内容控制器
@property (nonatomic, strong) UIViewController *contentController;

@end


