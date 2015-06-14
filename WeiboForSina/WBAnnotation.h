//
//  WBAnnotation.h
//  WeiboForSina
//
//  Created by BOBO on 15/6/14.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "WBWeibo.h"

@interface WBAnnotation : NSObject<MKAnnotation>
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) WBWeibo *weibo;
// Title and subtitle for use by selection UI.
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

// Called as a result of dragging an annotation view.
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;
@end
