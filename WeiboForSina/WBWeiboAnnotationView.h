//
//  WBWeiboAnnotationView.h
//  WeiboForSina
//
//  Created by BOBO on 15/6/14.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "WBAnnotation.h"

@interface WBWeiboAnnotationView : MKAnnotationView
@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UILabel *text;
@end
