//
//  WBUserAnnotationView.m
//  WeiboForSina
//
//  Created by BOBO on 15/6/14.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import "WBUserAnnotationView.h"

@implementation WBUserAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *backView = [[UIImageView alloc]init];
        backView.backgroundColor = [UIColor blackColor];
        backView.frame = CGRectMake(-22, -44, 44, 44);
        backView.contentMode = UIViewContentModeScaleToFill;
        backView.layer.cornerRadius = 22;
        backView.layer.masksToBounds = YES;
        
        self.headImageView = [[UIImageView alloc]init];
        self.headImageView.frame = CGRectMake(2, 2, 40, 40);
        self.headImageView.layer.cornerRadius = 20;
        self.headImageView.layer.masksToBounds = YES;
        
        [self addSubview:backView];
        [backView addSubview:self.headImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    WBAnnotation *ann = self.annotation;
    WBWeibo *weibo = ann.weibo;
    if (weibo.user.portraitImagePath) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:weibo.user.portraitImagePath] options:0 error:nil];
            UIImage *image = [UIImage imageWithData:imageData];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.headImageView.image = image;
            });
        });
    }
}

@end
