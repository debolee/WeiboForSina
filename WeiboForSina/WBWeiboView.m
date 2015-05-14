//
//  WBWeiboView.m
//  WeiboForSina
//
//  Created by BOBO on 15/5/10.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import "WBWeiboView.h"

@implementation WBWeiboView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //此位置初始化用到的两个控件
        [self initUI];
    }
    return self;
}

//界面中添加控件
-(void)initUI{
    float width = self.window.bounds.size.width - 20;
    if (self.isDetail) {
        width = self.window.bounds.size.width - 20;
    }
    //    添加文本控件
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, width, 0)];
    self.textView.userInteractionEnabled = NO;
    
    self.textView.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.textView];
    self.textView.backgroundColor = [UIColor clearColor];
    //    添加图片控件
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, 90)];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    
    [self addSubview:self.imageView];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //此位置写显示内容和更改尺寸的代码
    float width = self.window.bounds.size.width - 20;
    if (self.isDetail) {
        width = self.window.bounds.size.width - 20;
    }
    //计算文本高度
    CGRect frame = [self.weibo.text boundingRectWithSize:CGSizeMake(width, 999) options:NSStringDrawingUsesLineFragmentOrigin  attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil];
    self.textView.frame = CGRectMake(0, 0, width, frame.size.height+10);
    //   设置显示的文本
    self.textView.text = self.weibo.text;
    //如果存在图片
    if (self.weibo.thumbnailImage && ![self.weibo.thumbnailImage isEqualToString:@""]) {
        self.imageView.hidden = NO;
        self.imageView.frame = CGRectMake(-20,self.textView.frame.size.height+10, width, 90);
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.weibo.thumbnailImage] options:0 error:nil];
            UIImage *image = [UIImage imageWithData:imageData];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView.image = image;
            });
        });
        
    }else{//如果没有图片把图片隐藏
        self.imageView.hidden = YES;
    }
    
    
    //**************添加转发**************************
    if (self.weibo.retweetedWeibo) {
        //第一次需要创建 之后直接复用
        if (!self.relWeiboView) {
            self.relWeiboView = [[WBWeiboView alloc]initWithFrame:CGRectZero];
            self.relWeiboView.isDetail = self.isDetail;
            [self.relWeiboView setBackgroundColor:[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1]];
            [self addSubview:self.relWeiboView];
        }
        //        复用的时候如果没有转发需要隐藏  有则显示出来
        self.relWeiboView.hidden = NO;
        //更新尺寸
        self.relWeiboView.frame = CGRectMake(0, self.textView.frame.size.height+10, width, [self.relWeiboView.weibo getWeiboHeightIsDetailPage:self.isDetail]);
        //告诉控件显示的内容是什么
        self.relWeiboView.weibo = self.weibo.retweetedWeibo;
    }else{//如果没有转发就隐藏 不隐藏的话 会显示复用之前的内容
        self.relWeiboView.hidden = YES;
    }
    //********************************************
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
