//
//  WBTabBar.h
//  WeiboForSina
//
//  Created by BOBO on 15/6/17.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//
 /// 自定义TabBar



#import <UIKit/UIKit.h>

@class WBTabBar;

@protocol WBTabBarDelegate <NSObject>

/**
 *  当用户点击按钮后，通知UITabBarController控制器对象修改当前的selectedIndex
 *
 *  @return 无返回值
 */
- (void) tabBar:(WBTabBar *)tabBar selectedFromButton:(NSInteger)fromTag toButton:(NSInteger)toTag;

@end


@interface WBTabBar : UIView
@property (nonatomic, weak) id<WBTabBarDelegate> delegate;

/**
 *  保存当前选中的按钮
 */
@property (nonatomic, weak) UIButton *selectedButton;

/**
 *  添加按钮到Tabbar，根据参数中图片数量及顺序创建对应的按钮，按钮tag值与按钮的创建顺序一致。normalImages与selectedImages中图片数量一致，如果不一致,按钮数量以较少的为准。
 *
 *  @param normalImages   按钮normal状态下的图片数组
 *  @param selectedImages 按钮selected状态下的图片数组
 */
- (void)addButtonWithNormalImages:(NSArray *)normalImages AndSelectedImages:(NSArray *)selectedImages;



@end
