//
//  WBNearbyTableViewController.h
//  WeiboForSina
//
//  Created by BOBO on 15/6/13.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBWeiboAPI.h"
#import "WBWeiboCell.h"
#import "WBUserInfoCell.h"
#import <CoreLocation/CoreLocation.h>
#import "WBDetailWeiboTableViewController.h"
#import "WBMapViewController.h"
#import "WBWeiboCell.h"
#import "WBSendWeiboViewController.h"

@interface WBNearbyTableViewController : UITableViewController<CLLocationManagerDelegate, WBWeiboCellDelegate>
@property(nonatomic) nearbyListViewStyle Style;
@property(nonatomic, strong)CLLocationManager *manager;
@property(nonatomic,strong) NSArray *results;
@property (nonatomic)CLLocationCoordinate2D coord;
@property (nonatomic, strong) UIButton *toMapViewbutton;
@end
