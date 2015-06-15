//
//  WBWeiboAnnotationView.m
//  WeiboForSina
//
//  Created by BOBO on 15/6/14.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import "WBWeiboAnnotationView.h"


@implementation WBWeiboAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *backImageView = [[UIImageView alloc]init];
        UIImage *image = [[UIImage imageNamed:@"Annotation_background"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 15) resizingMode:UIImageResizingModeStretch];
        backImageView.image = image;
        backImageView.frame = CGRectMake(-80, -60, 160, 60);
        backImageView.contentMode = UIViewContentModeScaleToFill;
        
        self.headImageView = [[UIImageView alloc]init];
        self.headImageView.frame = CGRectMake(8, 10, 36, 36);
        self.text = [[UILabel alloc]initWithFrame:CGRectMake(48, 10, 108, 36)];
        self.text.font = [UIFont systemFontOfSize:8];
        self.text.numberOfLines = 0;
        
        [self addSubview:backImageView];
        [backImageView addSubview:self.headImageView];
        [backImageView addSubview:self.text];
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
    self.text.text = weibo.text;
}

@end
