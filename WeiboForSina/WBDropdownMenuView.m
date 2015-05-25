//
//  WBDropdownMenuView.m
//  WeiboForSina
//
//  Created by BOBO on 15/5/23.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import "WBDropdownMenuView.h"
@interface WBDropdownMenuView ()
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIImageView *arrowImageView;
@end

@implementation WBDropdownMenuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 清除默认的背景颜色
        self.backgroundColor = [UIColor clearColor];
        
        // 添加一个灰色图片，作为下拉菜单的背景
        self.bgImageView = [[UIImageView alloc] init];
        self.arrowImageView = [[UIImageView alloc]init];
        UIImage *bgImage = [UIImage imageNamed:@"popover_background"];
        UIImage *arrowImage = [UIImage imageNamed:@"popover_arrow"];
        UIImage *resizableImage = [bgImage resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
        self.bgImageView.image = resizableImage;
        self.arrowImageView.image = arrowImage;
        self.bgImageView.userInteractionEnabled = YES;
        [self addSubview:self.bgImageView];
        [self addSubview:self.arrowImageView];
    }
    return self;
}

#pragma mark 在指定UIView下方显示菜单
- (void)showFrom:(UIView *)theView {
    // 1.获得最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    // 2.添加自己到窗口上
    [window addSubview:self];
    
    // 3.设置尺寸
    self.frame = window.bounds;
    
    // 4.调整灰色图片的位置
    // 默认情况下，frame是以父控件左上角为坐标原点
    // 转换坐标系
    CGRect newFrame = [[theView superview] convertRect:theView.frame toView:window];
    self.arrowImageView.frame = CGRectMake(newFrame.origin.x + newFrame.size.width / 2 - 8, newFrame.origin.y + newFrame.size.height - newFrame.size.height/3, 16, 15);
    self.bgImageView.frame = CGRectMake(newFrame.origin.x + newFrame.size.width / 2 - 90, newFrame.origin.y + newFrame.size.height - newFrame.size.height/3 + self.arrowImageView.frame.size.height, 180, 320);
    
    // 通知外界，自己显示了
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidShow:)]) {
        [self.delegate dropdownMenuDidShow:self];
    }
}

#pragma mark 设置显示菜单的内容控制器
- (void)setContentController:(UIViewController *)contentController {
    _contentController = contentController;
    UIView *contentView = contentController.view;
    contentView.backgroundColor = [UIColor clearColor];
    contentView.frame = CGRectMake(15, 30, 150,270);
    [self.bgImageView addSubview:contentView];
}

#pragma mark 点击自己执行销毁动作
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}

#pragma mark 销毁下拉菜单
- (void)dismiss {
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidDismiss:)]) {
        [self.delegate dropdownMenuDidDismiss:self];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
