//
//  WBPhotoBrowseView.m
//  WeiboForSina
//
//  Created by BOBO on 15/6/27.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import "WBPhotoBrowseView.h"
#import "SDWebImage/UIImageView+WebCache.h"

@interface WBPhotoBrowseView ()
@property (nonatomic, strong) UIImageView *bigImageView;
@property (nonatomic) CGRect originalRect;

@end



@implementation WBPhotoBrowseView

- (WBPhotoBrowseView *)initWithUrlPath:(NSString *)path thumbnailImage:(UIImage *)image fromRect:(CGRect)rect {
    self = [super init];
    if (self) {
        
        self.originalRect = rect;
        self.frame = [[UIApplication sharedApplication] keyWindow].frame;
        self.backgroundColor = [UIColor blackColor];
        
//        创建图片视图并配置相关属性
        self.bigImageView = [[UIImageView alloc]initWithImage:image];
        self.bigImageView.frame = rect;
        self.bigImageView.userInteractionEnabled = YES;
        self.bigImageView.contentMode = UIViewContentModeScaleAspectFit;

//        添加点击手势，点击图片缩小
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageAction:)];
        tapGesture.numberOfTapsRequired = 1;
        tapGesture.numberOfTouchesRequired = 1;
        [self.bigImageView addGestureRecognizer:tapGesture];
        
//        加载高清大图
        [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:path] placeholderImage:image];
        
//        将自身添加到ScrollView中
        [self addSubview:self.bigImageView];
        
//        添加放大动画
        [UIView animateWithDuration:0.5 animations:^{
            self.bigImageView.frame = self.frame;
        }];
    }

//    缩放相关
    self.delegate = self;
    self.maximumZoomScale = 4.0;
    self.minimumZoomScale = 0.5;
    return self;
}

- (void)tapImageAction:(UIImageView *)imageView {
    if (self.bigImageView.frame.size.height == self.frame.size.height) {
        self.backgroundColor = [UIColor clearColor];
//        添加缩小动画
        [UIView animateWithDuration:0.5 animations:^{
            self.bigImageView.frame = self.originalRect;
            
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    
//    if (!self.dragging) {
//        [self tapImageAction:self.bigImageView];
//    }
//}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.bigImageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    
    if (scale <= 1) {
        [UIView animateWithDuration:0.3 animations:^{
            view.center = scrollView.center;
        }];
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
