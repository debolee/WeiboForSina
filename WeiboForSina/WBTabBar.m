//
//  WBTabBar.m
//  WeiboForSina
//
//  Created by BOBO on 15/6/17.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import "WBTabBar.h"

@interface WBTabBar ()
@property (nonatomic, strong) NSMutableArray *buttons;


@end

@implementation WBTabBar

- (void)addButtonWithNormalImages:(NSArray *)normalImages AndSelectedImages:(NSArray *)selectedImages {
    
    //根据传入的图片的数量自动判断有多少个button
    if (normalImages.count > 0 && selectedImages.count > 0) {
        NSInteger buttonCount = (normalImages.count <= normalImages.count) ? normalImages.count : selectedImages.count;
        
        self.buttons = [[NSMutableArray alloc]init];
        //添加button
        for (int i = 0; i < buttonCount ; i++) {
            UIButton *button = [[UIButton alloc]init];
            [button setImage:normalImages[i] forState:UIControlStateNormal];
            [button setImage:selectedImages[i] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(buttonClick:)forControlEvents:UIControlEventTouchUpInside];
            [button setTag:i];
            [self addSubview:button];
            [self.buttons addObject:button];
            if (i == 0) {
                [self buttonClick:button];
            }
            if (i == 2) {
                [button setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateSelected];
            }
        }
    }
    
}

- (void)buttonClick:(UIButton *)button {
    if (button.tag != 2) {
        self.selectedButton.selected = NO;
        button.selected = YES;
        //通知UITabBarController控制器对象修改当前的selectedIndex
        if ([self.delegate respondsToSelector:@selector(tabBar:selectedFromButton:toButton:)]) {
            [self.delegate tabBar:self selectedFromButton:self.selectedButton.tag toButton:button.tag];
        }
        self.selectedButton = button;
    } else {
        if ([self.delegate respondsToSelector:@selector(tabBar:selectedFromButton:toButton:)]) {
            [self.delegate tabBar:self selectedFromButton:self.selectedButton.tag toButton:button.tag];
        }
    }


}

//设置button的位置
- (void)layoutSubviews {
    [super layoutSubviews];
    for (int i = 0; i < self.buttons.count; i++) {
        UIButton *button = self.buttons[i];
        CGFloat x = i * self.bounds.size.width / self.buttons.count;
        CGFloat y = 0;
        CGFloat width = self.bounds.size.width / self.buttons.count;
        CGFloat height = self.bounds.size.height;
        button.frame = CGRectMake(x, y, width, height);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
