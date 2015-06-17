//
//  WBTabBar.h
//  WeiboForSina
//
//  Created by BOBO on 15/6/17.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

//自定义TabBar

#import <UIKit/UIKit.h>

@class WBTabBar;

@protocol WBTabBarDelegate <NSObject>

//定义一个协议方法，记录按钮跳转，当用户点击按钮后，通知UITabBarController控制器对象修改当前的selectedIndex
- (void) tabBar:(WBTabBar *)tabBar selectedFromButton:(NSInteger)fromTag toButton:(NSInteger)toTag;

@end


@interface WBTabBar : UIView
@property (nonatomic, weak) id<WBTabBarDelegate> delegate;
//保存当前选中的按钮
@property (nonatomic, weak) UIButton *selectedButton;

//向导航栏添加按钮
- (void)addButtonWithNormalImages:(NSArray *)normalImages AndSelectedImages:(NSArray *)selectedImages;



@end
