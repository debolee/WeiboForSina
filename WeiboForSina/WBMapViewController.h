//
//  WBMapViewController.h
//  WeiboForSina
//
//  Created by BOBO on 15/6/14.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "WBNearbyTableViewController.h"
#import "WBAnnotation.h"
#import "WBWeiboAnnotationView.h"
#import "WBUserAnnotationView.h"

@interface WBMapViewController : UIViewController <MKMapViewDelegate>
@property(nonatomic) nearbyListViewStyle Style;
@property(nonatomic,strong) NSArray *results;
@property (nonatomic)CLLocationCoordinate2D coord;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end
